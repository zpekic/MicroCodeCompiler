using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading.Tasks;

namespace mcc
{
    internal class Controller : ParsedLineWithNoLabel
    {
        protected List<string> outputFiles = new List<string>();
        protected int stackDepth;
        protected bool isRisingEdge = true;

        public Controller(int lineNumber, int orgValue, string label, string content, Logger logger) : base(".controller", lineNumber, orgValue, label, content, logger)
        {
            Assert(orgValue < 0, "Definition statement must precede .org");
        }

        public override void ParseContent()
        {
            int lastParamOffset = 1;
            bool edgeSet = false;

            base.ParseContent();

            string[] param = this.Content.Split(',');

            Assert(param.Length > 1, "Missing parameter(s) - expected: filename0.ext[, filename1.ext [, ...]], stack_depth[, rising|falling]");

            if ("rising".Equals(param[param.Length - 1].Trim(), StringComparison.InvariantCultureIgnoreCase))
            {
                lastParamOffset++;
                isRisingEdge = true;
                edgeSet = true;
            }
            if ("falling".Equals(param[param.Length - 1].Trim(), StringComparison.InvariantCultureIgnoreCase))
            {
                lastParamOffset++;
                isRisingEdge = false;
                edgeSet = true;
            }
            for (int i = 0; i < param.Length - lastParamOffset; i++)
            {
                outputFiles.Add(param[i].Trim());
            }
            Assert(int.TryParse(param[param.Length - lastParamOffset], out this.stackDepth), "Bad stack depth");
            Assert((this.stackDepth > 1) && (this.stackDepth < 9), "Stack depth must be between 2 and 8");
            Assert(outputFiles.Count >= 0, "No output files specified");
            if (edgeSet)
            {
                logger.WriteLine("Clock edge explicitly set to " + (isRisingEdge ? "rising_edge()" : "falling_edge()"));
            }
            else
            {
                logger.WriteLine("Warning: Clock edge implicitly (by default) set to " + (isRisingEdge ? "rising_edge()" : "falling_edge()"));
            }
        }

        public bool GetClockEdge()
        {
            return this.isRisingEdge;
        }

        public int GenerateFiles(string trace)
        {
            int count = 0;

            logger.WriteLine(trace);

            foreach (string fileName in this.outputFiles)
            {
                FileInfo outputFileInfo = null;
                string prefix = null;
                string[] prefixNamePair = fileName.Split(':');

                switch (prefixNamePair.Length)
                {
                    case 0:
                        Assert(false, $"Filename '{fileName}' is invalid.");
                        break;
                    case 1:
                        outputFileInfo = new FileInfo(prefixNamePair[0]);
                        break;
                    case 2:
                        prefix = prefixNamePair[0];
                        outputFileInfo = new FileInfo(prefixNamePair[1]);
                        logger.WriteLine(string.Format("Warning in line {0}: prefix '{1}' will be ignored", this.LineNumber.ToString(), prefix));
                        break;
                    default:
                        Assert(false, $"Filename '{fileName}' is invalid.");
                        break;
                }

                switch (outputFileInfo.Extension.ToLowerInvariant())
                {
                    case ".vhd":
                        count += GenerateVhdFile(outputFileInfo, this.isRisingEdge);
                        break;
                    default:
                        logger.WriteLine(string.Format("Warning in line {0}: unsupported extension in file '{1}'", this.LineNumber.ToString(), fileName));
                        break;
                }
            }
            return count;
        }

        private int GenerateVhdFile(FileInfo outputFileInfo, bool isRisingEdge)
        {
            logger.Write($"Generating controller '{outputFileInfo.FullName}' ...");
            string stack_def = string.Empty;
            string stack_push = string.Empty;
            string stack_pop = string.Empty;
            for (int i = 0; i < this.stackDepth; i++)
            {
                if ((this.stackDepth - i) == 1)
                {
                    stack_def += $"uPC{i} ";
                    stack_pop += $"\t\t\t\t\t\t\t\tuPC{i} <= (others => '0');\r\n";
                }
                else
                {
                    stack_def += $"uPC{i}, ";
                    stack_pop += $"\t\t\t\t\t\t\t\tuPC{i} <= uPC{i + 1};\r\n";
                }

                switch (i)
                {
                    case 0:
                        stack_push += $"\t\t\t\tuPC{i} <= ui_nextinstr;\r\n";
                        break;
                    case 1:
                        stack_push += $"\t\t\t\t\t\tuPC1 <= std_logic_vector(unsigned(uPC0) + 1);\r\n";
                        break;
                    default:
                        stack_push += $"\t\t\t\t\t\tuPC{i} <= uPC{i - 1};\r\n";
                        break;
                }
            }
            stack_pop  = stack_pop.TrimEnd(new char[] {'\r', '\n'});
            stack_push = stack_push.TrimEnd(new char[] {'\r','\n'});

            string template = LoadVhdControllerTemplate("controller_template.vhd", this.isRisingEdge);
            string name = outputFileInfo.Name.Substring(0, outputFileInfo.Name.IndexOf("."));
            using (System.IO.StreamWriter vhdFile = new System.IO.StreamWriter(outputFileInfo.FullName, false, Encoding.ASCII))
            {
                logger.PrintBanner(vhdFile);
                template = template.Replace("[NAME]", name);
                //template = template.Replace("[PREFIX]", prefix);
                template = template.Replace("[STACK_DEF]", stack_def);
                template = template.Replace("[STACK_PUSH]", stack_push);
                template = template.Replace("[STACK_POP]", stack_pop);
                template = template.Replace("[PLACEHOLDERS]", " [NAME], [STACK_DEF], [STACK_PUSH], [STACK_POP]");
                vhdFile.WriteLine(template);
            }

            logger.WriteLine(" Done.");
            return 1;
        }

        private string LoadVhdControllerTemplate(string fileName, bool isRisingEdge)
        {
            if (File.Exists(fileName))
            {
                return File.ReadAllText(fileName);
            }
            else
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendLine($"-- Auto-generated file, do not modify. To customize, create '{fileName}' file in mcc.exe folder");
                sb.AppendLine("-- Supported placeholders: [PLACEHOLDERS].");
                sb.AppendLine("--------------------------------------------------------");
                sb.AppendLine("library IEEE;");
                sb.AppendLine("use IEEE.STD_LOGIC_1164.all;");
                sb.AppendLine("use IEEE.numeric_std.all;");
                sb.AppendLine();
                sb.AppendLine("entity [NAME] is");
                sb.AppendLine("     Generic (");
                sb.AppendLine("            CODE_DEPTH : positive;");
                sb.AppendLine("            IF_WIDTH : positive");
                sb.AppendLine("          );");
                sb.AppendLine("     Port ( ");
                sb.AppendLine("          -- standard inputs");
                sb.AppendLine("          reset : in  STD_LOGIC;");
                sb.AppendLine("          clk : in  STD_LOGIC;");
                sb.AppendLine("          -- design specific inputs");
                sb.AppendLine("          seq_cond : in  STD_LOGIC_VECTOR (IF_WIDTH - 1 downto 0);");
                sb.AppendLine("          seq_then : in  STD_LOGIC_VECTOR (CODE_DEPTH - 1 downto 0);");
                sb.AppendLine("          seq_else : in  STD_LOGIC_VECTOR (CODE_DEPTH - 1 downto 0);");
                sb.AppendLine("          seq_fork : in  STD_LOGIC_VECTOR (CODE_DEPTH - 1 downto 0);");
                sb.AppendLine("          cond : in  STD_LOGIC_VECTOR (2 ** IF_WIDTH - 1 downto 0);");
                sb.AppendLine("          -- outputs");
                sb.AppendLine("          ui_nextinstr : buffer  STD_LOGIC_VECTOR (CODE_DEPTH - 1 downto 0);");
                sb.AppendLine("          ui_address : out  STD_LOGIC_VECTOR (CODE_DEPTH - 1 downto 0));");
                sb.AppendLine("end [NAME];");
                sb.AppendLine();
                sb.AppendLine("architecture Behavioral of [NAME] is");
                sb.AppendLine();
                sb.AppendLine("constant zero: std_logic_vector(31 downto 0) := X\"00000000\";");
                sb.AppendLine();
                sb.AppendLine("signal [STACK_DEF]: std_logic_vector(CODE_DEPTH - 1 downto 0);");
                sb.AppendLine("signal condition, push, jump: std_logic;");
                sb.AppendLine();
                sb.AppendLine("begin");
                sb.AppendLine();
                sb.AppendLine("-- uPC holds the address of current microinstruction");
                sb.AppendLine("ui_address <= uPC0;");
                sb.AppendLine("-- evaluate if true/false");
                sb.AppendLine("condition <= cond(to_integer(unsigned(seq_cond)));");
                sb.AppendLine("-- select next instruction based on condition");
                sb.AppendLine("ui_nextinstr <= seq_then when (condition = '1') else seq_else;");
                sb.AppendLine("-- check if jump or one of 4 \"special\" instructions");
                sb.AppendLine("jump <= '0' when (ui_nextinstr(CODE_DEPTH - 1 downto 2) = zero(CODE_DEPTH - 3 downto 0)) else '1';");
                sb.AppendLine("-- push only if both branches are same");
                sb.AppendLine("push <= '1' when (seq_then = seq_else) else '0';");
                sb.AppendLine();
                sb.AppendLine("sequence: process(reset, clk, push, jump, ui_nextinstr)");
                sb.AppendLine("begin");
                sb.AppendLine("   if (reset = '1') then");
                sb.AppendLine("        uPC0 <= (others => '0');	-- reset clears top microcode program counter");
                sb.AppendLine("	  else");
                sb.AppendLine(isRisingEdge ? "       if (rising_edge(clk)) then" : "       if (falling_edge(clk)) then");
                sb.AppendLine("             if (jump = '1') then");
                sb.AppendLine("                  if (push = '1') then");
                sb.AppendLine("[STACK_PUSH]");
                sb.AppendLine("                  else");
                sb.AppendLine("                     uPC0 <= ui_nextinstr;");
                sb.AppendLine("                  end if;");
                sb.AppendLine("             else");
                sb.AppendLine("                 case (ui_nextinstr(1 downto 0)) is");
                sb.AppendLine("                     when \"00\" =>	-- next");
                sb.AppendLine("                         uPC0 <= std_logic_vector(unsigned(uPC0) + 1);");
                sb.AppendLine("                     when \"01\" =>	-- repeat");
                sb.AppendLine("                         uPC0 <= uPC0;");
                sb.AppendLine("                     when \"10\" =>	-- return");
                sb.AppendLine("[STACK_POP]");
                sb.AppendLine("                     when \"11\" =>	-- fork");
                sb.AppendLine("                         uPC0 <= seq_fork;");
                sb.AppendLine("                     when others =>");
                sb.AppendLine("                         null;");
                sb.AppendLine("                 end case;");
                sb.AppendLine("             end if;");
                sb.AppendLine("         end if;");
                sb.AppendLine("     end if;");
                sb.AppendLine("end process; ");
                sb.AppendLine();
                sb.AppendLine("end;");

                return sb.ToString();
            }
        }

    }
}
