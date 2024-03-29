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
        static Dictionary<string, int> lineCounter = new Dictionary<string, int>();
        public static string currentFileName;
        static List<ParsedLine> parsedLines = new List<ParsedLine>();
        static Dictionary<string, int> labelLine = new Dictionary<string, int>();
        static Dictionary<string, int> labelOrg = new Dictionary<string, int>();
        static Logger logger;
        static bool isRisingEdge = true;
        static bool assemblyMode = false;
        static int sourceFileIndex = -1;
        public static List<string> sourceFileNameList = new List<string>();
        static Dictionary<string, string[]> multiLineAlias = new Dictionary<string, string[]>();

        static int Main(string[] args)
        {
            try
            {
                logger = new Logger(args);
                logger.PrintBanner();
                Assert(args.Length > 0, "Source file [path\\]name missing.\r\n\r\nUsage info: mcc.exe -h[elp]");

                if (!HelpMode(args))
                {
                    if (CompileMode(args, out assemblyMode, out sourceFileIndex))
                    //if (args[0].EndsWith(".mcc", StringComparison.InvariantCultureIgnoreCase))
                    {
                        // compile mode
                        Pass0(args[sourceFileIndex], assemblyMode, -1);
                        Pass1(args[sourceFileIndex], assemblyMode);
                    }
                    else
                    {
                        // convert from format to format mode
                        Convert(args);
                    }
                }
                return 0;   // success
            }
            catch (MccException ex)
            {
                logger.WriteLine(ex.Message);
                logger.WriteLine(ex.StackTrace);
                return 1;
            }
            catch (System.Exception ex)
            {
                logger.WriteLine(string.Format("Error in line {0}: {1}", lineCounter.ToString(), ex.Message));
                logger.WriteLine(ex.StackTrace);
                return 2;
            }
//            finally
//           {
//                if (sourceFile != null)
//                {
//                    sourceFile.Close();
//                }
//            }
        }

        private static bool HelpMode(string[] args)
        {
            for (int i = 0; i < args.Length; i++)
            {
                if (args[i].StartsWith("-h", StringComparison.InvariantCultureIgnoreCase) || args[i].StartsWith("-?", StringComparison.InvariantCultureIgnoreCase))
                {
                    logger.PrintHelp(null);
                    return true;
                }
            }

            return false;
        }

        private static bool CompileMode(string[] args, out bool assemblyMode, out int sourceFileIndex)
        {
            assemblyMode = false;
            sourceFileIndex = -1;
            string expectedExtension = ".mcc";

            for (int i = 0; i < args.Length; i++)
            {
                if (args[i].EndsWith(expectedExtension, StringComparison.InvariantCultureIgnoreCase))
                {
                    assemblyMode = !args[i].EndsWith(".mcc", StringComparison.InvariantCultureIgnoreCase);
                    sourceFileIndex = i;
                    return true;
                }
                if (args[i].StartsWith("-a:", StringComparison.InvariantCultureIgnoreCase) || args[i].StartsWith("/a:", StringComparison.InvariantCultureIgnoreCase))
                {
                    expectedExtension = '.' + args[i].Split(':')[1];
                }
            }

            return (sourceFileIndex >= 0);
        }

        private static void Convert(string[] args)
        {
            string sourceFileName = args[0];
            Assert(sourceFileName.LastIndexOf('.') > 0, $"File extension missing in '{sourceFileName}'");
            string sourceExtension = sourceFileName.Substring(sourceFileName.LastIndexOf('.')).ToLower();
            int addressWidth = 0;
            int wordWidth = 8;
            int recordWidth = 16;
            string targetName = sourceFileName.Replace(sourceExtension, string.Empty);
            string content, rawLine, data;
            byte[] byteData;
            Mapper mapper = null;
            int errorCounter = 0;
            int address;
            bool isLastRecord;
            bool allowUninitialized = false;
            System.IO.StreamReader sourceFile;

            Assert(File.Exists(sourceFileName), $"Source file '{sourceFileName}' not found");

            if (args.Length > 1)
            {
                Assert(int.TryParse(args[1], out addressWidth), "Address width missing or invalid (command line format: file.bin addresswidth wordwidth recordwidth)");
                Assert((addressWidth >= 0) && (addressWidth <= 16), "Address width out of expected range 0 (auto) .. 16");
                if (args.Length > 2)
                {
                    Assert(int.TryParse(args[2], out wordWidth), "Word width missing or invalid (command line format: file.bin addresswidth wordwidth recordwidth)");
                    Assert((wordWidth == 8) || (wordWidth == 16) || (wordWidth == 32), "Word width must be 8, 16 or 32");
                    if (args.Length > 3)
                    {
                        Assert(int.TryParse(args[3], out recordWidth), "Record width missing or invalid (command line format: file.bin addresswidth wordwidth recordwidth)");
                        Assert((recordWidth == 1) || (recordWidth == 2) || (recordWidth == 4) || (recordWidth == 8) || (recordWidth == 16), "Record width must be 1, 2, 4, 8 or 16");
                    }
                }
            }

            switch (sourceExtension)
            {
                case ".hex":
                    logger.WriteLine($"Converting hex file '{sourceFileName}' to other formats");

                    //Assert(addressWidth == 16, $"Only address width of 16 is supported for .hex file ({addressWidth} detected)");

                    content = $"{addressWidth}, {wordWidth}, {targetName}.coe, {targetName}.mif, {targetName}.cgf, mem:{targetName}.vhd, {targetName}.bin, {recordWidth};";
                    mapper = new Mapper(1, -1, string.Empty, content, logger);
                    ((ParsedLine)mapper).Pass1();

                    sourceFile = new System.IO.StreamReader(sourceFileName);
                    while ((rawLine = sourceFile.ReadLine()) != null)
                    {
                        lineCounter[sourceFileName]++;

                        string hexLine = rawLine.Trim();
                        if (!string.IsNullOrEmpty(hexLine))
                        {
                            if (mapper.ParseHexFileLine(lineCounter[sourceFileName], hexLine.ToLowerInvariant(), out address, out byteData, out isLastRecord))
                            {
                                if (isLastRecord)
                                {
                                    logger.WriteLine($"Last record found at line {lineCounter} reading '{sourceFileName}', all subsequent lines are ignored");
                                    break;
                                }
                                else
                                {
                                    mapper.Write(address, byteData, sourceFileName, hexLine, lineCounter[sourceFileName], "hex");
                                }
                            }
                            else
                            {
                                errorCounter++;
                            }
                        }
                    }
                    sourceFile.Close();

                    if (errorCounter > 0)
                    {
                        logger.WriteLine($"Warning: {lineCounter.ToString()} line(s) read from '{sourceFileName}', {errorCounter} error lines found (output is probably invalid).");
                    }
                    else
                    {
                        logger.WriteLine($"Success: {lineCounter.ToString()} line(s) read from '{sourceFileName}', no error lines.");
                    }
                    allowUninitialized = true;
                    break;

                case ".bin":
                    logger.WriteLine($"Converting binary file '{sourceFileName}' to other formats");

                    byte[] fileBytes = File.ReadAllBytes(sourceFileName);

                    if (addressWidth == 0)
                    {
                        // find out addresswidth using the actual file size
                        while (fileBytes.Length > (wordWidth >> 3) * (1 << addressWidth))
                        {
                            addressWidth++;
                        }
                    }
                    Assert((addressWidth > 0) && (addressWidth <= 16), $"Evaluated address width of {addressWidth} out of expected range 1 .. 16");

                    Assert(fileBytes.Length == (wordWidth >> 3) * (1 << addressWidth), $"Count of bytes in file ({fileBytes.Length}) not matching expected count of ({1 << addressWidth} * {wordWidth >> 3})");

                    content = $"{addressWidth}, {wordWidth}, {targetName}.coe, {targetName}.mif, {targetName}.cgf, mem:{targetName}.vhd, {targetName}.hex, {recordWidth};";
                    mapper = new Mapper(1, -1, string.Empty, content, logger);
                    ((ParsedLine)mapper).Pass1();

                    // write bytes into mapper
                    for (address = 0; address < fileBytes.Length; address += (wordWidth >> 3))
                    {
                        string extraComment = string.Format("{0:X4}: ", address);
                        data = "";

                        for (int i = 0; i < (wordWidth >> 3); i++)
                        {
                            extraComment += string.Format("{0:X2} ", fileBytes[address + i]);
                            data += string.Format("{0}_", mapper.GetBinaryString(fileBytes[address + i], 8));
                        }
                        mapper.Write(address, data.TrimEnd(new char[] { '_' }), sourceFileName, extraComment, false, "binary");
                    }

                    break;
                default:
                    Assert(false, $"Source file '{sourceFileName}' format not supported");
                    break;
            }

            // Generate all the destination files
            int outputFileCount = Generate(string.Empty, (MemBlock)mapper, allowUninitialized, "Generating: ", null, true);

            logger.WriteLine($"Success: Conversion on {sourceFileName} - {outputFileCount.ToString()} file(s) generated.");
        }

        private static int Pass0(string sourceFileName, bool assemblyMode, int invokerOrgValue)
        {
            int orgValue = invokerOrgValue;
            ParsedLine continuationLine = null;
            string rawLine, comment;
            bool inImplementationSection = false;
            MicroField checkFi = null;
            MicroField checkFt = null;
            MicroField checkFe = null;
            bool inBlockComment = false;
            System.IO.StreamReader sourceFile;

            // Read the file and display it line by line.  
            Assert(File.Exists(sourceFileName), $"Source file '{sourceFileName}' not found");
            Assert(!lineCounter.ContainsKey(sourceFileName), $"Recursive or circular #include {sourceFileName}");

            logger.WriteLine($"Compiling {sourceFileName}, pass 1 out of 2.");
            Program.sourceFileNameList.Add(sourceFileName);

            sourceFile = new System.IO.StreamReader(sourceFileName);
            currentFileName = sourceFileName;
            lineCounter.Add(currentFileName, 0);
            while ((rawLine = sourceFile.ReadLine()) != null)
            {
                lineCounter[sourceFileName]++;

                ParsedLine.Split3(rawLine.Trim(), "//", out rawLine, out comment);

                // block comments are everything between //* and *//
                if (inBlockComment)
                {
                    if (rawLine.EndsWith("*"))
                    {
                        inBlockComment = false;
                        rawLine = comment;
                    }
                    else
                    {
                        comment = string.IsNullOrEmpty(comment) ? rawLine : rawLine + "//" + comment;
                        rawLine = string.Empty;
                    }

                }
                else
                {
                    if (comment.StartsWith("*"))
                    {
                        inBlockComment = true;
                    }
                }

                if (!string.IsNullOrEmpty(rawLine))
                {
                    string label, content;

                    // .org is always on one line and just sets the value, line is not preserved
                    if (ParsedLine.Split3(rawLine, ".org", out label, out content))
                    {
                        Assert(string.IsNullOrEmpty(label), "Label not allowed on .org");
                        Org org = new Org(lineCounter[sourceFileName], orgValue, label, content, logger);
                        if (((ParsedLine)org).Pass1() == null)
                        {
                            orgValue = org.GetUpdatedOrgValue(orgValue);
                            continuationLine = null;
                        }
                        else
                        {
                            continuationLine = (ParsedLine)org;
                        }

                        parsedLines.Add(org);
                        inImplementationSection = true;
                        continue;
                    }

                    // all other .<pragma> instructions are preserved in parsedLines list
                    if (ParsedLine.Split3(rawLine, ".code", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".code outside definition section");

                        Code code = new Code(lineCounter[sourceFileName], orgValue, label, content, logger);
                        continuationLine = ((ParsedLine)code).Pass1();
                        parsedLines.Add(code);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".symbol", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".code outside definition section");

                        Symbol symbol = new Symbol(lineCounter[sourceFileName], orgValue, label, content, logger);
                        continuationLine = ((ParsedLine)symbol).Pass1();
                        parsedLines.Add(symbol);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".mapper", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".mapper outside definition section");

                        Mapper mapper = new Mapper(lineCounter[sourceFileName], orgValue, label, content, logger);
                        continuationLine = ((ParsedLine)mapper).Pass1();
                        parsedLines.Add(mapper);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".controller", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".mapper outside definition section");

                        Controller controller = new Controller(lineCounter[sourceFileName], orgValue, label, content, logger);
                        continuationLine = ((ParsedLine)controller).Pass1();
                        isRisingEdge = controller.GetClockEdge();
                        parsedLines.Add(controller);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".map", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(inImplementationSection, ".map outside implementation section");

                        Map map = new Map(lineCounter[sourceFileName], orgValue, label, content, logger);
                        continuationLine = ((ParsedLine)map).Pass1();
                        parsedLines.Add(map);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".if", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".if outside definition section");
                        Assert(checkFi == null, ".if already defined");

                        FieldIf fi = new FieldIf(lineCounter[sourceFileName], orgValue, label, content, logger);
                        checkFi = fi;
                        continuationLine = ((ParsedLine)fi).Pass1();
                        parsedLines.Add(fi);
                        AddLabel(label, lineCounter[sourceFileName]);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".then", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".then outside definition section");
                        Assert(checkFt == null, ".then already defined");

                        FieldThen ft = new FieldThen(lineCounter[sourceFileName], orgValue, label, content, logger);
                        checkFt = ft;
                        continuationLine = ((ParsedLine)ft).Pass1();
                        parsedLines.Add(ft);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".else", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".else outside definition section");
                        Assert(checkFe == null, ".else already defined");

                        FieldElse fe = new FieldElse(lineCounter[sourceFileName], orgValue, label, content, logger);
                        checkFe = fe;
                        continuationLine = ((ParsedLine)fe).Pass1();
                        parsedLines.Add(fe);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".regfield", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".regfield outside definition section.");

                        FieldReg fr = new FieldReg(lineCounter[sourceFileName], orgValue, label, content, logger, parsedLines);
                        continuationLine = ((ParsedLine)fr).Pass1();
                        parsedLines.Add(fr);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".valfield", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".valfield outside definition section.");

                        FieldVal fv = new FieldVal(lineCounter[sourceFileName], orgValue, label, content, logger, parsedLines);
                        continuationLine = ((ParsedLine)fv).Pass1();
                        parsedLines.Add(fv);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".alias", out label, out content))
                    {
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".alias outside definition section.");

                        Alias alias = new Alias(lineCounter[sourceFileName], orgValue, label, content, logger);
                        continuationLine = ((ParsedLine)alias).Pass1();
                        parsedLines.Add(alias);

                        if (alias.Lines.Length > 1)
                        {
                            multiLineAlias.Add(alias.Label, alias.Lines);
                        }

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, ".sub", out label, out content))
                    {
                        Assert(!string.IsNullOrEmpty(label), "Label required on .sub (must match entry point in the code)");
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!inImplementationSection, ".sub outside definition section");

                        Sub sub = new Sub(lineCounter[sourceFileName], orgValue, label, content, logger);
                        continuationLine = ((ParsedLine)sub).Pass1();
                        parsedLines.Add(sub);

                        continue;
                    }

                    if (ParsedLine.Split3(rawLine, "#include", out label, out content))
                    {
                        Assert(string.IsNullOrEmpty(label), "Label not allowed on #include pragma");
                        Assert(continuationLine == null, "Previous line not closed with ';'");
                        Assert(!string.IsNullOrEmpty(content), "File [path\\]name missing");

                        orgValue = Pass0(content.TrimEnd(';').Trim('"'), assemblyMode, orgValue);

                        continue;
                    }

                    // line with no .instruction found is either a continuation, or a microinstruction
                    if (continuationLine == null)
                    {
                        MicroInstruction microInstruction;
                        //Assert(!inImplementationSection, ".map not allowed after any microinstruction.");

                        Assert(orgValue >= 0, ".org not set.");

                        if (ParsedLine.Split3(rawLine, ":", out label, out content))
                        {
                            inImplementationSection = true;
                            if (!label.StartsWith("_"))
                            {
                                // all labels not starting with _ are valid microcode jump/call destinations
                                Assert(!labelOrg.ContainsKey(label), $"Label '{label}' has already been defined");
                                labelOrg.Add(label, orgValue);
                            }
                            //microInstruction = new MicroInstruction(lineCounter[sourceFileName], orgValue, label, content, parsedLines, logger);
                            //parsedLines.Add(microInstruction);
                            //orgValue++;
                            //continuationLine = ((ParsedLine)microInstruction).Pass1();
                        }
                        else
                        {
                            inImplementationSection = true;
                            label = string.Empty;
                            content = rawLine;
                        }

                        string mlAliasKey = null;
                        foreach (string mlAlias in multiLineAlias.Keys)
                        {
                            if (rawLine.IndexOf(mlAlias, StringComparison.InvariantCultureIgnoreCase) >= 0)
                            {
                                mlAliasKey = mlAlias;
                                break;
                            }
                        }
                        if (mlAliasKey == null)
                        {
                            // no multi-line alias found, will generate single instruction
                            microInstruction = new MicroInstruction(lineCounter[sourceFileName], orgValue, label, content, parsedLines, logger);
                            parsedLines.Add(microInstruction);
                            orgValue++;
                            continuationLine = ((ParsedLine)microInstruction).Pass1();
                        }
                        else
                        {
                            // multi-line alias found, will generate as n + 1 instructions, where n is count of \ in alias definition
                            // TODO: allow continuation in the case of multiline alias
                            string before, after;

                            ParsedLine.Split3(content, mlAliasKey, out before, out after);
                            for (int i = 0; i < multiLineAlias[mlAliasKey].Length; i++)
                            {
                                string aliasLine = multiLineAlias[mlAliasKey][i].Replace(';', ' ');
                                if (i == multiLineAlias[mlAliasKey].Length - 1)
                                {
                                    // last
                                    microInstruction = new MicroInstruction(lineCounter[sourceFileName], orgValue, string.Empty, aliasLine + " " + after, parsedLines, logger);
                                }
                                else
                                {
                                    if (i == 0)
                                    {
                                        // first (also gets the label, if any)
                                        microInstruction = new MicroInstruction(lineCounter[sourceFileName], orgValue, label, before + aliasLine + ";", parsedLines, logger);
                                    }
                                    else
                                    {
                                        // any in the middle
                                        microInstruction = new MicroInstruction(lineCounter[sourceFileName], orgValue, string.Empty, aliasLine + ";", parsedLines, logger);
                                    }
                                }

                                parsedLines.Add(microInstruction);
                                orgValue++;
                                continuationLine = ((ParsedLine)microInstruction).Pass1();
                            }
                        }
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

            if (!assemblyMode)
            {
                // it is weird (but conceivable) that if/then/else fields are not defined
                CheckField(checkFi, ".if field not defined, code might not compile or work");
                CheckField(checkFt, ".then field not defined, code might not compile or work");
                CheckField(checkFe, ".else field not defined, code might not compile or work");
            }

            logger.WriteLine($"Success: pass 0 on {sourceFileName} - {lineCounter[sourceFileName]} line(s) read, {parsedLines.Count.ToString()} statement(s) parsed, code address range 0x{invokerOrgValue:X4} - 0x{orgValue:X4}.");
            Program.sourceFileNameList.RemoveAt(Program.sourceFileNameList.Count - 1);
            return orgValue;
        }
        
        private static void Pass1(string sourceFileName, bool assemblyMode)
        {
            Controller controller = null;

            Code code = null;
            int codeDepth = -1; 
            int codeWidth = -1;

            Mapper mapper = null;
            int mapDepth = -1;
            int mapWidth = -1;
            int fieldHiPos = 0;

            Symbol symbol = null;
            int symbolDepth = -1;
            int symbolWidth = -1;
            string baseFileName = sourceFileName.Substring(0, sourceFileName.LastIndexOf("."));

            List<MicroField> fields = new List<MicroField>();

            logger.WriteLine($"Compiling {sourceFileName}, pass 2 out of 2.");
            Program.sourceFileNameList.Add(sourceFileName);
            currentFileName = sourceFileName;

            foreach (ParsedLine pl in parsedLines)
            {
                if (pl is Controller)
                {
                    Assert(controller == null, ".controller statement already defined");
                    controller = (Controller)pl;
                    continue;
                }

                if (pl is Code)
                {
                    Assert(code == null, ".code statement already defined");
                    code = (Code)pl;
                    code.GetSize(out codeDepth, out codeWidth);
                    fieldHiPos = codeWidth - 1;
                    continue;
                }

                if (pl is Symbol)
                {
                    Assert(symbol == null, ".symbol statement already defined");
                    Assert(code != null, ".symbol statement defined before .code");
                    symbol = (Symbol)pl;
                    symbol.GetSize(out symbolDepth, out symbolWidth);
                    Assert(codeDepth == symbolDepth, ".symbol depth must match code depth");
                    Assert((symbolWidth % 8) == 0, ".symbol width must be multiple of 8 bits (8-bit ASCII chars are stored)");
                    symbol.InitAll();
                    continue;
                }

                if (pl is Mapper)
                {
                    Assert(mapper == null, ".mapper statement already defined");
                    mapper = (Mapper)pl;
                    mapper.GetSize(out mapDepth, out mapWidth);
                    //fieldHiPos = codeWidth - 1;
                    continue;
                }

                if (pl is Map)
                {
                    Assert(mapper != null, ".mapper statement not defined");
                    Map map = (Map)pl;
                    Assert(map.OrgValue < codeDepth, string.Format(".map target of {0:X4} is beyond .code memory limit of {1:X4} .. {2:X4}", map.OrgValue, 0, codeDepth - 1));
                    Assert(map.ToValue < mapDepth, string.Format(".map value of {0:X4} is beyond .mapper memory limit of {1:X4} .. {2:X4}", map.ToValue, 0, mapDepth - 1));
                    map.Project((MemBlock) mapper, mapWidth);
                    continue;
                }

                if (pl is MicroField)
                {
                    Assert(assemblyMode || (mapper != null), ".mapper statement not defined");
                    MicroField mf = (MicroField)pl;
                    fields.Add(mf);
                    fieldHiPos = mf.SetRange(fieldHiPos);
                    mf.CheckFieldWidth(codeDepth);
                    continue;
                }

                if (pl is Sub)
                {
                    Sub sub = (Sub)pl;

                    Assert(labelOrg.Keys.Contains(sub.Label), $".sub label '{sub.Label}' not defined in code");
                    Assert(sub.CheckParams(fields), $".sub with label '{sub.Label}' specifies unknown or invalid .regfields");
                }

                if (pl is MicroInstruction)
                {
                    Assert(fieldHiPos >= - 1, string.Format("Insufficient microcode width (extend by {0} bits)", (0 - fieldHiPos).ToString()));
                    MicroInstruction mi = (MicroInstruction)pl;
                    mi.Project((MemBlock)code, codeWidth, fields, labelOrg);
                    if (symbol != null)
                    {
                        symbol.InitEntry(mi);
                    }
                    continue;
                }
            }

            int outputFileCount = Generate(baseFileName, (MemBlock) code, true, "Generating code: ", fields, false);
            if (mapper == null)
            {
                Assert(assemblyMode, ".mapper definition is missing!");
            }
            else
            {
                outputFileCount += Generate(baseFileName, (MemBlock)mapper, false, "Generating mapping: ", null, false);
            }
            outputFileCount += Generate(baseFileName, (MemBlock)symbol, true, "Generating symbol: ", null, false);
            if (controller != null)
            {
                outputFileCount += controller.GenerateFiles("Generating controller");
            }

            logger.WriteLine($"Success: pass 1 on {sourceFileName} - {outputFileCount.ToString()} file(s) generated.");
            Program.sourceFileNameList.RemoveAt(Program.sourceFileNameList.Count - 1);
        }

        static int Generate(string baseFileName, MemBlock mem, bool allowUninitialized, string trace, List<MicroField> fields, bool isConversion)
        {
            logger.Write(trace);
            if (mem == null)
            {
                logger.WriteLine(" skipped.");
                return 0;
            }

            logger.WriteLine(string.Empty);
            return mem.Generate(baseFileName, allowUninitialized, fields, isConversion, isRisingEdge);
        }

        private static void AddLabel(string label, int line)
        {
            Assert(!string.IsNullOrEmpty(label), "Invalid label");
            Assert(!labelLine.Keys.Contains(label), string.Format("Label '{0}' already defined", label));
            labelLine.Add(label, line);
        }

        private static void CheckField(MicroField mf, string warningMessage)
        {
            if (mf == null)
            {
                logger.WriteLine($"Warning: {warningMessage}");
            }
        }

        private static void Assert(bool condition, string exceptionMessage)
        {
            if (!condition)
            {
                throw new MccException(lineCounter[currentFileName], currentFileName, exceptionMessage);
            }
        }

        }
    }

