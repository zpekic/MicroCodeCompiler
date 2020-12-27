using System;
using System.Collections.Generic;
using System.Text;

namespace mcc
{
    internal abstract class MicroField : ParsedLineWithLabel
    {
        public int Width;
        public int Hi;
        public int Lo;
        public int DefaultValue;
        public List<ValueVector> Values = new List<ValueVector>();
        public List<MicroField> OverlappingFields = new List<MicroField>();
        private List<ParsedLine> ParsedLines;

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

            public string GetVhdLine(MicroField current, bool isIfField)
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
                        if (fromVhd.Equals(toVhd, StringComparison.InvariantCultureIgnoreCase))
                        {
                            return $"-- Value {fromVhd} allowed";
                        }
                        else
                        {
                            return $"-- Values from {fromVhd} to {toVhd} allowed";
                        }
                    }
                    else
                    {
                        bool allowed = char.IsLetter(Name[0]);

                        if (From == To)
                        {
                            if (current.Hi == current.Lo)
                            {
                                if (allowed)
                                {
                                    return $"constant {current.Label}_{Name}: \tstd_logic := {toVhd};";
                                }
                                else
                                {
                                    return $"-- Value {fromVhd} not allowed (name '{Name}' is not assignable)";
                                }
                            }
                            else
                            {
                                if (isIfField)
                                {
                                    return $"constant {current.Label}_{Name}: \tinteger := {this.To};";
                                }
                                else
                                {
                                    if (allowed)
                                    {
                                        return $"constant {current.Label}_{Name}: \tstd_logic_vector({current.Hi - current.Lo} downto 0) := {toVhd};";
                                    }
                                    else
                                    {
                                        return $"-- Value {toVhd} not allowed (name '{Name}' is not assignable)";
                                    }
                                }
                            }
                        }
                        else
                        {
                            if (allowed)
                            {
                                return $"-- Values from {fromVhd} to {toVhd} allowed (check source, ranges are unexpected for named values)";
                            }
                            else
                            {
                                return $"-- Values {fromVhd} to {toVhd} not allowed (name '{Name}' is not assignable)";
                            }
                        }
                    }
                }
            }
        }

        public MicroField(string statement, int lineNumber, int orgValue, string label, string content, Logger logger, List<ParsedLine> parsedLines) : base(statement, lineNumber, orgValue, label, content, logger)
        {
            Assert(orgValue < 0, "Definition statement must precede .org");
            this.ParsedLines = parsedLines;
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
                logger.WriteLine($"Field '{Label}' {Hi.ToString()} .. {Lo.ToString()}");
                return this.Lo - 1;
            }
            else
            {
                // negative width means overlaps with previous field(s)
                StringBuilder overlapList = new StringBuilder();
                this.Hi = 0;
                this.Lo = int.MaxValue;

                foreach(MicroField mf in OverlappingFields)
                {
                    if (overlapList.Length > 0)
                    {
                        overlapList.Append(", ");
                    }
                    // the assumption here is that overlapping fields are contiguous
                    this.Hi = Math.Max(this.Hi, mf.Hi);
                    this.Lo = Math.Min(this.Lo, mf.Lo);
                    overlapList.Append(mf.Label);
                }
                Assert((this.Lo - this.Hi - 1 ) == this.Width, $"Field '{Label}': length mismatch (from {this.Hi} down to {this.Lo} does not cover {this.Width} positions");
                logger.WriteLine($"Field '{Label}' {Hi.ToString()} .. {Lo.ToString()} overlaps with: {overlapList.ToString()}");
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

            // for now only support integer width. Negative means overlap with other fields, 0 is not allowed
            if (int.TryParse(widthOrLoHi, out this.Width))
            {
                Assert(this.Width > 0, "Invalid field width: must be an integer > 0, or specify a <fromfield> [.. <tofield>] span of previously defined field(s) for overlap");
            }
            else
            {
                string fromFieldLabel = null, toFieldLabel = null;
                MicroField fromField = null, toField = null;

                Assert(!string.IsNullOrEmpty(widthOrLoHi), "Missing field width: must be an integer > 0, or specify a <fromfield> [.. <tofield>] of previously defined field(s) for overlap");
                Split3(widthOrLoHi, "..", out fromFieldLabel, out toFieldLabel);

                foreach(ParsedLine pl in ParsedLines)
                {
                    MicroField currentField = pl as MicroField;
                    if (currentField != null)
                    {
                        if (fromField == null)
                        {
                            if (currentField.Label.Equals(fromFieldLabel, StringComparison.InvariantCultureIgnoreCase))
                            {
                                fromField = currentField;
                                fromField.OverlappingFields.Add(this);
                                this.OverlappingFields.Add(fromField);
                                this.Width = fromField.Width;
                                if (string.IsNullOrEmpty(toFieldLabel) || toFieldLabel.Equals(fromFieldLabel, StringComparison.InvariantCultureIgnoreCase))
                                {
                                    toFieldLabel = fromFieldLabel;
                                    toField = currentField;
                                    break;
                                }
                            }
                        }
                        else
                        {
                            currentField.OverlappingFields.Add(this);
                            this.OverlappingFields.Add(currentField);
                            this.Width += currentField.Width;
                            if (currentField.Label.Equals(toFieldLabel, StringComparison.InvariantCultureIgnoreCase))
                            {
                                toField = currentField;
                                break;
                            }
                        }
                    }
                }
                CheckOverlapField(fromField, fromFieldLabel);
                CheckOverlapField(toField, toFieldLabel);

                this.Width = - this.Width; // should be negative to indicate overlapping field
                Assert(this.Width < 0, "Bad field width");
            }
            this.MaxValue = (1 << Math.Abs(this.Width)) - 1;

            // populate the values table
            string[] vArray = values.Split(',');
            for (int i = 0; i < vArray.Length; i++)
            {
                int v;

                vArray[i] = vArray[i].Trim();
                if (GetValueAndMask(vArray[i], out v, out mask, null))
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
                        Assert(GetValueAndMask(from, out f, out mask, null), "Error parsing field definition lower boundary range value");
                        Assert(mask == 0, "Mask not allowed in field definition range value");
                        Assert(GetValueAndMask(to, out t, out mask, null), "Error parsing field definition lower boundary range value");
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

            Assert(GetValueAndMask(defaultValue, out this.DefaultValue, out mask, null), $"Default value '{defaultValue}' could not be resolved");
            Assert(mask == 0, "Mask not allowed in default value");
            this.DefaultValue = CheckRange(this.DefaultValue);
        }

        protected bool HasNamedValues()
        {
            foreach (ValueVector vv in Values)
            {
                if (!string.IsNullOrEmpty(vv.Name))
                {
                    return true;
                }
            }

            return false;
        }

        protected string GuessVhdlExpressionFromName(string fieldName, string valueName, List<string> fieldLabels)
        {
            if (valueName.StartsWith("zero", System.StringComparison.InvariantCultureIgnoreCase) || valueName.StartsWith("clear", System.StringComparison.InvariantCultureIgnoreCase))
            {
                return $"(others => '0')";
            }
            if (valueName.StartsWith("inc", System.StringComparison.InvariantCultureIgnoreCase))
            {
                return $"std_logic_vector(unsigned({fieldName}) + 1)";
            }
            if (valueName.StartsWith("dec", System.StringComparison.InvariantCultureIgnoreCase))
            {
                return $"std_logic_vector(unsigned({fieldName}) - 1)";
            }
            if (valueName.StartsWith("neg", System.StringComparison.InvariantCultureIgnoreCase))
            {
                return $"{fieldName} xor (others => '1')";
            }
            if (valueName.StartsWith("com", System.StringComparison.InvariantCultureIgnoreCase))
            {
                return $"std_logic_vector(unsigned(not {fieldName}) + 1)";
            }

            string foundLabel = fieldLabels.Find(fl => string.Equals(fl, valueName, System.StringComparison.InvariantCultureIgnoreCase));
            return string.IsNullOrEmpty(foundLabel) ? valueName : foundLabel;
        }

        public virtual StringBuilder GetVhdlBoilerplateCode(string prefix, List<string> fieldLabels)
        {
            StringBuilder sbCode = new StringBuilder("-- (no sample code provided)");

            return sbCode;
        }

        public int FindValue(string token, Dictionary<string, int> targets, int sourceLine)
        {
            int value, mask;

            if (string.IsNullOrEmpty(token))
            {
                return DefaultValue;
            }

            if (GetValueAndMask(token, out value, out mask, null))
            {
                Assert(mask == 0, $"Trying to assign masked value to '{Label}' (call from line {sourceLine})");
                // lookup if in matching any valid range
                foreach(ValueVector v in Values)
                {
                    if (v.Match(value))
                    {
                        if (!string.IsNullOrEmpty(v.Name))
                        {
                            Assert(v.Name[0] != '-', $"Value '{value}' is forbidden to be assigned (call from line {sourceLine})");
                            Assert(char.IsLetter(v.Name[0]), $"Token '{v.Name}' should start with a letter (call from line {sourceLine})");
                        }
                        return value; // it is ok, found in one of the ranges
                    }
                }
                Assert(false, string.Format("Value '{0}' out of accepted ranges for '{1}' (call from line {2})", value.ToString(), Label, sourceLine.ToString()));
            }
            else
            {
                // lookup by token
                foreach(ValueVector v in Values)
                {
                    if (v.IsTarget())
                    {
                        Assert(targets != null && targets.Count > 0, string.Format("No valid then/else targets found (call from line {0})", sourceLine.ToString()));
                        Assert(targets.ContainsKey(token), string.Format("Target '{0}' could not be found (call from line {1})", token, sourceLine.ToString()));
                        return targets[token];
                    }
                    else
                    {
                        if (v.Match(token))
                        {
                            if (!string.IsNullOrEmpty(v.Name))
                            {
                                Assert(v.Name[0] != '-', $"Value '{value}' is forbidden to be assigned (call from line {sourceLine})");
                                Assert(char.IsLetter(v.Name[0]), $"Token '{v.Name}' should start with a letter");
                            }
                            return v.From; // it is ok, found in the lookup table
                        }
                    }
                }
                Assert(false, string.Format("Token '{0}' could not be resolved for '{1}' (call from line {2})", token, Label, sourceLine.ToString()));
            }

            Assert(true, string.Format("Invalid value for '{0}' (call from line {1})", Label, sourceLine.ToString()));
            return DefaultValue; // this should never really be returned here 
        }

        private void CheckOverlapField(MicroField field, string fieldLabel)
        {
            Assert(field != null, $"Field '{fieldLabel}' not found when defining field overlap");
            Assert(!(field is FieldIf), $"Field '{fieldLabel}': overlap with .if not supported");
            Assert(!(field is FieldThen), $"Field '{fieldLabel}': overlap with .if not supported");
        }

        private int CheckRange(int value)
        {
            Assert((value >= 0) && (value <= this.MaxValue), string.Format("Value {0} out of range 0 .. {1}", value.ToString(), this.MaxValue.ToString()));
            return value;
        }
    }
}
