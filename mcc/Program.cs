using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace mcc
{
    class Program
    {
        static int lineCounter = 0;
        static List<ParsedLine> parsedLines = new List<ParsedLine>();
        static Dictionary<string, int> labelLine = new Dictionary<string, int>();
        static Dictionary<string, int> labelOrg = new Dictionary<string, int>();
        static System.IO.StreamReader sourceFile;
        static Logger logger;

        static int Main(string[] args)
        {
            try
            {
                logger = new Logger(args);
                logger.PrintBanner();
                Assert(args.Length > 0, "Source file [path\\]name missing.");

                if (args[0].EndsWith(".mcc", StringComparison.InvariantCultureIgnoreCase))
                {
                    // compile mode
                    Pass0(args[0]);
                    Pass1(args[0]);
                }
                else
                {
                    // convert from format to format mode
                    Convert(args);
                }
                return 0;   // success
            }
            catch (MccException ex)
            {
                logger.WriteLine(ex.Message);
                return 1;
            }
            catch (System.Exception ex)
            {
                logger.WriteLine(string.Format("Error in line {0}: {1}", lineCounter.ToString(), ex.Message));
                return 2;
            }
            finally
            {
                if (sourceFile != null)
                {
                    sourceFile.Close();
                }
            }
        }

        private static void Convert(string[] args)
        {
            string sourceFileName = args[0];
            string sourceExtension = sourceFileName.Substring(sourceFileName.LastIndexOf('.')).ToLower();
            int addressWidth = 16;
            int wordWidth = 1;
            int recordWidth = 16;
            string targetName = sourceFileName.Replace(sourceExtension, string.Empty);

            Assert(File.Exists(sourceFileName), $"Source file '{sourceFileName}' not found");

            switch (sourceExtension)
            {
                case ".bin":
                    logger.WriteLine($"Converting binary file '{sourceFileName}' to other formats");

                    Assert(int.TryParse(args[1], out addressWidth), "Address width missing or invalid (command line format: file.bin addresswidth wordwidth recordwidth)");
                    Assert((addressWidth > 0) && (addressWidth <= 16), "Address width out of expected range 1 .. 16");
                    Assert(int.TryParse(args[2], out wordWidth), "Word width missing or invalid (command line format: file.bin addresswidth wordwidth recordwidth)");
                    Assert((wordWidth == 8) || (wordWidth == 16) || (wordWidth == 32), "Word width must be 8, 16 or 32");
                    Assert(int.TryParse(args[3], out recordWidth), "Record width missing or invalid (command line format: file.bin addresswidth wordwidth recordwidth)");
                    Assert((recordWidth == 4) || (recordWidth == 4) || (wordWidth == 8) || (wordWidth == 16), "Record width must be 2, 4, 8 or 16");

                    byte[] fileBytes = File.ReadAllBytes(sourceFileName);

                    Assert(fileBytes.Length == (wordWidth >> 3) * (1 << addressWidth), $"Count of bytes in file ({fileBytes.Length}) not matching expected count of ({1 << addressWidth} * {wordWidth >> 3})");

                    string content = $"{addressWidth}, {wordWidth}, {targetName}.mif, {targetName}.cgf, mem:{targetName}.vhd, {targetName}.hex, {recordWidth};";
                    Mapper mapper = new Mapper(1, -1, string.Empty, content, logger);
                    ((ParsedLine)mapper).Pass1();

                    // write bytes into mapper
                    for (int address = 0; address < fileBytes.Length; address += (wordWidth >> 3))
                    {
                        string extraComment = string.Format("{0:X4}: ", address);
                        string data = "";

                        for (int i = 0; i < (wordWidth >> 3); i++)
                        {
                            extraComment += string.Format("{0:X2} ", fileBytes[address + i]);
                            data += string.Format("{0}_", mapper.GetBinaryString(fileBytes[address + i], 8));
                        }
                        mapper.Write(address, data.TrimEnd(new char[] { '_' }), sourceFileName, extraComment, false, "binary");
                    }

                    // Generate all the destination files
                    int outputFileCount = Generate((MemBlock)mapper, false, "Generating: ", null, true);

                    logger.WriteLine($"Success: Conversion - {outputFileCount.ToString()} file(s) generated.");

                    break;
                default:
                    Assert(false, $"Source file '{sourceFileName}' format not supported");
                    break;
            }

            sourceFile = new System.IO.StreamReader(sourceFileName);
            

        }

        private static void Pass0(string sourceFileName)
        {
            int orgValue = -1;
            ParsedLine continuationLine = null;
            string rawLine, comment;
            bool inImplementationSection = false;
            //Dictionary<string, Alias> aliases = new Dictionary<string, Alias>();
            //Dictionary<string, int> labelLine = new Dictionary<string, int>();
            //int fieldLeftPos = -1; // microinstruction word top bit position not yet initialized

            // Read the file and display it line by line.  
            Assert(File.Exists(sourceFileName), $"Source file '{sourceFileName}' not found");

            logger.WriteLine($"Compiling {sourceFileName}, pass 1 out of 2.");

            sourceFile = new System.IO.StreamReader(sourceFileName);
            while ((rawLine = sourceFile.ReadLine()) != null)
            {
                lineCounter++;

                ParsedLine.Split3(rawLine.Trim(), "//", out rawLine, out comment);
                if (!string.IsNullOrEmpty(rawLine))
                {
                    string label, content;

                    // .org is always on one line and just sets the value, line is not preserved
                    if (ParsedLine.Split3(rawLine, ".org", out label, out content))
                    {
                        Assert(string.IsNullOrEmpty(label), "Label not allowed on .org.");
                        //Assert(GetMemorySize(parsedLines.Single(pl => pl.GetType().ToString() == "Code"), out microcodeDepth, out microcodeWidth), ".code size not yet defined");
                        //Assert(GetMemorySize(code, out microcodeDepth, out microcodeWidth), ".code size not yet defined");
                        //Assert((newValue > 0) && (newValue < microcodeDepth), string.Format(".org value of '{0}' out of allowed range 0 .. {1}.", newValue.ToString(), (microcodeDepth - 1).ToString()));
                        //Assert((newValue > orgValue) && (newValue < microcodeDepth), string.Format(".org value of '{0}' out of allowed range {1} .. {2}.", newValue.ToString(), (orgValue + 1).ToString(), (microcodeDepth - 1).ToString()));
                        Org org = new Org(lineCounter, -1, label, content, logger);
                        if (((ParsedLine) org).Pass1() == null)
                        {
                            orgValue = org.GetUpdatedOrgValue(orgValue);
                            continuationLine = null;
                        }
                        else
                        {
                            continuationLine = (ParsedLine) org;
                        }

                        parsedLines.Add(org);
                        inImplementationSection = true;
                        continue;
                    }

                    // all other .<pragma> instructions are preserved in parsedLines list
                    if (ParsedLine.Split3(rawLine, ".code", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".code outside definition section.");

                        Code code = new Code(lineCounter, orgValue, label, content, logger);
                        //continuationLine = content.EndsWith(";") ? null : (ParsedLine) code;
                        continuationLine = ((ParsedLine) code).Pass1();
                        parsedLines.Add(code);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".mapper", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".mapper outside definition section.");

                        Mapper mapper = new Mapper(lineCounter, orgValue, label, content, logger);
                        //continuationLine = content.EndsWith(";") ? null : (ParsedLine)mapper;
                        continuationLine = ((ParsedLine) mapper).Pass1();
                        parsedLines.Add(mapper);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".map", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(inImplementationSection, ".map outside implementation section.");

                        Map map = new Map(lineCounter, orgValue, label, content, logger);
                        //continuationLine = content.EndsWith(";") ? null : (ParsedLine)map;
                        continuationLine = ((ParsedLine) map).Pass1();
                        parsedLines.Add(map);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".if", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".if outside definition section.");

                        FieldIf fi = new FieldIf(lineCounter, orgValue, label, content, logger);
                        //fieldLeftPos = fi.SetRange(GetLeftPos(fieldLeftPos));
                        //continuationLine = content.EndsWith(";") ? null : (ParsedLine)fi;
                        continuationLine = ((ParsedLine) fi).Pass1();
                        parsedLines.Add(fi);
                        AddLabel(label);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".then", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".then outside definition section.");

                        FieldThen ft = new FieldThen(lineCounter, orgValue, label, content, logger);
                        //fieldLeftPos = ft.SetRange(GetLeftPos(fieldLeftPos));
                        //continuationLine = content.EndsWith(";") ? null : (ParsedLine)ft;
                        continuationLine = ((ParsedLine) ft).Pass1();
                        parsedLines.Add(ft);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".else", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".else outside definition section.");

                        FieldElse fe = new FieldElse(lineCounter, orgValue, label, content, logger);
                        //fieldLeftPos = fe.SetRange(GetLeftPos(fieldLeftPos));
                        //continuationLine = content.EndsWith(";") ? null : (ParsedLine)fe;
                        continuationLine = ((ParsedLine) fe).Pass1();
                        parsedLines.Add(fe);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".regfield", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".regfield outside definition section.");

                        FieldReg fr = new FieldReg(lineCounter, orgValue, label, content, logger);
                        //fieldLeftPos = fr.SetRange(GetLeftPos(fieldLeftPos));
                        //continuationLine = content.EndsWith(";") ? null : (ParsedLine)fr;
                        continuationLine = ((ParsedLine) fr).Pass1();
                        parsedLines.Add(fr);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".valfield", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".valfield outside definition section.");

                        FieldVal fv = new FieldVal(lineCounter, orgValue, label, content, logger);
                        //fieldLeftPos = fv.SetRange(GetLeftPos(fieldLeftPos));
                        //continuationLine = content.EndsWith(";") ? null : (ParsedLine)fv;
                        continuationLine = ((ParsedLine) fv).Pass1();
                        parsedLines.Add(fv);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".alias", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".valfield outside definition section.");

                        Alias alias = new Alias(lineCounter, orgValue, label, content, logger);
                        //continuationLine = content.EndsWith(";") ? null : (ParsedLine)alias;
                        continuationLine = ((ParsedLine) alias).Pass1();
                        parsedLines.Add(alias);

                        continue;
                    }

                    // line with no .instruction found is either a continuation, or a microinstruction
                    if (continuationLine == null)
                    {
                        MicroInstruction microInstruction;
                        //Assert(!inImplementationSection, ".map not allowed after any microinstruction.");

                        Assert(orgValue >= 0, ".org not set.");
                        //Assert(GetMemorySize(parsedLines.Single(pl => pl.GetType().ToString() == "Code"), out microcodeDepth, out microcodeWidth), ".code size not yet defined");
                        //Assert(orgValue < microcodeDepth, "Out of microinstruction memory.");

                        if (ParsedLine.Split3(rawLine, ":", out label, out content))
                        {
                            microInstruction = new MicroInstruction(lineCounter, orgValue, label, content, parsedLines, logger);
                            inImplementationSection = true;
                            if (!label.StartsWith("_"))
                            {
                                // all labels not starting with _ are valid microcode jump/call destinations
                                labelOrg.Add(label, orgValue);
                            }
                        }
                        else
                        {
                            microInstruction = new MicroInstruction(lineCounter, orgValue, string.Empty, rawLine, parsedLines, logger);
                            inImplementationSection = true;
                        }

                        parsedLines.Add(microInstruction);
                        continuationLine = ((ParsedLine) microInstruction).Pass1();
                        orgValue++;

                    }
                    else
                    {
                        continuationLine.Append(rawLine);
                        continuationLine.Pass1();
                        // we need org values right away to stamp microinstructions with them
                        Org org = continuationLine as Org;
                        if (org != null)
                        {
                            orgValue = org.GetUpdatedOrgValue(orgValue);
                        }
                    }

                    // finishing the statement?
                    if (rawLine.EndsWith(";"))
                    {
                        continuationLine = null;
                    }

                }
            }
            sourceFile.Close();

            logger.WriteLine($"Success: pass 1 {lineCounter.ToString()} line(s) read, {parsedLines.Count.ToString()} statement(s) parsed.");
        }


        private static void Pass1(string sourceFileName)
        {
            Code code = null;
            int codeDepth = -1; 
            int codeWidth = -1;

            Mapper mapper = null;
            int mapDepth = -1;
            int mapWidth = -1;
            int fieldHiPos = 0;

            List<MicroField> fields = new List<MicroField>();

            logger.WriteLine($"Compiling {sourceFileName}, pass 2 out of 2.");

            foreach (ParsedLine pl in parsedLines)
            {
                if (pl is Code)
                {
                    Assert(code == null, ".code statement already defined");
                    code = (Code)pl;
                    code.GetSize(out codeDepth, out codeWidth);
                    continue;
                }

                if (pl is Mapper)
                {
                    Assert(mapper == null, ".mapper statement already defined");
                    mapper = (Mapper)pl;
                    mapper.GetSize(out mapDepth, out mapWidth);
                    fieldHiPos = codeWidth - 1;
                    continue;
                }

                if (pl is Map)
                {
                    Assert(mapper != null, ".mapper statement not defined");
                    Map map = (Map)pl;
                    Assert(map.OrgValue < codeDepth, string.Format(".map target of {0:X4} is beyond .code memory limit of {1:X4} .. {2:X4}", map.OrgValue, 0, codeDepth - 1));
                    Assert(map.Value < mapDepth, string.Format(".map value of {0:X4} is beyond .mapper memory limit of {1:X4} .. {2:X4}", map.Value, 0, mapDepth - 1));
                    map.Project((MemBlock) mapper, mapWidth);
                    continue;
                }

                if (pl is MicroField)
                {
                    Assert(mapper != null, ".mapper statement not defined");
                    MicroField mf = (MicroField)pl;
                    fields.Add(mf);
                    fieldHiPos = mf.SetRange(fieldHiPos);
                    continue;
                }

                if (pl is MicroInstruction)
                {
                    Assert(fieldHiPos >= - 1, string.Format("Insufficient microcode width (extend by {0} bits)", (0 - fieldHiPos).ToString()));
                    MicroInstruction mi = (MicroInstruction)pl;
                    mi.Project((MemBlock)code, codeWidth, fields, labelOrg);
                    continue;
                }
            }

            int outputFileCount = Generate((MemBlock) code, true, "Generating code: ", fields, false);
            outputFileCount += Generate((MemBlock)mapper, false, "Generating mapping: ", null, false);

            logger.WriteLine($"Success: pass 2 - {outputFileCount.ToString()} file(s) generated.");
        }

        static int Generate(MemBlock mem, bool allowUninitialized, string trace, List<MicroField> fields, bool isConversion)
        {
            logger.Write(trace);
            if (mem == null)
            {
                logger.WriteLine(" skipped.");
                return 0;
            }

            logger.WriteLine(string.Empty);
            return mem.Generate(allowUninitialized, fields, isConversion);
        }

        private static void AddLabel(string label)
        {
            Assert(!string.IsNullOrEmpty(label), "Invalid label");
            Assert(!labelLine.Keys.Contains(label), string.Format("Label '{0}' already defined", label));
            labelLine.Add(label, lineCounter);
        }

        private static void Assert(bool condition, string exceptionMessage)
        {
            if (!condition)
            {
                throw new MccException(lineCounter, exceptionMessage);
            }
        }

        }
    }

