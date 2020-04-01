namespace mcc
{
    internal class Map : ParsedLineWithNoLabel
    {
        public int Value;
        public int Mask;

        public Map(int lineNumber, int orgValue, string label, string content, Logger logger) : base(lineNumber, orgValue, label, content, logger)
        {
            Assert(orgValue > 0, "Can't map as .org not set");
        }

        public override void ParseContent()
        {
            base.ParseContent();
            GetValueAndMask(Content, out Value, out Mask, null);

        }

        public void Project(MemBlock memory, int dataWidth)
        {
            bool generateComment = true;
            string data = GetBinaryString(OrgValue, dataWidth);

            for (int address = Value; address <= (Value + Mask); address++)
            {
                string comment = generateComment ? GetParsedLineString() : string.Empty;
                memory.Write(address, data, comment, true, "mapper");
                generateComment = false;
            }
        }
    }

}
