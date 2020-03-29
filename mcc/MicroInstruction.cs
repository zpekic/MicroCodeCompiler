using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//using System.Text.RegularExpressions;

namespace mcc
{
    internal class MicroInstruction: ParsedLine
    {
        private List<ParsedLine> ParsedLines;
        private Dictionary<string, string> registers = new Dictionary<string, string>();
        private Dictionary<string, string> values = new Dictionary<string, string>();
        private string value_if = string.Empty;
        private string value_then = string.Empty;
        private string value_else = string.Empty;

        public MicroInstruction(int lineNumber, int orgValue, string label, string content, List<ParsedLine> parsedLines) : base(lineNumber, orgValue, label, content)
        {
            this.ParsedLines = parsedLines;
        }

        public override void ParseContent()
        {
            base.ParseContent();
            List<string> resolved = ResolveAliases();
            if (resolved.Count > 0)
            {
                TraceListValues(resolved, string.Format("Line {0}: resolved aliases: ", LineNumber.ToString()));
                System.Console.WriteLine(GetParsedLineString());
                System.Console.WriteLine();
            }

            // sanitize microinstruction statements and extract if-then-else and register ( name <= value ) and value (name = value) assignments 
            string[] statements = Content.Split(',');
            for (int i = 0; i < statements.Length; i++)
            {
                string name, temp;
                string statement = statements[i].Trim();

                if (statement.StartsWith("if", System.StringComparison.InvariantCultureIgnoreCase))
                {
                    Assert(string.IsNullOrEmpty(value_if), "if-then-else already defined");
                    Assert(Split3(statement, "then", out value_if, out value_then), "then clause missing in if statement");
                    Assert(Split3(value_if, " ", out temp, out value_if), "if condition could not be parsed");
                    Assert(Split3(value_then, "else", out value_then, out value_else), "else clause missing in if statement");
                }
                else
                {
                    string[] nameValuePair = statements[i].Split('=');
                    Assert(nameValuePair.Length == 2, "Malformed statement found (could be missing comma or semicolon instead of a comma)");
                    if (nameValuePair[0].EndsWith("<"))
                    {
                        name = nameValuePair[0].TrimEnd(new char[] { '<' }).Trim();
                        Assert(!registers.Keys.Contains(name), string.Format("'{0} <= ...' already assigned", name));
                        Assert(!values.Keys.Contains(name), string.Format("'{0} = ...' already assigned", name));
                        registers.Add(name, nameValuePair[1].Trim());
                    }
                    else
                    {
                        name = nameValuePair[0].Trim();
                        Assert(!registers.Keys.Contains(name), string.Format("'{0} <= ...' already assigned", name));
                        Assert(!values.Keys.Contains(name), string.Format("'{0} = ...' already assigned", name));
                        values.Add(name, nameValuePair[1].Trim());
                    }
                }
            }
        }

        public void Project(MemBlock memory, int dataWidth, List<MicroField> fields, Dictionary<string, int> labelOrg)
        {
            StringBuilder uiBuilder = new StringBuilder();

            // assemble the microinstruction word by iterating through all microinstruction fields
            foreach(MicroField mf in fields)
            {
                if (mf is mcc.FieldIf)
                {
                    uiBuilder.Append(GetBinaryString(mf.FindValue(value_if, null), mf.Width));
                    uiBuilder.Append("_");
                    continue;
                }
                if (mf is mcc.FieldThen)
                {
                    uiBuilder.Append(GetBinaryString(mf.FindValue(value_then, labelOrg), mf.Width));
                    uiBuilder.Append("_");
                    continue;
                }
                if (mf is mcc.FieldElse)
                {
                    uiBuilder.Append(GetBinaryString(mf.FindValue(value_else, labelOrg), mf.Width));
                    uiBuilder.Append("_");
                    continue;
                }
                if (mf is mcc.FieldReg)
                {
                    string reg = string.Empty;
                    if (registers.Keys.Contains(mf.Label))
                    {
                        reg = registers[mf.Label];
                        registers.Remove(mf.Label); // means we used it
                    }
                    uiBuilder.Append(GetBinaryString(mf.FindValue(reg, null), mf.Width));
                    uiBuilder.Append("_");
                    continue;
                }
                if (mf is mcc.FieldVal)
                {
                    string val = string.Empty;
                    if (values.Keys.Contains(mf.Label))
                    {
                        val = values[mf.Label];
                        values.Remove(mf.Label); // means we used it
                    }
                    uiBuilder.Append(GetBinaryString(mf.FindValue(val, null), mf.Width));
                    uiBuilder.Append("_");
                    continue;
                }
            }

            // remove last underscore
            uiBuilder.Remove(uiBuilder.Length - 1, 1);

            TraceListValues(registers.Values.ToList<string>(), string.Format("Warning in line {0}: found unmatched <= assignments: ", LineNumber.ToString()));
            TraceListValues(values.Values.ToList<string>(), string.Format("Warning in line {0}: found unmatched = assignments: ", LineNumber.ToString()));

            memory.Write(OrgValue, uiBuilder.ToString(), GetParsedLineString(), false, "Code: ");
        }

        private void TraceListValues(List<string> list, string warning)
        {
            if (list != null && list.Count > 0)
            {
                WriteWarning($"{warning} {GetConcatenatedList(list, new char[] { ',', ' '})}");
            }
        }

        private List<string> ResolveAliases()
        {
            List<string> resolved = new List<string>();

            ParsedLine[] aliasLines = ParsedLines.FindAll(pl => pl.GetType().ToString() == "mcc.Alias").ToArray();

            // aliases are supposed to be compouding, so expand them in opposite order
            for (int pl = aliasLines.Length - 1; pl >= 0; pl--)
            {
                string newContent = " " + this.Content + " "; // pad around to simplify end handling
                Alias alias = (Alias)aliasLines[pl];
                int index = 0;
                string token = "$$$$$$$$$$$$$$$$".Substring(0, alias.Label.Length);

                while (index >= 0)
                {
                    index = newContent.IndexOf(alias.Label, index, StringComparison.InvariantCultureIgnoreCase);
                    if (index >= 0)
                    {
                        char before = newContent[index - 1];
                        char after = newContent[index + alias.Label.Length];
                        bool beforeOk = (before == ' ') || (before == ',');
                        bool afterOk = (after == ' ') || (after == ',') || (after == '=') || (after == '<');
                        if (beforeOk && afterOk)
                        {
                            newContent = newContent.Substring(0, index) + token + newContent.Substring(index + alias.Label.Length);
                        }
                        index++;
                    }
                }

                if (newContent.IndexOf(token, StringComparison.InvariantCultureIgnoreCase) >= 0)
                {
                    this.Content = newContent.Replace(token, alias.Content).Trim(new char[]{' '});
                    resolved.Add(alias.Label);
                }
            }

            return resolved;
        }
    }
}
