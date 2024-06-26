﻿using System;
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

        protected static Dictionary<char, int> binOps = new Dictionary<char, int>()
            {   // ordered in increasing priority to allow for optimization
                {'^', 1},   // XOR
                {'|', 1},   // OR
                {'&', 2},   // AND
                {'+', 4},   // ADD
                {'-', 4},   // SUB
                {'%', 5},   // MOD
                {'/', 5},   // DIV
                {'*', 5}    // MUL
            };

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
                throw new MccException(this.LineNumber, null, "Trying to add content to closed line");
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
            int valueLeft;
            // expression evaluation is implemented by creating a recursive binary tree split by the binary operators
            // at each level, the operator with lowest priority is found (this takes into account parenthesis levels)
            // to generate a "left-side" and "right-side" terms. Eventually these terms are constant or value leaf-nodes,
            // at which point they can be directly evaluated and resulting value passed to higher stack level.
            int lowestPri = int.MaxValue;
            char lowestOps = ' ';
            int lowestPos = -1;
            bool lowestUno = false;

            // remove blanks around
            string input = v.Trim();
            // remove redundant () around
            while (input.StartsWith("("))
            {
                if (input.EndsWith(")"))
                {
                    input = input.Substring(1);
                    input = input.Substring(0, input.Length - 1);
                }
                else
                {
                    break;
                }
            }

            if (string.IsNullOrEmpty(input))
            {
                return false;
            }

            // super simple and lame recursive expression evaluator!
            foreach (char opChar in binOps.Keys)
            {
                int pLevel = 0;
                // because we search for binary operators in incremental priority order, if we found one means next one is higher priority so skip it
                if ((lowestPri > 9) && input.Contains(opChar))
                {
                    bool singleQuote = false;
                    bool doubleQuote = false;
                    char previousChar = ' ';

                    for (int charPos = 0; charPos < input.Length; charPos++)
                    {
                        char currentChar = input[charPos];
                        if ((currentChar == opChar) && (!singleQuote) && (!doubleQuote))
                        {
                            int currentPri = (10 * pLevel) + binOps[opChar];
                            if (currentPri <= lowestPri)
                            {
                                lowestPri = currentPri;
                                lowestOps = opChar;
                                lowestPos = charPos;
                                lowestUno = IsUnaryOp(currentChar, previousChar);
                            }
                            else
                            {
                                continue;
                            }
                        }
                        else
                        {
                            switch (currentChar)
                            {
                                case '(':
                                    if (!singleQuote && !doubleQuote)
                                    {
                                        pLevel++;
                                    }
                                    break;
                                case ')':
                                    if (!singleQuote && !doubleQuote)
                                    {
                                        pLevel--;
                                    }
                                    break;
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

                        previousChar = char.IsWhiteSpace(currentChar) ? previousChar : currentChar;
                    }

                    Assert(pLevel == 0, $"Parenthesis mismatch in {input}");
                }

            }

            // lowest priority binary operator found on this level, now recursively evaluate left and rigth values for it
            if (lowestPos >= 0)
            {
                bool validLeft;

                if (lowestUno)
                {
                    // for unary operator, "fake" the left side to be 0 
                    valueLeft = 0;
                    validLeft = true;
                }
                else
                {
                    // binary operator, try to get left side expression recursively
                    validLeft = GetValueAndMask(input.Substring(0, lowestPos), out valueLeft, out mask, targets);
                }
                if (validLeft && GetValueAndMask(input.Substring(lowestPos + 1), out int valueRight, out mask, targets))
                {
                    // both values are available, execute binary operation
                    switch (lowestOps)
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
                            value = valueLeft ^ valueRight;
                            return true;
                        default:
                            return false; // failure!
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
                    else
                    {
                        //logger.WriteLine($"Label {label} is undefined");
                        Assert(false, $"Label {label} is undefined");
                    }
                }
                return false;
            }

            if (input.StartsWith("$"))
            {
                string label = input.Substring(1).Trim();
                if (!string.IsNullOrEmpty(label))
                {
                    logger.WriteLine($"Warning: line {LineNumber} - label '{label}' after $ ignored");
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
                                power = (c == 'b' ? 2 : power) ;
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
                                power = (c == 'B' ? 2 : power);
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
            value = 0;

            if (float.TryParse(input, out float f))
            {
                // get the bytes representing the FP value, and return them as if they were an integer
                value = BitConverter.ToInt32(BitConverter.GetBytes(f), 0);
                return true;
            }

            return false;
        }

        private static bool IsUnaryOp(char oper, char previous)
        {
            if ((oper == '-') || (oper == '+'))
            {
                switch (previous)
                {
                    case ' ': // indicates beginning of expression
                        return true;
                    case '(': // such as (-3 ...)
                        return true;
                    default:
                        foreach(char op in binOps.Keys)
                        {
                            if (op == previous)
                            {
                                return true;
                            }
                        }
                        break;
                }

                return false;
            }

            return false;
        }

        public static bool IsValidSymbolName(string name, out string whyNot)
        {
            whyNot = string.Empty;

            if (!string.IsNullOrEmpty(name))
            {
                bool first = true;
                foreach (char c in name)
                {
                    if (c == '_')
                    {
                        continue;
                    }
                    if (first ? char.IsLetter(c) : char.IsLetterOrDigit(c))
                    {
                        first = false;
                        continue;
                    }
                    else
                    {
                        whyNot = $"Symbol {name} is expected to start with a letter or _, and then continue with letter / digit / _";
                        return false;
                    }
                }

                return true;
            }

            whyNot = "Missing or empty symbol name";
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

            string binary32 = Convert.ToString(value, 2);
            string binary = binary32;
            if (binary32.Length > length)
            {
                // truncate
                binary = binary32.Substring(32 - length);
                Assert(binary.Length == length, "Bad value length!");
                logger.WriteLine($"Warning: value {binary32} truncated to value {binary} in line {LineNumber}.");

                return binary;
            }
            if (binary32.Length < length)
            {
                // extend
                binary = binary32.PadLeft(length, '0');
                //logger.WriteLine($"Warning: value {binary32} extended to value {binary} in line {LineNumber}.");

                return binary;
            }

            return binary;
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
                case 1: // VHDL peculiarity that single bit values must be under single quotes
                    switch (value)
                    {
                        case 0:
                            return "'0'";
                        case 1:
                            return "'1'";
                        default:
                            break;
                    }
                    Assert(true, $"Unexpected value of {value} can't fit into field of length {length}");
                    break;

                case 2: // 2-bit fields are frequent so handle them in hard-coded way
                    switch (value)
                    {
                        case 0:
                            return "\"00\"";
                        case 1:
                            return "\"01\"";
                        case 2:
                            return "\"10\"";
                        case 3:
                            return "\"11\"";
                        default:
                            break;
                    };
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
            for (int i = 0; i < dataWidth; i += 4)
            {
                binaryNibble = binaryData.Substring(i, 4);
                //Assert(Bin2Hex.ContainsKey(binaryNibble), string.Format("Invalid nibble '{0}' detected", binaryNibble));
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
                //string fileList = string.Empty;
                //foreach (string fileName in Program.sourceFileNameList)
                //{
                //    fileList += (fileName + " ");
                //}
                throw new MccException(this.LineNumber, Program.sourceFileNameList.Last(), exceptionMessage);
            }
        }

        private static string GetNonEmptyString(string rawString, int lineNumber, string exceptionMessage)
        {
            string trimmedString = rawString.Trim();
            if (string.IsNullOrEmpty(trimmedString))
            {
                throw new MccException(lineNumber, Program.currentFileName, exceptionMessage);
            }

            return trimmedString;
        }

    }
}
