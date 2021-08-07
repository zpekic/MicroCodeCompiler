namespace mcc
{
    internal class Map : ParsedLineWithNoLabel
    {
        public int FromValue;
        public int ToValue;

        public Map(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".map", lineNumber, orgValue, label, content, logger)
        {
            Assert(orgValue > 0, "Can't map as .org not set");
        }

        public override void ParseContent()
        {
            string from, to;
            int mask;

            base.ParseContent();
            if (ParsedLine.Split3(Content, "..", out from, out to))
            {
                Assert(GetValueAndMask(from, out FromValue, out mask, null), $"Invalid map specifier {from}");
                Assert(mask == 0, $"Mask specifier '{from}' not allowed in .map range");
                Assert(GetValueAndMask(to, out ToValue, out mask, null), $"Invalid map specifier {to}");
                Assert(mask == 0, $"Mask specifier '{to}' not allowed in .map range");
                Assert(ToValue >= FromValue, $"Range '{Content}' is empty");
                if (ToValue == FromValue)
                {
                    logger.WriteLine($"Warning: range '{Content}' contains only a single value of {FromValue}");
                }
            }
            else
            {
                Assert(GetValueAndMask(Content, out FromValue, out mask, null), $"Invalid map specifier {Content}");
                ToValue = FromValue + mask;
                if (mask != 0)
                {
                    logger.WriteLine($"Warning: mask value {mask} detected. Range will be {FromValue} to {ToValue}");
                }
            }
        }

        public void Project(MemBlock memory, int dataWidth)
        {
            bool generateComment = true;
            string data = GetBinaryString(OrgValue, dataWidth);
            int writeCnt = 0;

            for (int address = FromValue; address <= ToValue; address++)
            {
                string comment = generateComment ? GetParsedLineString() : string.Empty;
                memory.Write(address, data, comment, null, true, "mapper");
                generateComment = false;
                writeCnt++;
            }

            switch (writeCnt)
            {
                case 0:
                    logger.WriteLine($"Warning: No mapper locations from {FromValue} to {ToValue} set to value '{data}' (range may be bad?)");
                    break;
                case 1:
                    logger.WriteLine($"Info: Mapper location {FromValue} set to value '{data}'");
                    break;
                default:
                    logger.WriteLine($"Info: {writeCnt} mapper locations from {FromValue} to {ToValue} set to value '{data}'");
                    break;
            }
        }
    }

}
