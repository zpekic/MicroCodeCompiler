namespace mcc
{
    internal abstract class ParsedLineWithNoLabel : ParsedLine
    {
        public ParsedLineWithNoLabel(int lineNumber, int orgValue, string label, string content, object[] data) : base(lineNumber, orgValue, label, content)
        {
            Assert(string.IsNullOrEmpty(this.Label), "Label not allowed (maybe should be on subsequent microinstruction?)");
        }

    }

}
