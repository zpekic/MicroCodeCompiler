using System.Text;
using System.Collections.Generic;

namespace mcc
{
    internal class FieldThen : MicroField
    {

        public FieldThen(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".then", lineNumber, orgValue, label, content, logger, null)
        {
        }

        public override StringBuilder GetVhdlBoilerplateCode(string prefix, List<string> fieldLabels)
        {
            StringBuilder sbCode = new StringBuilder($"-- include '.controller <filename.vhd>, <stackdepth>;' in .mcc file to generate pre-canned microcode control unit and connect 'then' to {prefix}_{Label}");

            return sbCode;
        }

        public override void CheckFieldWidth(int power2Width)
        {
            Assert((1 << this.Width) == power2Width, $".then field width {this.Width} not matching code size of {power2Width} microinstructions");
        }
    }

}
