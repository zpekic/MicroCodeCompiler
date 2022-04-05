using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace mcc
{
    internal class Sub : ParsedLineWithLabel
    {
        public string[] RegNames = null;   // assume no "call" parameters

        public Sub(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".sub", lineNumber, orgValue, label, content, logger)
        {
        }

        public override void ParseContent()
        {
            base.ParseContent();
            if (!string.IsNullOrEmpty(this.Content))
            {
                RegNames = this.Content.Split(',');
                for (int i = 0; i < RegNames.Length; i++)
                {
                    RegNames[i] = RegNames[i].Trim();
                }
            }
        }

        public bool CheckParams(List<MicroField> fields)
        {
            if (RegNames != null)
            {
                foreach (string regName in RegNames)
                {
                    List<MicroField> matches = fields.FindAll(f => regName.Equals(f.Label, StringComparison.InvariantCultureIgnoreCase));
                    Assert(matches != null && matches.Count == 1, $"Parameter '{regName}' not found or duplicated");
                    Assert(matches[0].IsValidSubParameter(regName), $"Parameter '{regName}' must refer to .regvalue");
                }
            }

            return true;
        }
    }
}
