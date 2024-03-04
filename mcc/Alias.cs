namespace mcc
{
    internal class Alias : ParsedLineWithLabel
    {
        public string[] Lines;

        public Alias(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".alias", lineNumber, orgValue, label, content, logger)
        {
            Lines = content.Split('\\');
            for (int i = 0; i < Lines.Length; i++)
            {
                Lines[i] = Lines[i].Trim();
            }
        }

    }

}
