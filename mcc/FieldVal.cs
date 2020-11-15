using System.Text;
using System.Collections.Generic;

namespace mcc
{
    internal class FieldVal : MicroField
    {
        public int From;
        public int To;

        public FieldVal(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".valfield", lineNumber, orgValue, label, content, logger)
        {
            this.From = -1;
            this.To = -1;
        }

        public override StringBuilder GetVhdlBoilerplateCode(string prefix, List<string> fieldLabels)
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
                            sbCode.Append($"--      {GuessVhdlExpressionFromName(Label, vv.Name, fieldLabels)} when {prefix}_{vv.Name}");
                            bool isDefault = vv.Match(this.DefaultValue);
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

                    if (appendOthers)
                    {
                        sbCode.AppendLine("--      null when others;");
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
