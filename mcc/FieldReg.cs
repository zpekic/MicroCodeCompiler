using System.Text;
using System.Collections.Generic;

namespace mcc
{
    internal class FieldReg : MicroField
    {
        public FieldReg(int lineNumber, int orgValue, string label, string content, Logger logger, List<ParsedLine> parsedLines) : base(".regfield", lineNumber, orgValue, label, content, logger, parsedLines)
        {

        }

        public override bool IsValidSubParameter(string name)
        {
            return string.IsNullOrEmpty(name) ? false : name.Equals(this.Label, System.StringComparison.InvariantCultureIgnoreCase);
        }

        public override StringBuilder GetVhdlBoilerplateCode(string prefix, List<string> fieldLabels, bool isRisingEdge)
        {
            StringBuilder sbCode = new StringBuilder();
            bool includeReset = (this.ResetValue >= 0);

            sbCode.AppendLine("---- Start boilerplate code (use with utmost caution!)");
            if (includeReset)
            {
                sbCode.AppendLine($"-- update_{Label}: process(clk, {prefix}_{Label}, reset)");
                sbCode.AppendLine("-- begin");
                sbCode.AppendLine("--	if (reset = '1') then");

                // try to figure out reset assignment?
                string resetLine = $"--			{Label} <= TODO;";
                foreach (ValueVector vv in Values)
                {
                    if (vv.Match(this.ResetValue))
                    {
                        resetLine = $"--		{Label} <= {GuessVhdlExpressionFromName(Label, vv.Name, fieldLabels)};";
                        break;
                    }
                }
                sbCode.AppendLine(resetLine);
                sbCode.AppendLine("--	else");
            }
            else
            {
                sbCode.AppendLine($"-- update_{Label}: process(clk, {prefix}_{Label})");
                sbCode.AppendLine("-- begin");
            }
            sbCode.AppendLine(isRisingEdge ? "--	if (rising_edge(clk)) then" : "--	if (falling_edge(clk)) then");

            if (HasNamedValues())
            {
                if (Width == 1)
                {
                    foreach (ValueVector vv in Values)
                    {
                        if (!vv.Match(this.DefaultValue))
                        {
                            sbCode.AppendLine($"--	    if ({prefix}_{Label} = {Label}_{vv.Name}) then");
                            sbCode.AppendLine($"--		    {Label} <= {GuessVhdlExpressionFromName(Label, vv.Name, fieldLabels)};");
                            sbCode.AppendLine($"--	    end if;");
                            continue;
                        }
                    }
                }
                else
                {
                    bool appendOthers = false;
                    sbCode.AppendLine($"--		case {prefix}_{Label} is");

                    foreach (ValueVector vv in Values)
                    {
                        if (vv.Match(this.DefaultValue))
                        {
                            appendOthers = true;
                            sbCode.AppendLine($"----			when {Label}_{vv.Name} =>");
                            sbCode.AppendLine($"----				{Label} <= {Label};");
                            continue;
                        }
                        if (vv.Name.StartsWith("-", System.StringComparison.InvariantCultureIgnoreCase))
                        {
                            appendOthers = true;
                        }
                        else
                        {
                            sbCode.AppendLine($"--			when {Label}_{vv.Name} =>");
                            sbCode.AppendLine($"--				{Label} <= {GuessVhdlExpressionFromName(Label, vv.Name, fieldLabels)};");
                        }
                    }

                    if (appendOthers)
                    {
                        sbCode.AppendLine("--			when others =>");
                        sbCode.AppendLine("--				null;");
                    }
                    sbCode.AppendLine("--		end case;");

                }
            }
            else
            {
                sbCode.AppendLine($"--  {Label} <= {prefix}_{Label};");
            }
            if (includeReset)
            {
                sbCode.AppendLine("-- end if;");
            }
            sbCode.AppendLine("-- end if;");
            sbCode.AppendLine("-- end process;");

            sbCode.Append("---- End boilerplate code");
            return sbCode;
        }
    }

}
