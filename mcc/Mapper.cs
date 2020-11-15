using System.Collections.Generic;
using System.IO;
using System.Text;

namespace mcc
{
    internal class Mapper : MemBlock
    {
        public int Depth; // must be 2^n
        public int Width; // must be >0

        public Mapper(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".mapper", lineNumber, orgValue, label, content, logger)
        {
            this.Depth = -1;
            this.Width = -1;
        }

        protected override int GenerateVhdFile(string prefix, FileInfo outputFileInfo, List<MicroField> fields, string otherRanges, bool isConversion)
        {
            Assert(!string.IsNullOrEmpty(prefix), "<prefix>:<mapperfilename>.vhd expected - prefix not found");
            Assert(fields == null, "Unexpected data passed in");

            logger.Write($"Generating mapper '{outputFileInfo.FullName}' ...");
            string template = LoadVhdPackageTemplate(isConversion ? "conversion_template.vhd" : "mapper_template.vhd", isConversion);
            int capacity = 2 << (this.addressWidth - 1);
            string name = outputFileInfo.Name.Substring(0, outputFileInfo.Name.IndexOf("."));

            using (System.IO.StreamWriter vhdFile = new System.IO.StreamWriter(outputFileInfo.FullName, false, Encoding.ASCII))
            {
                logger.PrintBanner(vhdFile);
                template = template.Replace("[NAME]", name);
                template = template.Replace("[FIELDS]", string.Empty);
                template = template.Replace("[SIZES]", GetVhdlSizes("MAPPER", null));
                template = template.Replace("[TYPE]", $"type {prefix}_mapper_memory is array(0 to {capacity - 1}) of std_logic_vector({dataWidth - 1} downto 0);");
                template = template.Replace("[SIGNAL]", $"signal {prefix}_instructionstart: std_logic_vector({dataWidth - 1} downto 0);");
                template = template.Replace("[MEMORY]", $"constant {prefix}_mapper: {prefix}_mapper_memory := ({GetVhdMemory(capacity, null, otherRanges)});");
                template = template.Replace("[PLACEHOLDERS]", " [SIZES], [NAME], [TYPE], [SIGNAL], [MEMORY]");
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
