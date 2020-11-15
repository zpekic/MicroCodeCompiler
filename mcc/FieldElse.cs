using System.Text;
using System.Collections.Generic;

namespace mcc
{
    internal class FieldElse : MicroField
    {

        public FieldElse(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".else", lineNumber, orgValue, label, content, logger)
        {
        }

        public override StringBuilder GetVhdlBoilerplateCode(string prefix, List<string> fieldLabels)
        {
            StringBuilder sbCode = new StringBuilder($"-- include '.controller <filename.vhd>, <stackdepth>;' in .mcc file to generate pre-canned microcode control unit and connect 'else' to {prefix}_{Label}");

            return sbCode;
        }

    }

}
