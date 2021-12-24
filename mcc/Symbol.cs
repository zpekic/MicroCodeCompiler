using System.Collections.Generic;
using System.IO;
using System.Text;

namespace mcc
{
    internal class Symbol : MemBlock
    {
        private int rowCnt, colCnt;

        public Symbol(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".symbol", lineNumber, orgValue, label, content, logger)
        {
        }

        internal void InitAll()
        {
            rowCnt = 1 << addressWidth;
            colCnt = dataWidth >> 3;
            byte[] byteEntry = new byte[colCnt];
            for (int r = 0; r < rowCnt; r++)
            {
                for (int c = 0; c < colCnt; c++)
                {
                    byteEntry[c] = (byte)' ';    // initialize with spaces
                }
                Write(r, byteEntry, string.Empty, string.Empty, -1, "symbol");
            }
        }

        internal void InitEntry(MicroInstruction mi)
        {
            string symEntry;
            byte[] byteEntry = new byte[colCnt];
            Assert(mi.OrgValue < rowCnt, $".symbol write to entry {mi.OrgValue} beyond limit of {rowCnt}");

            if (string.IsNullOrEmpty(mi.Label))
            {
                symEntry = $"{mi.Content};";
            }
            else
            {
                symEntry = $"{mi.Label}: {mi.Content};";
            }
            for (int c = 0; c < colCnt; c++)
            {
                if (c < symEntry.Length)
                {
                    byteEntry[c] = (byte)symEntry[c];
                }
                else
                {
                    byteEntry[c] = (byte) ' '; // fill with space
                }
            }
            memory.Remove(mi.OrgValue);
            Write(mi.OrgValue, byteEntry, mi.GetParsedLineString(), symEntry, -1, "symbol");
        }

        protected override int GenerateVhdFile(string prefix, FileInfo outputFileInfo, List<MicroField> fields, string otherRanges, bool isConversion, bool isRisingEdge)
        {
            Assert(!string.IsNullOrEmpty(prefix), "<prefix>:<codefilename>.vhd expected - prefix not found");
            Assert(!isConversion, "Code memory cannot be used for conversion (internal error)");

            logger.Write($"Generating code '{outputFileInfo.FullName}' ...");
            string template = LoadVhdPackageTemplate("symbol_template.vhd", false);
            int capacity = 2 << (this.addressWidth - 1);
            string defaultMicroinstruction = string.Empty;
            string name = outputFileInfo.Name.Substring(0, outputFileInfo.Name.IndexOf("."));
            MicroField fif = null;

            if (fields != null)
            {
                fif = fields.Find(fl => fl.GetType().ToString() == "mcc.FieldIf");
            }

            using (System.IO.StreamWriter vhdFile = new System.IO.StreamWriter(outputFileInfo.FullName, false, Encoding.ASCII))
            {
                logger.PrintBanner(vhdFile);
                template = template.Replace("[NAME]", name);
                template = template.Replace("[FIELDS]", string.Empty);
                template = template.Replace("[SIZES]", GetVhdlSizes("SYMBOL"));
                template = template.Replace("[TYPE]", GetVhdlTypes(prefix));
                template = template.Replace("[SIGNAL]", GetVhdlSignals(prefix));
                template = template.Replace("[INSTANCE]", string.Empty);
                template = template.Replace("[MEMORY]", $"constant {prefix}_symbol_entry: t_{prefix}_symbol_entry := ({GetVhdMemory(capacity, defaultMicroinstruction, otherRanges, true)});");
                template = template.Replace("[PLACEHOLDERS]", " [NAME], [FIELDS], [SIZES], [TYPE], [SIGNAL], [INSTANCE], [MEMORY]");
                vhdFile.WriteLine(template);
            }

            logger.WriteLine(" Done.");
            return 1;
        }

        protected string GetVhdlSizes(string prefix)
        {
            StringBuilder sbSizes = new StringBuilder(base.GetVhdlSizes(prefix, null));

            int byte_last = this.dataWidth >> 3;
            int byte_width = GetLog2(byte_last);
            Assert(byte_width > 0, $"Symbol table width in bytes ({byte_last}) is not a power of 2");

            sbSizes.AppendLine($"constant SYMBOL_BYTE_LAST: \tpositive := {byte_last - 1};");
            sbSizes.AppendLine($"constant SYMBOL_BYTE_WIDTH: positive := {byte_width};");

            return sbSizes.ToString();
        }

        protected string GetVhdlSignals(string prefix)
        {
            StringBuilder sbSignals = new StringBuilder();

            sbSignals.AppendLine($"signal {prefix}_symbol_byte: t_{prefix}_symbol_byte;");
            sbSignals.AppendLine($"signal {prefix}_sym_d: std_logic_vector(7 downto 0);");
            sbSignals.AppendLine($"signal {prefix}_sym_a: std_logic_vector(SYMBOL_ADDRESS_WIDTH + SYMBOL_BYTE_WIDTH - 1 downto 0);");
            sbSignals.AppendLine("----Start boilerplate code(use with utmost caution!)");
            sbSignals.AppendLine($"-- {prefix}_sym_a <= -- TODO concatenate microinstruction address and character address");
            sbSignals.AppendLine($"-- {prefix}_sym_d <= {prefix}_symbol_byte(to_integer(unsigned({prefix}_sym_a)));");
            sbSignals.AppendLine($"----convert symbol entries to byte-oriented ROM");
            sbSignals.AppendLine($"--gen_r: for r in 0 to SYMBOL_ADDRESS_LAST generate");
            sbSignals.AppendLine($"--begin");
            sbSignals.AppendLine($"--    gen_c: for c in 0 to SYMBOL_BYTE_LAST generate");
            sbSignals.AppendLine($"--   begin");
            sbSignals.AppendLine($"--           --assert false report \"r = \" & integer'image(r) & \" c = \" & integer'image(c) severity note;");
            sbSignals.AppendLine($"--           {prefix}_symbol_byte(r * (SYMBOL_BYTE_LAST + 1) + c) <= {prefix}_symbol_entry(r)(SYMBOL_DATA_WIDTH - 8 * c - 1 downto SYMBOL_DATA_WIDTH - 8 * (c + 1));");
            sbSignals.AppendLine($"--   end generate;");
            sbSignals.AppendLine($"--end generate;");
            sbSignals.AppendLine("----End boilerplate code");

            return sbSignals.ToString();
        }

        protected string GetVhdlTypes(string prefix)
        {
            StringBuilder sbTypes = new StringBuilder();

            sbTypes.AppendLine($"type t_{prefix}_symbol_entry is array(0 to SYMBOL_ADDRESS_LAST) of std_logic_vector(SYMBOL_DATA_WIDTH -1 downto 0);");
            sbTypes.AppendLine($"type t_{prefix}_symbol_byte is array(0 to(SYMBOL_ADDRESS_LAST + 1) * (SYMBOL_BYTE_LAST + 1) - 1) of std_logic_vector(7 downto 0);");

            return sbTypes.ToString();
        }

        public static string GetFieldLabel(MicroField mf)
        {
            //Assert(mf != null && !string.IsNullOrEmpty(mf.Label), "Undefined field label");

            return mf.Label;
        }

        protected string GetVhdFields(string prefix, List<MicroField> fields, out string defaultMicroinstruction, bool isRisingEdge)
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
                StringBuilder sbCode = field.GetVhdlBoilerplateCode(prefix, fieldLabels, isRisingEdge);
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
