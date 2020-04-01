using System.Collections.Generic;
using System.IO;
using System.Text;

namespace mcc
{
    internal class Mapper : MemBlock
    {
        public int Depth; // must be 2^n
        public int Width; // must be >0

        public Mapper(int lineNumber, int orgValue, string label, string content, Logger logger) : base(lineNumber, orgValue, label, content, logger)
        {
            this.Depth = -1;
            this.Width = -1;
        }

        protected override int GenerateVhdFile(FileInfo outputFileInfo, List<MicroField> fields)
        {
            Assert(fields == null, "Unexpected data passed in");
            logger.Write($"Generating mapper '{outputFileInfo.FullName}' ...");
            string template = LoadFile("mapper_template.vhd");
            int capacity = 2 << (this.addressWidth - 1);

            using (System.IO.StreamWriter vhdFile = new System.IO.StreamWriter(outputFileInfo.FullName, false, Encoding.ASCII))
            {
                logger.PrintBanner(vhdFile);
                template = template.Replace("[NAME]", outputFileInfo.Name.Substring(0, outputFileInfo.Name.IndexOf(".")));
                template = template.Replace("[FIELDS]", string.Empty);
                template = template.Replace("[TYPE]", $"type mapper_memory is array(0 to {capacity - 1}) of std_logic_vector({dataWidth - 1} downto 0);");
                template = template.Replace("[SIGNAL]", $"signal instructionstart: std_logic_vector({dataWidth - 1} downto 0);");
                template = template.Replace("[MEMORY]", $"constant mapper: mapper_memory := ({GetVhdMemory(capacity)});");
                template = template.Replace("[PLACEHOLDERS]", " [NAME], [TYPE], [SIGNAL], [MEMORY]");
                vhdFile.WriteLine(template);
            }

            logger.WriteLine(" Done.");
            return 1;
        }

        protected override string GetBlockName()
        {
            return this.GetType().ToString();
        }

    }

}
