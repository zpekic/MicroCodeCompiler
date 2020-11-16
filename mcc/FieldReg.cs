using System.Text;
using System.Collections.Generic;

namespace mcc
{
    internal class FieldReg : MicroField
    {
        public FieldReg(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".regfield", lineNumber, orgValue, label, content, logger)
        {

        }

        public override StringBuilder GetVhdlBoilerplateCode(string prefix, List<string> fieldLabels)
        {
            StringBuilder sbCode = new StringBuilder();

            sbCode.AppendLine("---- Start boilerplate code (use with utmost caution!)");
            sbCode.AppendLine($"-- update_{Label}: process(clk, {prefix}_{Label})");
            sbCode.AppendLine("-- begin");
            sbCode.AppendLine("--	if (rising_edge(clk)) then");

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
            sbCode.AppendLine("-- end if;");
            sbCode.AppendLine("-- end process;");

            sbCode.Append("---- End boilerplate code");
            return sbCode;
        }
    }

}
