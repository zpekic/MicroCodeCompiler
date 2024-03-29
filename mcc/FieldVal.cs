﻿using System.Text;
using System.Collections.Generic;

namespace mcc
{
    internal class FieldVal : MicroField
    {
        public int From;
        public int To;

        public FieldVal(int lineNumber, int orgValue, string label, string content, Logger logger, List<ParsedLine> parsedLines) : base(".valfield", lineNumber, orgValue, label, content, logger, parsedLines)
        {
            this.From = -1;
            this.To = -1;
        }

        public override StringBuilder GetVhdlBoilerplateCode(string prefix, List<string> fieldLabels, bool risingEdge)
        {
            StringBuilder sbCode = new StringBuilder();

            sbCode.AppendLine("---- Start boilerplate code (use with utmost caution!)");

            if (HasNamedValues())
            {
                if (Width == 1)
                {
                    string otherName = "TODO";
                    string defaultName = "TODO";

                    foreach (ValueVector vv in Values)
                    {

                        if (vv.Match(this.DefaultValue))
                        {
                            defaultName = vv.Name;
                        }
                        else
                        {
                            otherName = vv.Name;
                        }
                    }

                    string otherValue = GuessVhdlExpressionFromName(Label, otherName, fieldLabels);
                    string defaultValue = GuessVhdlExpressionFromName(Label, defaultName, fieldLabels);

                    sbCode.AppendLine($"--	{Label} <= {otherValue} when ({prefix}_{Label} = {Label}_{otherName}) else {defaultValue};");
                }
                else
                {
                    bool appendOthers = false;
                    int count = 0;
                    string defaultExpression = null;
                    sbCode.AppendLine($"-- with {prefix}_{Label} select {Label} <=");

                    foreach (ValueVector vv in Values)
                    {
                        count++;
                        if (vv.Name.StartsWith("-", System.StringComparison.InvariantCultureIgnoreCase))
                        {
                            appendOthers = true;
                        }
                        else
                        {
                            string[] altNames = vv.Name.Split('|');   // filter out alternate names
                            string expression = GuessVhdlExpressionFromName(Label, altNames[0], fieldLabels);
                            bool isDefault = false;

                            for (int i = 0; i < altNames.Length; i++)
                            {
                                // BUGBUG: comma and semicolon on last lines are messed up!
                                //if (i == 0)
                                //{
                                    sbCode.Append($"--      {expression} when {Label}_{altNames[i]}");
                                //}
                                //else
                                //{
                                //    sbCode.AppendLine($"--      {expression} when {Label}_{altNames[i]}");
                                //}

                                if (vv.Match(this.DefaultValue))
                                {
                                    isDefault = true;
                                    defaultExpression = expression;
                                }
                                if (!appendOthers && (count == Values.Count))
                                {
                                    sbCode.AppendLine(isDefault ? "; -- default value" : ";");
                                }
                                else
                                {
                                    sbCode.AppendLine(isDefault ? ", -- default value" : ",");
                                }
                            }
                        }
                    }

                    if (appendOthers)
                    {
                        if (string.IsNullOrEmpty(defaultExpression))
                        {
                            sbCode.AppendLine("--      (others => '0') when others;");
                        }
                        else
                        {
                            sbCode.AppendLine($"--      {defaultExpression} when others;");
                        }
                    }

                }
            }
            else
            {
                sbCode.AppendLine($"--  {Label} <= {prefix}_{Label};");
            }
            sbCode.Append("---- End boilerplate code");
            return sbCode;
        }
    }

}
