namespace mcc
{
    internal abstract class ParsedLineWithLabel : ParsedLine
    {
        public ParsedLineWithLabel(int lineNumber, int orgValue, string label, string content) : base(lineNumber, orgValue, label, content)
        {
            Assert(!string.IsNullOrEmpty(this.Label), "Label missing (all microinstruction field definitions and aliases require it)");
        }
    }

}
