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

        public struct FieldData
        {
            public string Label;
            public bool IsEmpty;
            public string Value;
            public string Description;

            public FieldData(string label, bool isEmpty, string value, string description)
            {
                this.Label = label;
                this.IsEmpty = isEmpty;
                this.Value = value;
                this.Description = description;
            }
        }

        public MicroInstruction(int lineNumber, int orgValue, string label, string content, List<ParsedLine> parsedLines, Logger logger) : base("", lineNumber, orgValue, label, content, logger)
        {
            this.ParsedLines = parsedLines;
        }

        public override void ParseContent()
        {
            base.ParseContent();
            List<string> resolved = ResolveAliases();
            if (resolved.Count > 0)
            {
                TraceListValues(resolved, string.Format("Line {0}: resolved aliases: ", LineNumber.ToString()), false);
                logger.WriteLine(GetParsedLineString());
                logger.WriteLine(string.Empty);
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
                    if (!Split3(value_then, "else", out value_then, out value_else))
                    {
                        logger.WriteLine($"Warning: else clause missing in if statement, default value '{value_else}' will be used");
                    }
                }
                else
                {
                    string[] nameValuePair = new string[2];
                    Assert(Split3(statements[i], "=", out nameValuePair[0], out nameValuePair[1]), $"Statement '{statements[i]}' not recognized (unresolved alias or comma/semicolon confusion)");
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
            StringBuilder miBuilder = new StringBuilder();
            String bStr;
            List<FieldData> fdList = new List<FieldData>();

            // assemble the microinstruction word by iterating through all microinstruction fields
            foreach(MicroField mf in fields)
            {
                if (mf is mcc.FieldIf)
                {
                    bStr = GetBinaryString(mf.FindValue(value_if, null, LineNumber), mf.Width);
                    fdList.Add(new FieldData(".if", false, $"{bStr}_", $" if ({bStr})"));
                    //uiBuilder.Append($"{bStr}_");
                    //miBuilder.Append($" if ({bStr})");
                    continue;
                }
                if (mf is mcc.FieldThen)
                {
                    bStr = GetBinaryString(mf.FindValue(value_then, labelOrg, LineNumber), mf.Width);
                    fdList.Add(new FieldData(".then", false, $"{bStr}_", $" then {bStr}"));
                    //uiBuilder.Append($"{bStr}_");
                    //miBuilder.Append($" then {bStr}");
                    continue;
                }
                if (mf is mcc.FieldElse)
                {
                    bStr = GetBinaryString(mf.FindValue(value_else, labelOrg, LineNumber), mf.Width);
                    fdList.Add(new FieldData(".else", string.IsNullOrEmpty(value_else), $"{bStr}_", $" else {bStr},"));
                    //uiBuilder.Append($"{bStr}_");
                    //miBuilder.Append($" else {bStr},");
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
                    // TODO: replace FindValue() with EvaluateExpression()
                    bStr = GetBinaryString(mf.FindValue(reg, labelOrg, LineNumber), Math.Abs(mf.Width));
                    if (mf.Width > 0)
                    {
                        // regular field, just add it
                        fdList.Add(new FieldData(mf.Label, string.IsNullOrEmpty(reg), $"{bStr}_", $" {mf.Label} <= {bStr},"));
                    }
                    else
                    {
                        // replacement field
                        if (!string.IsNullOrEmpty(reg))
                        {
                            ReplaceOverlappedFields(mf, fdList, $"{bStr}_", $" {mf.Label} <= {bStr},");
                        }
                    }
                    //uiBuilder.Append($"{bStr}_");
                    //miBuilder.Append($" {mf.Label} <= {bStr},");
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
                    // TODO: replace FindValue() with EvaluateExpression()
                    bStr = GetBinaryString(mf.FindValue(val, labelOrg, LineNumber), Math.Abs(mf.Width));
                    if (mf.Width > 0)
                    {
                        // regular field, just add it
                        fdList.Add(new FieldData(mf.Label, string.IsNullOrEmpty(val), $"{bStr}_", $" {mf.Label} = {bStr},"));
                    }
                    else
                    {
                        // replacement field
                        if (!string.IsNullOrEmpty(val))
                        {
                            ReplaceOverlappedFields(mf, fdList, $"{bStr}_", $" {mf.Label} = {bStr},");
                        }
                    }
                    //uiBuilder.Append($"{bStr}_");
                    //miBuilder.Append($" {mf.Label} = {bStr},");
                    continue;
                }
            }

            // put together data and description strings
            foreach(FieldData fd in fdList)
            {
                if (!string.IsNullOrEmpty(fd.Label))
                {
                    uiBuilder.Append(fd.Value);
                    miBuilder.Append(fd.Description);
                }
            }
            // remove last underscore
            uiBuilder.Remove(uiBuilder.Length - 1, 1);
            // remove last colon and add semicolon
            miBuilder.Remove(miBuilder.Length - 1, 1);
            miBuilder.Append(";");

            TraceListValues(registers.Keys.ToList<string>(), "Found unmatched <= assignments: ", true);
            TraceListValues(values.Keys.ToList<string>(), "Found unmatched = assignments: ", true);

            memory.Write(OrgValue, uiBuilder.ToString(), GetParsedLineString(), miBuilder.ToString(), false, "code");
        }

        private void ReplaceOverlappedFields(MicroField mf, List<FieldData> fdList, string value, string description)
        {
            // not empty, check if all fields to replace with are empty.
            bool replace = true;
            foreach (MicroField of in mf.OverlappingFields)
            {
                for (int i = 0; i < fdList.Count; i++)
                {
                    FieldData fd = fdList[i];
                    if (of.Label.Equals(fd.Label, StringComparison.InvariantCultureIgnoreCase))
                    {
                        Assert(fd.IsEmpty, $"Field '{fd.Label}' cannot be replaced with field '{of.Label}' because it is not empty.");     // If at least one is not empty, that is an error
                        if (replace)
                        {
                            fd.Label = of.Label;
                            fd.IsEmpty = false;
                            fd.Value = value;
                            fd.Description = description;
                            replace = false;
                        }
                        else
                        {
                            fd.Label = null;    // invalidate it
                        }
                    }
                }
            }
        }

        private void TraceListValues(List<string> list, string warning, bool fatal)
        {
            if (list != null && list.Count > 0)
            {
                string warningWithList = $"{warning} {GetConcatenatedList(list, new char[] { ',', ' ' })}";

                if (fatal)
                {
                    Assert(false, warningWithList);
                }
                else
                {
                    logger.WriteLine(warningWithList);
                }
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
