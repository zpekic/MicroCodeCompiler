using System.Collections.Generic;
using System.IO;
using System.Text;

namespace mcc
{
    internal class Code : MemBlock
    {
        public Code(int lineNumber, int orgValue, string label, string content, Logger logger) : base(lineNumber, orgValue, label, content, logger)
        {
        }

        protected override int GenerateVhdFile(FileInfo outputFileInfo, List<MicroField> fields)
        {
            logger.Write($"Generating code '{outputFileInfo.FullName}' ...");
            string template = LoadFile("code_template.vhd");
            int capacity = 2 << (this.addressWidth - 1);

            using (System.IO.StreamWriter vhdFile = new System.IO.StreamWriter(outputFileInfo.FullName, false, Encoding.ASCII))
            {
                logger.PrintBanner(vhdFile);
                template = template.Replace("[NAME]", outputFileInfo.Name.Substring(0, outputFileInfo.Name.IndexOf(".")));
                template = template.Replace("[FIELDS]", GetVhdFields(fields));
                template = template.Replace("[TYPE]", $"type code_memory is array(0 to {capacity - 1}) of std_logic_vector({dataWidth - 1} downto 0);");
                template = template.Replace("[SIGNAL]", $"signal ucode: std_logic_vector({dataWidth - 1} downto 0);");
                template = template.Replace("[MEMORY]", $"constant microcode: code_memory := ({GetVhdMemory(capacity)});");
                template = template.Replace("[PLACEHOLDERS]", " [NAME], [TYPE], [FIELDS], [SIGNAL], [MEMORY]");
                vhdFile.WriteLine(template);
            }

            logger.WriteLine(" Done.");
            return 1;
        }

        protected string GetVhdFields(List<MicroField> fields)
        {
            Assert(fields != null && (fields.Count > 0), "Can't generate code - no microcode fields defined");

            StringBuilder sbFields = new StringBuilder();
            foreach (MicroField field in fields)
            {
                sbFields.AppendLine($"--");
                sbFields.AppendLine($"-- {field.GetParsedLineString()}");
                sbFields.AppendLine($"--");
                if (field.Hi > field.Lo)
                {
                    sbFields.AppendLine($"alias uc_{field.Label}: \tstd_logic_vector({field.Hi - field.Lo} downto 0) is ucode({field.Hi} downto {field.Lo});");
                }
                else
                {
                    Assert(field.Hi == field.Lo, $"Unexpected field span ({field.Hi} .. {field.Lo})");
                    sbFields.AppendLine($"alias uc_{field.Label}: \tstd_logic is ucode({field.Hi});");
                }
                foreach (MicroField.ValueVector vv in field.Values)
                {
                    sbFields.AppendLine(vv.GetVhdLine(field));
                }
                sbFields.AppendLine();
            }

            return sbFields.ToString();
        }

        protected override string GetBlockName()
        {
            return this.GetType().ToString();
        }

    }

}
