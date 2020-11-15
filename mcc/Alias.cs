namespace mcc
{
    internal class Alias : ParsedLineWithLabel
    {
        public Alias(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".alias", lineNumber, orgValue, label, content, logger)
        {

        }

    }

}
