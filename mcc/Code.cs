using System.Collections.Generic;
using System.IO;
using System.Text;

namespace mcc
{
    internal class Code : MemBlock
    {
        public Code(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".code", lineNumber, orgValue, label, content, logger)
        {
        }

        protected override int GenerateVhdFile(string prefix, FileInfo outputFileInfo, List<MicroField> fields, string otherRanges, bool isConversion)
        {
            Assert(!string.IsNullOrEmpty(prefix), "<prefix>:<codefilename>.vhd expected - prefix not found");
            Assert(!isConversion, "Code memory cannot be used for conversion (internal error)");

            logger.Write($"Generating code '{outputFileInfo.FullName}' ...");
            string template = LoadVhdPackageTemplate("code_template.vhd", false);
            int capacity = 2 << (this.addressWidth - 1);
            string defaultMicroinstruction = string.Empty;
            string name = outputFileInfo.Name.Substring(0, outputFileInfo.Name.IndexOf("."));

            MicroField fif = fields.Find(fl => fl.GetType().ToString() == "mcc.FieldIf");

            using (System.IO.StreamWriter vhdFile = new System.IO.StreamWriter(outputFileInfo.FullName, false, Encoding.ASCII))
            {
                logger.PrintBanner(vhdFile);
                template = template.Replace("[NAME]", name);
                template = template.Replace("[FIELDS]", GetVhdFields(prefix, fields, out defaultMicroinstruction));
                template = template.Replace("[SIZES]", GetVhdlSizes("CODE", fif as FieldIf));
                template = template.Replace("[TYPE]", $"type {prefix}_code_memory is array(0 to {capacity - 1}) of std_logic_vector({dataWidth - 1} downto 0);");
                template = template.Replace("[SIGNAL]", $"signal {prefix}_uinstruction: std_logic_vector({dataWidth - 1} downto 0);");
                template = template.Replace("[INSTANCE]", $"--{prefix}_uinstruction <= {prefix}_microcode(to_integer(unsigned(TODO))); -- copy to file containing the control unit. TODO is typically replace with 'ui_address' control unit output");
                template = template.Replace("[MEMORY]", $"constant {prefix}_microcode: {prefix}_code_memory := ({GetVhdMemory(capacity, defaultMicroinstruction, otherRanges)});");
                template = template.Replace("[PLACEHOLDERS]", " [NAME], [FIELDS], [SIZES], [TYPE], [SIGNAL], [INSTANCE], [MEMORY]");
                vhdFile.WriteLine(template);
            }

            logger.WriteLine(" Done.");
            return 1;
        }

        public static string GetFieldLabel(MicroField mf)
        {
            //Assert(mf != null && !string.IsNullOrEmpty(mf.Label), "Undefined field label");

            return mf.Label;
        }

        protected string GetVhdFields(string prefix, List<MicroField> fields, out string defaultMicroinstruction)
        {
            Assert(fields != null && (fields.Count > 0), "Can't generate code - no microcode fields defined");

            StringBuilder sbFields = new StringBuilder();
            StringBuilder sbDefault = new StringBuilder();
            List<string> fieldLabels = fields.ConvertAll(new System.Converter<MicroField, string>(GetFieldLabel));
            foreach (MicroField field in fields)
            {
                sbDefault.Append(GetBinaryString(field.DefaultValue, field.Width));
                sbDefault.Append("_");

                sbFields.AppendLine($"--");
                sbFields.AppendLine($"-- {field.GetParsedLineString()}");
                sbFields.AppendLine($"--");
                if (field.Hi > field.Lo)
                {
                    sbFields.AppendLine($"alias {prefix}_{field.Label}: \tstd_logic_vector({field.Hi - field.Lo} downto 0) is {prefix}_uinstruction({field.Hi} downto {field.Lo});");
                }
                else
                {
                    Assert(field.Hi == field.Lo, $"Unexpected field span ({field.Hi} .. {field.Lo})");
                    sbFields.AppendLine($"alias {prefix}_{field.Label}: \tstd_logic is {prefix}_uinstruction({field.Hi});");
                }
                foreach (MicroField.ValueVector vv in field.Values)
                {
                    sbFields.AppendLine(vv.GetVhdLine(field, field is FieldIf));
                }

                // attempt to create VHDL code for lazy copy/pasting
                StringBuilder sbCode = field.GetVhdlBoilerplateCode(prefix, fieldLabels);
                sbFields.Append(sbCode);

                sbFields.AppendLine();
                sbFields.AppendLine();
            }

            // remove last underscore
            sbDefault.Remove(sbDefault.Length - 1, 1);
            defaultMicroinstruction = sbDefault.ToString();

            return sbFields.ToString();
        }

        protected override string GetBlockName()
        {
            return this.GetType().ToString();
        }

    }

}
