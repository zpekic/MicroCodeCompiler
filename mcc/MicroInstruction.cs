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
        private static ParsedLine[] aliasLines;
        
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
            // glue together chopped up sub(param, param, ...) calls
            int callStart = -1;
            for (int i = 0; i < statements.Length; i++)
            {
                string statement = statements[i].Trim();
                statements[i] = statement;
                if (callStart < 0)
                {
                    Assert(!statement.EndsWith(")") || statement.Contains("("), "misformed subroutine call");

                    if (statement.Contains("(") && !statement.EndsWith(")"))
                    {
                        callStart = i;
                    }
                }
                else
                {
                    Assert(!statement.Contains("(") || statement.EndsWith(")"), "misformed subroutine call");

                    statements[callStart] += ',';
                    statements[callStart] += statement;
                    if (statement.EndsWith(")") && !statement.Contains("("))
                    {
                        callStart = -1;
                    }
                    statements[i] = string.Empty;
                }
            }

            // process them
            for (int i = 0; i < statements.Length; i++)
            {
                string name, temp;
                string statement = statements[i]; // already trimmed

                if (!string.IsNullOrEmpty(statement))
                {
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
                        if (statements[i].EndsWith(")"))
                        {
                            string subLabel, subParams;
                            string[] regValues = null;

                            // check if valid ".sub call"
                            Assert(Split3(statements[i].Remove(statements[i].Length - 1, 1), "(", out subLabel, out subParams), $"Statement '{statements[i]}' not recognized as valid .sub call");
                            Assert(!string.IsNullOrEmpty(subLabel), "subroutine call without a label");
                            Assert(string.IsNullOrEmpty(value_if) && string.IsNullOrEmpty(value_then) && string.IsNullOrEmpty(value_else), "if-then-else already defined (subroutine call is uses '.if <defaultCond> then <label> else <label>' to call <label>())");

                            if (!string.IsNullOrEmpty(subParams))
                            {
                                regValues = subParams.Split(',');
                            }

                            foreach (ParsedLine parsedLine in ParsedLines)
                            {
                                FieldIf fif = parsedLine as FieldIf;
                                if (fif != null)
                                {
                                    value_if = fif.GetDefaultValue();
                                }
                                Sub sub = parsedLine as Sub;
                                if (sub != null && subLabel.Equals(sub.Label, StringComparison.InvariantCultureIgnoreCase))
                                {
                                    value_then = subLabel;
                                    value_else = subLabel;
                                    // now match optional parameters (these all need to be <register> <= value)
                                    if (regValues == null)
                                    {
                                        if (sub.RegNames != null)
                                        {
                                            Assert(false, $"Call to '{subLabel}' requires {sub.RegNames.Length} parameter(s)");
                                        }
                                    }
                                    else
                                    {
                                        Assert(sub.RegNames != null, $"Call to '{subLabel}' does not allow any parameters");
                                        Assert(sub.RegNames.Length == regValues.Length, $"'{subLabel}' called with {regValues.Length} parameter(s) and requires {sub.RegNames.Length}");
                                        // generate assignments
                                        for (int param = 0; param < sub.RegNames.Length; param++)
                                        {
                                            string regName = sub.RegNames[param];

                                            Assert(!registers.Keys.Contains(regName), $"'{regName} <= ...' already assigned");
                                            Assert(!values.Keys.Contains(regName), $"'{regName} = ...' already assigned");
                                            registers.Add(regName, regValues[param]);
                                        }
                                    }
                                }
                            }

                            // double check the if default then label else label 
                            Assert(!string.IsNullOrEmpty(value_if), "default condition not found for '{subLabel}' (subroutine call is uses '.if <defaultCond> then <label> else <label>' to call <label>())");
                            Assert(!string.IsNullOrEmpty(value_then) && !string.IsNullOrEmpty(value_else), ".sub label '{subLabel}' not defined");

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
                    continue;
                }
                if (mf is mcc.FieldThen)
                {
                    bStr = GetBinaryString(mf.FindValue(value_then, labelOrg, LineNumber), mf.Width);
                    fdList.Add(new FieldData(".then", false, $"{bStr}_", $" then {bStr}"));
                    continue;
                }
                if (mf is mcc.FieldElse)
                {
                    bStr = GetBinaryString(mf.FindValue(value_else, labelOrg, LineNumber), mf.Width);
                    fdList.Add(new FieldData(".else", string.IsNullOrEmpty(value_else), $"{bStr}_", $" else {bStr},"));
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
                            ReplaceOverlappedFields(mf.OverlappingFields, ref fdList, $".regfield { mf.Label}");
                            fdList.Add(new FieldData(mf.Label, string.IsNullOrEmpty(reg), $"{bStr}_", $" {mf.Label} = {bStr},"));
                        }
                    }
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
                            ReplaceOverlappedFields(mf.OverlappingFields, ref fdList, $".valfield { mf.Label}");
                            fdList.Add(new FieldData(mf.Label, string.IsNullOrEmpty(val), $"{bStr}_", $" {mf.Label} = {bStr},"));
                        }
                    }
                    continue;
                }
            }

            // put together data and description strings
            foreach (FieldData fd in fdList)
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

        private void ReplaceOverlappedFields(List<MicroField> overlappingFields, ref List<FieldData> fdList, string err)
        {
            foreach (MicroField of in overlappingFields)
            {
                FieldData fd = fdList.Find(x => x.Label.Equals(of.Label, StringComparison.InvariantCultureIgnoreCase));
                if (!string.IsNullOrEmpty(fd.Label))
                {
                    Assert(fd.IsEmpty, $"{err} is trying to replace field '{fd.Label}' which is not empty");
                    fdList.Remove(fd);
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

            if (aliasLines == null)
            {
                aliasLines = ParsedLines.FindAll(pl => pl.GetType().ToString() == "mcc.Alias").ToArray();
            }
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
