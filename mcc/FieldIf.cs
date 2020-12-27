using System.Text;
using System.Collections.Generic;

namespace mcc
{
    internal class FieldIf : MicroField
    {

        public FieldIf(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".if", lineNumber, orgValue, label, content, logger, null)
        {
        }

        public override StringBuilder GetVhdlBoilerplateCode(string prefix, List<string> fieldLabels)
        {
            StringBuilder sbCode = new StringBuilder();

            sbCode.AppendLine("---- Start boilerplate code (use with utmost caution!)");
            sbCode.AppendLine("---- include '.controller <filename.vhd>, <stackdepth>;' in .mcc file to generate pre-canned microcode control unit and feed 'conditions' with:");

            foreach (ValueVector vv in Values)
            {
                if (vv.Name.StartsWith("true", System.StringComparison.InvariantCultureIgnoreCase))
                {
                    sbCode.AppendLine($"--  cond({Label}_{vv.Name}) => '1',");
                    continue;
                }
                if (vv.Name.StartsWith("false", System.StringComparison.InvariantCultureIgnoreCase))
                {
                    sbCode.AppendLine($"--  cond({Label}_{vv.Name}) => '0',");
                    continue;
                }
                sbCode.AppendLine($"--  cond({Label}_{vv.Name}) => {vv.Name},");
            }

            sbCode.Append("---- End boilerplate code");
            return sbCode;
        }

    }

}
