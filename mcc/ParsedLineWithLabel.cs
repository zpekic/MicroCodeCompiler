namespace mcc
{
    internal abstract class ParsedLineWithLabel : ParsedLine
    {
        public ParsedLineWithLabel(int lineNumber, int orgValue, string label, string content, Logger logger) : base(lineNumber, orgValue, label, content, logger)
        {
            Assert(!string.IsNullOrEmpty(this.Label), "Label missing (all microinstruction field definitions and aliases require it)");
        }
    }

}
