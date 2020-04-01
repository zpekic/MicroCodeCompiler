namespace mcc
{
    internal class FieldVal : MicroField
    {
        public int From;
        public int To;

        public FieldVal(int lineNumber, int orgValue, string label, string content, Logger logger) : base(lineNumber, orgValue, label, content, logger)
        {
            this.From = -1;
            this.To = -1;
        }


    }

}
