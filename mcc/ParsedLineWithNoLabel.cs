namespace mcc
{
    internal abstract class ParsedLineWithNoLabel : ParsedLine
    {
        public ParsedLineWithNoLabel(int lineNumber, int orgValue, string label, string content, Logger logger) : base(lineNumber, orgValue, label, content, logger)
        {
            Assert(string.IsNullOrEmpty(this.Label), "Label not allowed (maybe should be on subsequent microinstruction?)");
        }

    }

}
