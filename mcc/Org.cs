﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace mcc
{
    internal class Org : ParsedLineWithNoLabel
    {
        public Org(int lineNumber, int orgValue, string label, string content, object[] data) : base(lineNumber, orgValue, label, content, data)
        {
        }

        public override void ParseContent()
        {
            int value, mask;

            base.ParseContent();
            Assert(ParsedLine.GetValueAndMask(this.Content, out value, out mask), ".org: Error parsing value");
            Assert(mask == 0, string.Format(".org: Mask '{0}' not allowed", mask.ToString()));
            Assert(value >= 0, string.Format(".org: Value '{0}' not allowed", mask.ToString()));
            this.OrgValue = value;
        }

        public int GetUpdatedOrgValue(int currentOrgValue)
        {
            return OrgValue < 0 ? currentOrgValue : OrgValue;
        }
    }
}
