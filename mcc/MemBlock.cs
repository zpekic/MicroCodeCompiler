using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace mcc
{
    internal class MemBlock : ParsedLineWithNoLabel
    {
        protected int addressWidth;
        protected int dataWidth;
        protected List<string> outputFiles = new List<string>();
        protected int byteWidth;
        protected Dictionary<int, DataVector> memory = new Dictionary<int, DataVector>();

        public struct DataVector
        {
            public string Data;
            public string Comment;
            public string ExtraComment;

            public DataVector(string data, string comment, string extraComment)
            {
                this.Data = data;
                this.Comment = comment;
                this.ExtraComment = extraComment;
            }
        }

        public MemBlock(int lineNumber, int orgValue, string label, string content, Logger logger) : base(lineNumber, orgValue, label, content, logger)
        {
            Assert(orgValue < 0, "Definition statement must precede .org");
        }

        public override void ParseContent()
        {
            base.ParseContent();

            string[] param = this.Content.Split(',');

            Assert(param.Length > 3, "Missing parameter(s)");
            Assert(int.TryParse(param[0], out this.addressWidth), "Bad address width");
            Assert(int.TryParse(param[1], out this.dataWidth), "Bad data width");
            for (int i = 2;  i < param.Length - 1; i++)
            {
                outputFiles.Add(param[i].Trim());
            }
            Assert(int.TryParse(param[param.Length - 1], out this.byteWidth), "Bad byte width");
            Assert(this.byteWidth * 8 >= this.dataWidth, "Insufficient byte width");
            Assert(outputFiles.Count >= 0, "No output files specified");
        }

        public void Write(int address, string data, string comment, string extraComment, bool allowOverwrite, string flavor)
        {
            Assert(address < (2 << this.addressWidth), $"Tying to write {flavor} location {address:X4} beyond memory limit of 0 .. {(2 << this.addressWidth) - 1:X4}");
            string rawBinaryString = data.Replace("_", string.Empty);
            Assert(rawBinaryString.Length == this.dataWidth, $"Invalid {flavor} data width of {rawBinaryString.Length} ({this.dataWidth} expected)");
            if (memory.ContainsKey(address))
            {
                Assert(allowOverwrite, $"Attempting to overwrite {flavor} location '{address:X4}'");
                logger.WriteLine($"Warning in line {LineNumber}: overwriting '{memory[address].Data}' with '{data}' at {flavor}[{address:X4}]");
                memory.Remove(address);
            }
            else
            {
                logger.WriteLine($"Info: line {LineNumber} - {flavor}[{address:X4}] <= '{data}'");
            }
            memory.Add(address, new DataVector(data, comment, extraComment));
        }

        public void GetSize(out int depth, out int width)
        {
            depth = 2 << (this.addressWidth - 1);
            width = this.dataWidth;
        }

        public int Generate(bool allowUninitialized, List<MicroField> fields)
        {
            int count = 0;
            int capacity = 2 << (this.addressWidth - 1);
            StringBuilder sbVhdUninit = new StringBuilder();

            int emptyLocationCount = capacity - memory.Count;
            if (emptyLocationCount > 0)
            {
                int startRange = 0;
                int endRange = -1;
                StringBuilder sbUninit = new StringBuilder($"Warning in line {LineNumber.ToString()}: found {emptyLocationCount.ToString()} uninitialized locations:");
                sbUninit.AppendLine();
                for (int address = 0; address < capacity; address++)
                {
                    if (memory.ContainsKey(address))
                    {
                        if (endRange >= startRange)
                        {
                            sbUninit.AppendLine($"{startRange:X4} .. {endRange:X4}");
                            sbVhdUninit.AppendLine($"-- {startRange:X4} .. {endRange:X4}");
                        }
                        startRange = address + 1;
                    }
                    else
                    {
                        endRange = address;
                    }
                }
                // if open ended block has been found
                if (endRange >= startRange)
                {
                    sbUninit.AppendLine($"{startRange:X4} .. {endRange:X4}");
                    sbVhdUninit.AppendLine($"-- {startRange:X4} .. {endRange:X4}");
                }

                logger.WriteLine(sbUninit.ToString());
                Assert(allowUninitialized, "All locations must be initialized.");
            }

            foreach (string fileName in this.outputFiles)
            {
                FileInfo outputFileInfo = null;
                string prefix = null;
                string[] prefixNamePair = fileName.Split(':');

                switch (prefixNamePair.Length)
                {
                    case 0:
                        Assert(false, $"Filename '{fileName}' is invalid.");
                        break;
                    case 1:
                        outputFileInfo = new FileInfo(prefixNamePair[0]);
                        break;
                    case 2:
                        prefix = prefixNamePair[0];
                        outputFileInfo = new FileInfo(prefixNamePair[1]);
                        break;
                    default:
                        Assert(false, $"Filename '{fileName}' is invalid.");
                        break;
                }

                switch (outputFileInfo.Extension.ToLowerInvariant())
                {
                    case ".vhd":
                        count += GenerateVhdFile(prefix, outputFileInfo, fields, sbVhdUninit.ToString());
                        break;
                    case ".hex":
                        count += GenerateHexFile(outputFileInfo);
                        break;
                    case ".cgf":
                        count += GenerateCgfFile(outputFileInfo, "0", this.dataWidth % 4 == 0 ? 16 : 2);
                        break;
                    case ".mif":
                        count += GenerateMifFile(outputFileInfo, this.dataWidth % 4 == 0 ? 16 : 2);
                        break;
                    default:
                        logger.WriteLine(string.Format("Warning in line {0}: unsupported extension in file '{1}", this.LineNumber.ToString(), fileName));
                        break;
                }
            }
            return count;
        }

        protected string GetVhdMemory(int capacity, string defaultMicroinstruction, string otherRanges)
        {
            int generateOthers = 0;
            StringBuilder sb = new StringBuilder();
            bool isFirst = true;

            for (int address = 0; address < capacity; address++)
            {
                if (memory.ContainsKey(address))
                {
                    if (isFirst)
                    {
                        isFirst = false;
                        sb.AppendLine();
                    }
                    else
                    {
                        sb.AppendLine(",");
                    }
                    sb.AppendLine();
                    if (!string.IsNullOrEmpty(memory[address].Comment))
                    {
                        sb.Append("-- ");
                        sb.AppendLine(memory[address].Comment);
                        if (!string.IsNullOrEmpty(memory[address].ExtraComment))
                        {
                            sb.Append("-- ");
                            sb.AppendLine(memory[address].ExtraComment);
                        }
                    }
                    sb.Append($"{address} => ");
                    sb.Append(GetVhdDataFromBinaryString(memory[address].Data));
                }
                else
                {
                    // at least one uninitialize location found!
                    generateOthers++;
                }
            }
            if (generateOthers > 0)
            {
                sb.AppendLine(",");
                sb.AppendLine();
                sb.AppendLine($"-- {generateOthers} location(s) in following ranges will be filled with default value");
                sb.AppendLine(otherRanges);
                sb.Append("others => ");
                sb.AppendLine(GetVhdDataFromBinaryString(defaultMicroinstruction));
            }

            return sb.ToString();
        }

        protected string GetVhdDataFromBinaryString(string binString)
        {
            Assert(!string.IsNullOrEmpty(binString), "Microinstruction data not defined");

            StringBuilder sb = new StringBuilder();
            string[] chunks = binString.Split('_');
            for (int i = 0; i < chunks.Length; i++)
            {
                sb.Append(GetVhdConstantFromBinaryString(chunks[i]));
                if ((chunks.Length - i) > 1)
                {
                    sb.Append(" & ");
                }
            }

            return sb.ToString();
        }

        protected int GenerateHexFile(FileInfo outputFileInfo)
        {
            switch (this.byteWidth)
            {
                case 1:
                case 2:
                case 4:
                case 8:
                case 16:
                    break;
                default:
                    logger.WriteLine(string.Format("Warning in line {0}: byte width {1} is not power of 2, .hex file not generated", this.LineNumber.ToString(), this.byteWidth.ToString()));
                    return 0;
            }

            int capacity = 2 << (this.addressWidth - 1);

            using (System.IO.StreamWriter hexFile = new System.IO.StreamWriter(outputFileInfo.FullName, false, Encoding.ASCII))
            {
                logger.Write(string.Format("Writing '{0}' ...", outputFileInfo.FullName));

                int value;
                int mask;
                byte[] record = new byte[5 + this.byteWidth];

                for (int address = 0; address < capacity; address++)
                {
                    if (memory.ContainsKey(address))
                    {
                        string rawBinary = memory[address].Data.Replace("_", string.Empty);
                        if (rawBinary.Length > 8 * this.byteWidth)
                        {
                            Assert(true, string.Format("Data at location 0X{0:X4} too long ({1} bits) to fit {2} bytes", address, rawBinary.Length.ToString(), this.byteWidth.ToString()));
                        }
                        else
                        {
                            // pad from left until we have the exact length
                            while (rawBinary.Length < 8 * this.byteWidth)
                            {
                                rawBinary = "0" + rawBinary;
                            }
                        }
                                     
                        record[0] = (byte)this.byteWidth;
                        record[1] = (byte)((address * this.byteWidth) >> 8);
                        record[2] = (byte)(address * this.byteWidth);
                        record[3] = 0;
                        for (int i = 0; i < this.byteWidth; i++)
                        {
                            Assert(GetValueAndMask("0B" + rawBinary.Substring(i << 3, 8), out value, out mask, null), "Non-binary data found in memory. Something went terribly wrong..");
                            Assert(mask == 0, "Mask data found in memory. Not supported in current version.");
                            record[i + 4] = (byte) value;
                        }
                        // evaluate checksum
                        int checksum = 0;
                        for (int i = 0; i < 4 + this.byteWidth; i++)
                        {
                            checksum += (int)record[i];
                        }
                        checksum = -checksum; // 2' complement
                        record[4 + this.byteWidth] = (byte)checksum;

                        WriteHexFileRecord(hexFile, record, 5 + this.byteWidth, true);
                    }
                }

                // assemble closing hex file record
                record[0] = 0;
                record[1] = 0;
                record[2] = 0;
                record[3] = 1;
                record[4] = 255;
                WriteHexFileRecord(hexFile, record, 5, true);
                logger.WriteLine(" Done.");
            }
            return 1;
        }

        protected int GenerateCgfFile(FileInfo outputFileInfo, string default_word, int data_radix)
        {
            int capacity = 2 << (this.addressWidth - 1);

            using (System.IO.StreamWriter cgfFile = new System.IO.StreamWriter(outputFileInfo.FullName, false, Encoding.ASCII))
            {
                logger.Write(string.Format("Writing '{0}' ...", outputFileInfo.FullName));

                cgfFile.WriteLine($"#CGF file \"{outputFileInfo.Name}\"");
                cgfFile.WriteLine($"#memory_block_name={GetBlockName()}");
                cgfFile.WriteLine($"#block_depth={capacity}");
                cgfFile.WriteLine($"#data_width={dataWidth}");
                cgfFile.WriteLine($"#default_word={default_word}"); // TODO
                cgfFile.WriteLine($"#default_pad_bit_value=0"); 
                cgfFile.WriteLine($"#pad_direction=left"); 
                cgfFile.WriteLine($"#data_radix={data_radix}"); 
                cgfFile.WriteLine($"#address_radix=16");
                cgfFile.WriteLine($"#coe_radix=MEMORY_INITIALIZATION_RADIX");
                cgfFile.WriteLine($"#coe_data=MEMORY_INITIALIZATION_VECTOR");
                cgfFile.WriteLine($"#data=");

                int previousAddress = -2;
                string data;
                for (int address = 0; address < capacity; address++)
                {
                    if (memory.ContainsKey(address))
                    {
                        if (address - previousAddress > 1)
                        {   
                            // if not consecutive, write the address
                            cgfFile.WriteLine($"@{address:X4}");
                        }
                        data = memory[address].Data.Replace("_", string.Empty);
                        if (data_radix == 16)
                        {
                            data = GetHexFromBinary(data, this.dataWidth);
                        }
                        cgfFile.WriteLine(data);
                        previousAddress = address;
                    }
                }

                cgfFile.WriteLine($"#end");

                logger.WriteLine(" Done.");
            }
            return 1;
        }

        protected int GenerateMifFile(FileInfo outputFileInfo, int data_radix)
        {
            int capacity = 2 << (this.addressWidth - 1);

            using (System.IO.StreamWriter cgfFile = new System.IO.StreamWriter(outputFileInfo.FullName, false, Encoding.ASCII))
            {
                logger.Write(string.Format("Writing '{0}' ...", outputFileInfo.FullName));

                cgfFile.WriteLine($"%---------------------------------%");
                cgfFile.WriteLine($"WIDTH={dataWidth};");
                cgfFile.WriteLine($"DEPTH={capacity};");
                cgfFile.WriteLine($"ADDRESS_RADIX=HEX;");
                if (data_radix == 16)
                {
                    cgfFile.WriteLine($"DATA_RADIX=HEX;");
                }
                else
                {
                    cgfFile.WriteLine($"DATA_RADIX=BIN;");
                }
                cgfFile.WriteLine($"CONTENT BEGIN");

                string data;
                string previousData = string.Empty;
                int startRun = 0;
                int endRun = 0;
                for (int address = 0; address < capacity; address++)
                {
                    if (memory.ContainsKey(address))
                    {
                        data = memory[address].Data.Replace("_", string.Empty);
                        if (data_radix == 16)
                        {
                            data = GetHexFromBinary(data, this.dataWidth);
                        }
                        if (data.Equals(previousData, StringComparison.InvariantCultureIgnoreCase))
                        {
                            endRun = address;
                        }
                        else
                        {
                            if (endRun >= startRun)
                            {
                                // print out the previous run
                                if (endRun > startRun)
                                {
                                    cgfFile.WriteLine($"[{startRun:X4} .. {endRun:X4}] : {previousData};");
                                }
                                else
                                {
                                    if (!string.IsNullOrEmpty(previousData))
                                    {
                                        cgfFile.WriteLine($"{endRun:X4} : {previousData};");
                                    }
                                }
                            }
                            else
                            {
                                // print out a single value
                                cgfFile.WriteLine($"{address:X4} : {data};");
                            }
                            // prepare for next possible run
                            endRun = address;
                            startRun = address;
                            previousData = data;
                        }
                    }
                }

                // flush
                if (endRun > startRun)
                {
                    cgfFile.WriteLine($"[{startRun:X4} .. {endRun:X4}] : {previousData};");
                }
                else
                {
                    Assert(!string.IsNullOrEmpty(previousData), "Run detection algorithm error");
                    cgfFile.WriteLine($"{endRun:X4} : {previousData};");
                }

                // finalize file
                cgfFile.WriteLine($"END;");
                cgfFile.WriteLine($"%---------------------------------%");

                logger.WriteLine(" Done.");
            }
            return 1;
        }

        protected string LoadFile(string fileName)
        {
            if (File.Exists(fileName))
            {
                return File.ReadAllText(fileName);
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendLine($"-- Auto-generated file, do not modify. To customize, create '{fileName}' file in mcc.exe folder");
                sb.AppendLine("-- Supported placeholders: [PLACEHOLDERS].");
                sb.AppendLine("--------------------------------------------------------");
                sb.AppendLine("library IEEE;");
                sb.AppendLine("use IEEE.STD_LOGIC_1164.all;");
                sb.AppendLine("use IEEE.numeric_std.all;");
                sb.AppendLine();
                sb.AppendLine("package [NAME] is");
                sb.AppendLine();
                sb.AppendLine("[SIZES]");
                sb.AppendLine();
                sb.AppendLine("[TYPE]");
                sb.AppendLine();
                sb.AppendLine("[SIGNAL]");
                sb.AppendLine();
                sb.AppendLine("[FIELDS]");
                sb.AppendLine();
                sb.AppendLine("[MEMORY]");
                sb.AppendLine();
                sb.AppendLine("end [NAME];");

                return sb.ToString();
            }
        }

        protected string GetVhdlSizes(string prefix, FieldIf fif)
        {
            StringBuilder sbSizes = new StringBuilder();

            sbSizes.AppendLine("-- memory block size");
            sbSizes.AppendLine($"constant {prefix}_DATA_WIDTH: \tpositive := {this.dataWidth};");
            sbSizes.AppendLine($"constant {prefix}_ADDRESS_WIDTH: \tpositive := {this.addressWidth};");
            sbSizes.AppendLine($"constant {prefix}_ADDRESS_LAST: \tpositive := {((1 << this.addressWidth) - 1)};");
            if (fif != null)
            {
                sbSizes.AppendLine($"constant {prefix}_IF_WIDTH: \tpositive := {fif.Width};");
            }
            return sbSizes.ToString();
        }

        protected virtual int GenerateVhdFile(string prefix, FileInfo outputFileInfo, List<MicroField> fields, string otherRanges)
        {
            // the real implementation is in derived classes as the generate VHD varies 
            return 0;
        }

        protected virtual string GetBlockName()
        {
            return string.Empty;
        }

        private void WriteHexFileRecord(StreamWriter sw, byte[] record, int count, bool prettfy)
        {
            if (prettfy)
            {
                sw.Write(string.Format(": {0:X2} {1:X2}{2:X2} {3:X2} {4:X2}", record[0], record[1], record[2], record[3], record[4]));
                for (int i = 5; i < count; i++)
                {
                    sw.Write(string.Format(" {0:X2}", record[i]));
                }
            }
            else
            {
                sw.Write(':');
                for (int i = 0; i < count; i++)
                {
                    sw.Write(string.Format("{0:X2}", record[i]));
                }
            }
            sw.WriteLine();
        }
    }

}
