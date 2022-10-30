using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace mcc
{
    internal abstract class ParsedLine
    {
        private string statement;
        public int LineNumber;
        public int OrgValue;
        public string Label;
        public string Content;
        protected Logger logger;

        protected static Dictionary<string, string> Bin2Hex = new Dictionary<string, string>()
        {
            { "0000", "0"}, { "0001", "1"}, { "0010", "2"}, { "0011", "3"}, { "0100", "4"}, { "0101", "5"}, { "0110", "6"}, { "0111", "7"},
            { "1000", "8"}, { "1001", "9"}, { "1010", "A"}, { "1011", "B"}, { "1100", "C"}, { "1101", "D"}, { "1110", "E"}, { "1111", "F"},
        };

        protected static Dictionary<string, string> Bin2Oct = new Dictionary<string, string>()
        {
            {"000", "0" },
            {"001", "1" },
            {"010", "2" },
            {"011", "3" },
            {"100", "4" },
            {"101", "5" },
            {"110", "6" },
            {"111", "7" }
        };

        protected static Dictionary<char, int> HexChar2Val = new Dictionary<char, int>()
        {
            {'0', 0},
            {'1', 1},
            {'2', 2},
            {'3', 3},
            {'4', 4},
            {'5', 5},
            {'6', 6},
            {'7', 7},
            {'8', 8},
            {'9', 9},
            {'a', 10},
            {'b', 11},
            {'c', 12},
            {'d', 13},
            {'e', 14},
            {'f', 15},
            {'A', 10},
            {'B', 11},
            {'C', 12},
            {'D', 13},
            {'E', 14},
            {'F', 15}
        };

        public ParsedLine(string statement, int lineNumber, int orgValue, string label, string content, Logger logger)
        {
            this.statement = statement;
            this.LineNumber = lineNumber;
            this.OrgValue = orgValue;
            this.Label = label.TrimEnd(new char[] { ':' });
            this.Content = content;
            this.logger = logger;
        }

        public ParsedLine Pass1()
        {
            if (this.Content.EndsWith(";"))
            {
                ParseContent();
                return null;
            }

            return this;
        }

        public void Append(string moreContent)
        {
            if (this.Content.EndsWith(";"))
            {
                throw new MccException(this.LineNumber, "Trying to add content to closed line");
            }
            else
            {
                this.Content += " ";
                this.Content += moreContent;
                if (moreContent.EndsWith(";"))
                {
                    ParseContent();
                }
            }
        }

        public virtual void ParseContent()
        {
            int v, m;

            // sanitize content for easier parsing later
            this.Content = this.Content.Replace('\t', ' ');
            //this.Content = this.Content.Replace("<", " <");
            //this.Content = this.Content.Replace("=", "= ");
            //this.Content = this.Content.Replace(",", ", ");
            //this.Content = this.Content.Replace("  ", " ");
            this.Content = this.Content.TrimEnd(new char[] { ';' });
            if (!string.IsNullOrEmpty(this.Label))
            {
                // quick check to prevent long labels and constant values as labels
                Assert(this.Label.Length < 17, string.Format("Invalid label '{0}' (longer than 16 characters)", this.Label));
                Assert(!GetValueAndMask(this.Label, out v, out m, null), string.Format("Invalid label '{0}' (can be interpreted as value)", this.Label));
            }
            // derived classes do something specific
        }

        // Parse out constants in following formats:
        // decimal (_ delimiter and ? mask allowed)
        // 0b|B<binary> (_ delimiter and ? mask allowed)
        // 0o|O<octal> (_ delimiter and ? mask allowed)
        // 0x|X<hex> (_ delimiter and ? mask allowed)
        // 'string' (_, ?, " treated as characters, therefore no mask, each char is single byte (ASCII code with bit 7 cleared))
        // "string" (_, ?, ' treated as characters, therefore no mask, each char is single byte (ASCII code with bit 7 cleared))
        // $ - current .orgValue
        // @label - address of label
        protected bool GetValueAndMask(string v, out int value, out int mask, Dictionary<string, int> targets)
        {
            value = 0;
            mask = 0;
            char[] binOps = new char[] {'*', '/', '%', '+', '-', '&', '|', '^' }; // ordered by precendence!
            int valueLeft, valueRight;

            string input = v.Trim();
            if (string.IsNullOrEmpty(input))
            {
                return false;
            }

            // super simple and lame recursive expression evaluator!
            // does not support changing of precedence using ()
            foreach (char opChar in binOps)
            {
                if (input.Contains(opChar))
                {
                    int opCharPos = -1;
                    bool singleQuote = false;
                    bool doubleQuote = false;

                    for (int charPos = 0; charPos < input.Length && (opCharPos < 0); charPos++)
                    {
                        if ((input[charPos] == opChar) && (!singleQuote) && (!doubleQuote))
                        {
                            opCharPos = charPos;
                        }
                        else
                        {
                            switch (input[charPos])
                            {
                                case '"':
                                    if (!singleQuote)
                                    {
                                        doubleQuote = !doubleQuote;
                                    }
                                    break;
                                case '\'':
                                    if (!doubleQuote)
                                    {
                                        singleQuote = !singleQuote;
                                    }
                                    break;
                                default:
                                    break;
                            }
                        }
                    }

                    if ((opCharPos >= 0) && GetValueAndMask(input.Substring(0, opCharPos), out valueLeft, out mask, targets))
                    {
                        if (GetValueAndMask(input.Substring(opCharPos + 1), out valueRight, out mask, targets))
                        {
                            switch (opChar)
                            {
                                case '*':
                                    value = valueLeft * valueRight;
                                    return true;
                                case '/':
                                    value = valueLeft / valueRight;
                                    return true;
                                case '%':
                                    value = valueLeft % valueRight;
                                    return true;
                                case '+':
                                    value = valueLeft + valueRight;
                                    return true;
                                case '-':
                                    value = valueLeft - valueRight;
                                    return true;
                                case '&':
                                    value = valueLeft & valueRight;
                                    return true;
                                case '|':
                                    value = valueLeft | valueRight;
                                    return true;
                                case '^':
                                    value = valueLeft & valueRight;
                                    return true;
                                default:
                                    return false; // failure!
                            }
                        }
                    }

                }
            }

            if (input.StartsWith("!"))
            {
                if (GetValueAndMask(input.Substring(1).Trim(), out value, out mask, targets))
                {
                    value = -(value + 1); // 2's complement reflected to int values 
                    return true;
                }

                return false; // failure!
            }

            if (input.StartsWith("@"))
            {
                string label = input.Substring(1).Trim();
                if (!string.IsNullOrEmpty(label))
                {
                    Assert((targets != null) && (targets.Count > 0), "Trying to use @label with no targets available");
                    if (targets.ContainsKey(label))
                    {
                        value = targets[label];
                        return true;
                    }
                }
                return false;
            }

            if (input.StartsWith("$"))
            {
                string label = input.Substring(1).Trim();
                if (!string.IsNullOrEmpty(label))
                {
                    logger.WriteLine(string.Format("Warning: line {0} - label '{1}' after $ ignored" , LineNumber.ToString(), label));
                }
                value = this.OrgValue;
                return true;
            }

            int power = -1; // meaning not determined yet
            char[] chars = input.ToCharArray();
            foreach(char c in chars)
            {
                switch (c)
                {
                    case '0':
                        switch (power)
                        {
                            case -1: // expect next char to be b, x, o
                                power = 0;
                                break;
                            case 0:
                                return false; // two leading zeroes in a row?
                            case (int)'\'':
                            case (int)'"':
                                value = value * 256 + (int)c;
                                break;
                            default:    // 2, 8, 10, 16
                                value = value * power;
                                mask = mask * power;
                                break;
                        }
                        break;
                    case '1':
                    case '2':
                    case '3':
                    case '4':
                    case '5':
                    case '6':
                    case '7':
                    case '8':
                    case '9':
                        switch (power)
                        {
                            case -1:
                            case 0:
                                power = 10;
                                value = value * power + ((int)c - (int)'0');
                                mask = mask * power;
                                break;
                            case 2:
                                if (c == '1')
                                {
                                    value = value * power + ((int)c - (int)'0');
                                    mask = mask * power;
                                }
                                else
                                {
                                    return TryFloat(input, out value);
                                }
                                break;
                            case 8:
                                if ((c == '8') || (c == '9'))
                                {
                                    return TryFloat(input, out value);
                                }
                                else
                                { 
                                    value = value * power + ((int)c - (int)'0');
                                    mask = mask * power;
                                }
                                break;
                            case 10:
                            case 16:
                                value = value * power + ((int)c - (int)'0');
                                mask = mask * power;
                                break;
                            case (int)'\'':
                            case (int)'"':
                                value = value * 256 + (int)c;
                                break;
                            default:
                                return TryFloat(input, out value);
                        }
                        break;
                    case 'a':
                    case 'b':
                    case 'c':
                    case 'd':
                    case 'e':
                    case 'f':
                        switch (power)
                        {
                            case 0:
                                if (c == 'b')
                                {
                                    power = 2;
                                }
                                break;
                            case 16:
                                value = value * power + ((int)c - (int) 'a' + 10);
                                mask = mask * power;
                                break;
                            case (int)'\'':
                            case (int)'"':
                                value = value * 256 + (int)c;
                                break;
                            default:
                                return TryFloat(input, out value);
                        }
                        break;
                    case 'A':
                    case 'B':
                    case 'C':
                    case 'D':
                    case 'E':
                    case 'F':
                        switch (power)
                        {
                            case 0:
                                if (c == 'B')
                                {
                                    power = 2;
                                }
                                break;
                            case 16:
                                value = value * power + ((int)c - (int)'A' + 10);
                                mask = mask * power;
                                break;
                            case (int)'\'':
                            case (int)'"':
                                value = value * 256 + (int)c;
                                break;
                            default:
                                return TryFloat(input, out value);
                        }
                        break;
                    case '?':
                        switch (power)
                        {
                            case 2:
                            case 8:
                            case 10:
                            case 16:
                                value = value * power;
                                mask = mask * power + (power - 1);
                                break;
                            case (int)'\'':
                            case (int)'"':
                                value = value * 256 + (int)c;
                                break;
                            default:
                                return TryFloat(input, out value);
                        }
                        break;
                    case '_':
                        switch (power)
                        {
                            case 2:
                            case 8:
                            case 10:
                            case 16:
                                break;  // use as handy delimiter
                            case (int)'\'':
                            case (int)'"':
                                value = value * 256 + (int)c;
                                break;
                            default:
                                return TryFloat(input, out value);
                        }
                        break;
                    case 'o':
                    case 'O':
                    case 'x':
                    case 'X':
                        switch (power)
                        {
                            case 0:
                                power = 8;
                                if ((c == 'x') || (c == 'X'))
                                {
                                    power = 16;
                                }
                                break;
                            case (int)'\'':
                            case (int)'"':
                                value = value * 256 + (int)c;
                                break;
                            default:
                                return TryFloat(input, out value);
                        }
                        break;
                    case '\'':
                    case '"':
                        switch (power)
                        {
                            case -1:
                            case 0:
                                power = (int)c;
                                break;
                            case (int)'\'':
                                if (c == '\'')
                                {
                                    return true;    // closing single quoted string, bail out
                                }
                                else
                                {
                                    value = value * 256 + (int)c;
                                }
                                break;
                            case (int)'"':
                                if (c == '"')
                                {
                                    return true;    // closing double quoted string, bail out
                                }
                                else
                                {
                                    value = value * 256 + (int)c;
                                }
                                break;
                            default:
                                return TryFloat(input, out value);
                        }
                        break;
                    default:
                        switch (power)
                        {
                            case (int)'\'':
                            case (int)'"':
                                value = value * 256 + (int)c;
                                break;
                            default:
                                return TryFloat(input, out value);
                        }
                        break;
                }
            }
            return true;
        }

        private bool TryFloat(string input, out int value)
        {
            float f;
            value = 0;

            if (float.TryParse(input, out f))
            {
                // get the bytes representing the FP value, and return them as if they were an integer
                value = BitConverter.ToInt32(BitConverter.GetBytes(f), 0);
                return true;
            }

            return false;
        }

        public static bool Split3(string source, string token, out string beforeToken, out string afterToken)
        {
            beforeToken = string.Empty;
            afterToken = string.Empty;

            if (!string.IsNullOrEmpty(source))
            {
                int index = source.ToLowerInvariant().IndexOf(token.ToLowerInvariant());
                if (index >= 0)
                {
                    beforeToken = source.Substring(0, index).Trim();
                    afterToken = source.Substring(index + token.Length).Trim();

                    return true;
                }
                else
                {
                    beforeToken = source;
                }
            }

            return false;
        }

        public string GetParsedLineString()
        {
            StringBuilder sbLine = new StringBuilder($"L{LineNumber:D4}");
            sbLine.Append(OrgValue < 0 ? "." : $"@{OrgValue:X4}.");
            sbLine.Append(string.IsNullOrEmpty(Label) ? " " : $"{Label}: ");

            sbLine.Append($"{statement} ");
            sbLine.Append(Content);
            sbLine.Append(";");

            return sbLine.ToString();
        }

        protected string GetConcatenatedList(List<string> list, char[] delimiter)
        {
            StringBuilder sb = new StringBuilder();

            foreach (string item in list)
            {
                sb.Append(item.ToString());
                sb.Append(delimiter);
            }
            string concat = sb.ToString().Trim();

            return concat.TrimEnd(delimiter);
        }

        public string GetBinaryString(int value, int length)
        {
            Assert((length > 0) && (length <= 32), "Field length must be between 0 and 32");

            string binary = Convert.ToString(value, 2);
            if (binary.Length == length)
            {
                return binary;
            }
            Assert(binary.Length <= length, string.Format("Field length of {0} can't fit value {1}", length.ToString(), binary));
            return binary.PadLeft(length, '0');
        }

        protected string GetVhdConstantFromBinaryString(string binary)
        {
            Assert(!string.IsNullOrEmpty(binary), "Constant length must be > 0");

            if (binary.Length == 1)
            {
                return $"'{binary}'";   // single binary digit
            }
            else
            {
                if ((binary.Length % 4) == 0)
                {
                    return $"X\"{GetHexFromBinary(binary, binary.Length)}\"";   // hex is the most compact
                }

                if ((binary.Length % 3) == 0)
                {
                    return $"O\"{GetOctFromBinary(binary, binary.Length)}\"";   // octal is the most compact
                }

                return $"\"{binary}\""; // other length binary digits
            }
        }

        protected int GetLog2(int value)
        {
            int singleBit = 1;
            for (int i = 0; i < 16; i++)
            {
                if (singleBit == value)
                {
                    return i;
                }
                singleBit *= 2;
            }

            return -1;
        }

        protected string GetVhdConstant(int value, int length)
        {
            Assert(length > 0, "Constant length must be > 0");
            switch (length)
            {
                case 1:
                    if (value == 0)
                    {
                        return "'0'";
                    }
                    if (value == 1)
                    {
                        return "'1'";
                    }
                    Assert(true, $"Unexpected value of {value} can't fit into field of length {length}");
                    break;

                case 3:
                    return $"O\"{Convert.ToString(value, 8)}\"";
                case 4:
                    return $"X\"{Convert.ToString(value, 16).ToUpper()}\"";
                case 8:
                    return $"X\"{Convert.ToString(value, 16).ToUpper().PadLeft(2, '0')}\"";
                case 9:
                    return $"O\"{Convert.ToString(value, 8).PadLeft(3, '0')}\"";
                case 12:
                    return $"X\"{Convert.ToString(value, 16).ToUpper().PadLeft(3, '0')}\"";
                case 15:
                    return $"O\"{Convert.ToString(value, 8).PadLeft(5, '0')}\"";
                case 16:
                    return $"X\"{Convert.ToString(value, 16).ToUpper().PadLeft(4, '0')}\"";
                case 20:
                    return $"X\"{Convert.ToString(value, 16).ToUpper().PadLeft(5, '0')}\"";
                case 24:
                    return $"X\"{Convert.ToString(value, 16).ToUpper().PadLeft(6, '0')}\"";
                case 28:
                    return $"X\"{Convert.ToString(value, 16).ToUpper().PadLeft(7, '0')}\"";
                case 32:
                    return $"X\"{Convert.ToString(value, 16).ToUpper().PadLeft(8, '0')}\"";

                default:
                    break;
            }
            return $"\"{GetBinaryString(value, length)}\"";
        }

        protected string GetHexFromBinary(string binaryData, int dataWidth)
        {
            string binaryNibble;

            StringBuilder hexBuilder = new StringBuilder();
            for (int i = 0; i < (dataWidth / 4); i++)
            {
                binaryNibble = binaryData.Substring(i << 2, 4);
                Assert(Bin2Hex.ContainsKey(binaryNibble), string.Format("Invalid nibble '{0}' detected", binaryNibble));
                hexBuilder.Append(Bin2Hex[binaryNibble]);
            }
            return hexBuilder.ToString();
        }

        protected string GetOctFromBinary(string binaryData, int dataWidth)
        {
            string octet;

            StringBuilder octBuilder = new StringBuilder();
            for (int i = 0; i < (dataWidth / 3); i++)
            {
                octet = binaryData.Substring(3 * i, 3);
                Assert(Bin2Oct.ContainsKey(octet), $"Invalid octet '{octet}' detected");
                octBuilder.Append(Bin2Oct[octet]);
            }
            return octBuilder.ToString();
        }

        protected void Assert(bool condition, string exceptionMessage)
        {
            if (!condition)
            {
                throw new MccException(this.LineNumber, exceptionMessage);
            }
        }

        private static string GetNonEmptyString(string rawString, int lineNumber, string exceptionMessage)
        {
            string trimmedString = rawString.Trim();
            if (string.IsNullOrEmpty(trimmedString))
            {
                throw new MccException(lineNumber, exceptionMessage);
            }

            return trimmedString;
        }

    }
}
