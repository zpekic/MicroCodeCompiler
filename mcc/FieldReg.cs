using System.Text;
using System.Collections.Generic;

namespace mcc
{
    internal class FieldReg : MicroField
    {
        public FieldReg(int lineNumber, int orgValue, string label, string content, Logger logger) : base(lineNumber, orgValue, label, content, logger)
        {

        }

        public override StringBuilder GetVhdlBoilerplateCode(string prefix, List<string> fieldLabels)
        {
            StringBuilder sbCode = new StringBuilder();

            sbCode.AppendLine("---- Start boilerplate code (use with utmost caution!)");
            sbCode.AppendLine($"-- update_{Label}: process(clk, {prefix}_{Label})");
            sbCode.AppendLine("-- begin");
            sbCode.AppendLine("--	if (rising_edge(clk)) then");

            if (Width == 1)
            {
                foreach (ValueVector vv in Values)
                {
                    string foundLabel = fieldLabels.Find(fl => string.Equals(fl, vv.Name, System.StringComparison.InvariantCultureIgnoreCase));
                    foundLabel = string.IsNullOrEmpty(foundLabel) ? vv.Name : foundLabel;

                    if (!vv.Match(this.DefaultValue))
                    {
                        sbCode.AppendLine($"--	    if ({prefix}_{Label} = {Label}_{vv.Name}) then");
                        sbCode.AppendLine($"--		    {Label} <= {foundLabel};");
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
                    string foundLabel = fieldLabels.Find(fl => string.Equals(fl, vv.Name, System.StringComparison.InvariantCultureIgnoreCase));
                    foundLabel = string.IsNullOrEmpty(foundLabel) ? vv.Name : foundLabel;

                    if (vv.Match(this.DefaultValue))
                    {
                        appendOthers = true;
                        sbCode.AppendLine($"----			when {Label}_{vv.Name} =>");
                        sbCode.AppendLine($"----				{Label} <= {Label};");
                        continue;
                    }
                    if  (vv.Name.StartsWith("zero", System.StringComparison.InvariantCultureIgnoreCase) || vv.Name.StartsWith("clear", System.StringComparison.InvariantCultureIgnoreCase))
                    {
                        sbCode.AppendLine($"--			when {Label}_{vv.Name} =>");
                        sbCode.AppendLine($"--				{Label} <= (others => '0');");
                        continue;
                    }
                    if (vv.Name.StartsWith("inc", System.StringComparison.InvariantCultureIgnoreCase))
                    {
                        sbCode.AppendLine($"--			when {Label}_{vv.Name} =>");
                        sbCode.AppendLine($"--				{Label} <= std_logic_vector(unsigned({Label}) + 1);");
                        continue;
                    }
                    if (vv.Name.StartsWith("dec", System.StringComparison.InvariantCultureIgnoreCase))
                    {
                        sbCode.AppendLine($"--			when {Label}_{vv.Name} =>");
                        sbCode.AppendLine($"--				{Label} <= std_logic_vector(unsigned({Label}) - 1);");
                        continue;
                    }
                    if (vv.Name.StartsWith("com", System.StringComparison.InvariantCultureIgnoreCase))
                    {
                        sbCode.AppendLine($"--			when {Label}_{vv.Name} =>");
                        sbCode.AppendLine($"--				{Label} <= {Label} xor (others => '1');");
                        continue;
                    }
                    if (vv.Name.StartsWith("neg", System.StringComparison.InvariantCultureIgnoreCase))
                    {
                        sbCode.AppendLine($"--			when {Label}_{vv.Name} =>");
                        sbCode.AppendLine($"--				{Label} <= std_logic_vector(unsigned({Label} xor (others => '1')) + 1);");
                        continue;
                    }
                    if (vv.Name.StartsWith("-", System.StringComparison.InvariantCultureIgnoreCase))
                    {
                        appendOthers = true;
                    }
                    else
                    {
                        sbCode.AppendLine($"--			when {Label}_{vv.Name} =>");
                        // give up second guessing...
                        sbCode.AppendLine($"--				{Label} <= {foundLabel};");                        }
                    }

                if (appendOthers)
                {
                    sbCode.AppendLine("--			when others =>");
                    sbCode.AppendLine("--				null;");
                }
                sbCode.AppendLine("--		end case;");

            }
            sbCode.AppendLine("-- end;");
            sbCode.AppendLine("-- end process;");

            sbCode.Append("---- End boilerplate code");
            return sbCode;
        }
    }

}
