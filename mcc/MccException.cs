using System;

namespace mcc
{
    internal class MccException : Exception
    {
        private int line;
        private string file;
        private string customMessage;

        public MccException(int lineNumber, string fileName, string message) : base(message)
        {
            this.line = lineNumber;
            this.file = fileName;
            this.customMessage = message;
        }

        public override String Message
        {
            get
            {
                return $"Error in file '{file}' line {line}: {customMessage}.";
            }
        }
    }
}
