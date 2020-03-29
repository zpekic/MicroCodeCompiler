using System;
using System.Collections.Generic;

namespace mcc
{
    internal abstract class MicroField : ParsedLineWithLabel
    {
        public int Width;
        public int Hi;
        public int Lo;
        public int DefaultValue;
        public List<ValueVector> Values = new List<ValueVector>();

        private int MaxValue;

        public struct ValueVector
        {
            public string Name;
            public int From;
            public int To;

            public ValueVector(int value)
            {
                this.Name = string.Empty;
                this.From = value;
                this.To = value;
            }

            public ValueVector(string name, int value)
            {
                this.Name = name;
                this.From = value;
                this.To = value;
            }

            public ValueVector(int from, int to)
            {
                this.Name = string.Empty;
                this.From = from;
                this.To = to;
            }

            public bool IsTarget()
            {
                return string.IsNullOrEmpty(this.Name) && (From < 0) && (To < 0);   // check for the special value for "@"
            }

            public bool Match(int value)
            {
                return ((this.From <= value) && (value <= this.To));
            }

            public bool Match(string token)
            {
                return string.Equals(Name, token, StringComparison.InvariantCultureIgnoreCase);
            }

            public string GetVhdLine(MicroField current)
            {
                if (IsTarget())
                {
                    return "-- Jump targets allowed!";
                }
                else
                {
                    string fromVhd = current.GetVhdConstant(From, current.Hi - current.Lo + 1);
                    string toVhd = current.GetVhdConstant(To, current.Hi - current.Lo + 1);

                    if (string.IsNullOrEmpty(Name))
                    {
                        return $"-- Values from {fromVhd} to {toVhd} allowed";
                    }
                    else
                    {
                        if (From == To)
                        {
                            if (current.Hi == current.Lo)
                            {
                                // constant sam_nop : std_logic := '0';
                                return $"constant {current.Label}_{Name}: \tstd_logic := {toVhd};";
                            }
                            else
                            {
                                // constant color8_black : std_logic_vector(7 downto 0) := "00000000"; 
                                return $"constant {current.Label}_{Name}: \tstd_logic_vector({current.Hi - current.Lo} downto 0) := {toVhd};";
                            }
                        }
                        else
                        {
                            return $"-- Values from {fromVhd} to {toVhd} allowed (check source, ranges are unexpected for named values)";
                        }
                    }
                }
            }
        }

        public MicroField(int lineNumber, int orgValue, string label, string content, object[] data) : base(lineNumber, orgValue, label, content)
        {
            Assert(orgValue < 0, "Definition statement must precede .org");

        }

        public int SetRange(int start)
        {
            Assert(this.Width != 0, "Width is zero");
            //Assert(start >= 0, string.Format("Microinstruction field '{0}' cannot fit", this.Label));
            if (this.Width > 0)
            {   
                // regular field width, start with 
                this.Hi = start;
                this.Lo = start - this.Width + 1;
                System.Console.WriteLine(string.Format("Field '{0}' {1} .. {2}", Label, Hi.ToString(), Lo.ToString()));
                return this.Lo - 1;
            }
            else
            {
                // negative width means overlaps with previous field
                this.Hi = start + this.Width - 1;
                this.Lo = start + 1;
                System.Console.WriteLine(string.Format("Field '{0}' {1} .. {2}", Label, Hi.ToString(), Lo.ToString()));
                return start;
            }
        }

        public override void ParseContent()
        {
            base.ParseContent();

            string widthOrLoHi, values, defaultValue;
            int mask;

            // parse out the content
            Split3(this.Content, "default", out values, out defaultValue);
            Assert(!string.IsNullOrEmpty(defaultValue), "Missing microfield default value");
            Split3(values, "values", out widthOrLoHi, out values);
            Assert(!string.IsNullOrEmpty(widthOrLoHi), "Missing microfield width or span");
            Assert(!string.IsNullOrEmpty(values), "Missing microfield value(s)");

            // for now only support integer width. Negative means overlap with previous field, 0 is not allowed
            Assert(int.TryParse(widthOrLoHi, out this.Width), "Width must be an integer");
            Assert(this.Width != 0, "Width is zero");
            this.MaxValue = (1 << Math.Abs(this.Width)) - 1;

            // populate the values table
            string[] vArray = values.Split(',');
            for (int i = 0; i < vArray.Length; i++)
            {
                int v;

                vArray[i] = vArray[i].Trim();
                if (ParsedLine.GetValueAndMask(vArray[i], out v, out mask))
                {
                    // constant numeric value found
                    // Assert(mask == 0, "Mask not allowed in field definition single value");
                    Values.Add(new ValueVector(CheckRange(v), CheckRange(v + mask)));
                }
                else
                {
                    string from, to;

                    if (Split3(vArray[i], "..", out from, out to))
                    {
                        int f, t;

                        // range found, both should be constant numeric
                        Assert(ParsedLine.GetValueAndMask(from, out f, out mask), "Error parsing field definition lower boundary range value");
                        Assert(mask == 0, "Mask not allowed in field definition range value");
                        Assert(ParsedLine.GetValueAndMask(to, out t, out mask), "Error parsing field definition lower boundary range value");
                        Assert(mask == 0, "Mask not allowed in field definition range value");
                        Values.Add(new ValueVector(CheckRange(f), CheckRange(t)));

                    }
                    else
                    {
                        // symbolic enum or special value found
                        switch (vArray[i])
                        {
                            case "*":
                                Values.Add(new ValueVector(0, this.MaxValue)); // any valid value is ok
                                break;
                            case "@":
                                Values.Add(new ValueVector(-1, -1));    // magic value to indicate accepted jump targets
                                break;
                            default:
                                Values.Add(new ValueVector(vArray[i], CheckRange(i)));
                                break;
                        }
                    }
                }
            }

            Assert(this.Values.Count <= (this.MaxValue + 1), "Too many distinct values (or extra commas) detected");

            // find the default value
            foreach (ValueVector vv in this.Values)
            {
                if (defaultValue.Equals(vv.Name, StringComparison.InvariantCultureIgnoreCase))
                {
                    // found a "named" value
                    this.DefaultValue = vv.From;
                    return;
                }
            }

            ParsedLine.GetValueAndMask(defaultValue, out this.DefaultValue, out mask);
            Assert(mask == 0, "Mask not allowed in default value");
            this.DefaultValue = CheckRange(this.DefaultValue);

        }

        public int FindValue(string token, Dictionary<string, int> targets)
        {
            int value, mask;

            if (string.IsNullOrEmpty(token))
            {
                return DefaultValue;
            }

            if (GetValueAndMask(token, out value, out mask))
            {
                Assert(mask == 0, string.Format("Trying to assign masked value to '{0}'", Label));
                // lookup if in matching any valid range
                foreach(ValueVector v in Values)
                {
                    if (v.Match(value))
                    {
                        return value; // it is ok, found in one of the ranges
                    }
                }
                Assert(true, string.Format("Value '{0}' out of accepted ranges for '{1}'", value.ToString(), Label));
            }
            else
            {
                // lookup by token
                foreach(ValueVector v in Values)
                {
                    if (v.IsTarget())
                    {
                        Assert(targets != null && targets.Count > 0, "No valid then/else targets found");
                        Assert(targets.ContainsKey(token), string.Format("Target '{0}' could not be found", token));
                        return targets[token];
                    }
                    else
                    {
                        if (v.Match(token))
                        {
                            return v.From; // it is ok, found in the lookup table
                        }
                    }
                }
                Assert(true, string.Format("Token '{0}' could not be resolved for '{1}'", token, Label));
            }

            Assert(true, string.Format("Invalid value for '{0}'", Label));
            return DefaultValue; // this should never really be returned here 
        }

        private int CheckRange(int value)
        {
            Assert((value >= 0) && (value <= this.MaxValue), string.Format("Value {0} out of range 0 .. {1}", value.ToString(), this.MaxValue.ToString()));
            return value;
        }
    }
}
