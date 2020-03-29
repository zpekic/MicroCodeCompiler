using System;

namespace mcc
{
    internal class MccException : Exception
    {
        private int line;
        private string customMessage;

        public MccException(int lineNumber, string message) : base(message)
        {
            this.line = lineNumber;
            this.customMessage = message;
        }

        public override String Message
        {
            get
            {
                return String.Format("Error in line {0}: {1}.", line.ToString(), customMessage);
            }
        }
    }
}
