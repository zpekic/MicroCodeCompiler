using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace mcc
{
    internal class Org : ParsedLineWithNoLabel
    {
        public Org(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".org", lineNumber, orgValue, label, content, logger)
        {
        }

        public override void ParseContent()
        {
            int value, mask;

            base.ParseContent();
            Assert(GetValueAndMask(this.Content, out value, out mask, null), ".org: Error parsing value");
            Assert(mask == 0, string.Format(".org: Mask '{0}' not allowed", mask.ToString()));
            Assert(value >= 0, string.Format(".org: Value '{0}' not allowed", mask.ToString()));
            this.OrgValue = value;
        }

        public int GetUpdatedOrgValue(int currentOrgValue)
        {
            if (OrgValue < 0)
            {
                return currentOrgValue;
            }
            else
            {
                Assert(OrgValue >= currentOrgValue, $"Trying to set .org value to {OrgValue} (0x{OrgValue:X4}) which is below current value of {currentOrgValue} (0x{currentOrgValue:X4}).");

                logger.WriteLine($"Warning: .org value changed from {currentOrgValue} (0x{currentOrgValue:X4}) to {OrgValue} (0x{OrgValue:X4})");
                return OrgValue;
            }
        }
    }
}
