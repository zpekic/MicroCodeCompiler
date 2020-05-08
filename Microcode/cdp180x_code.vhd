--------------------------------------------------------
-- mcc V0.9.0425 - Custom microcode compiler (c)2020-... 
--    https://github.com/zpekic/MicroCodeCompiler
--------------------------------------------------------
-- Auto-generated file, do not modify. To customize, create 'code_template.vhd' file in mcc.exe folder
-- Supported placeholders:  [NAME], [SIZES], [TYPE], [FIELDS], [SIGNAL], [MEMORY].
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

package cdp180x_code is

-- memory block size
constant CODE_DATA_WIDTH: 	positive := 64;
constant CODE_ADDRESS_WIDTH: 	positive := 8;
constant CODE_ADDRESS_LAST: 	positive := 255;
constant CODE_IF_WIDTH: 	positive := 4;


type code_memory is array(0 to 255) of std_logic_vector(63 downto 0);

signal ucode: std_logic_vector(63 downto 0);

--
-- L0008.direction: 3 valuesnop,-,dev2any,cpu2mem,mem2any,-,-,-default nop
--
alias uc_direction: 	std_logic_vector(2 downto 0) is ucode(63 downto 61);
constant direction_nop: 	std_logic_vector(2 downto 0) := "000";
-- Value "001" not allowed (name '-' is not assignable)
constant direction_dev2any: 	std_logic_vector(2 downto 0) := "010";
constant direction_cpu2mem: 	std_logic_vector(2 downto 0) := "011";
constant direction_mem2any: 	std_logic_vector(2 downto 0) := "100";
-- Value "101" not allowed (name '-' is not assignable)
-- Value "110" not allowed (name '-' is not assignable)
-- Value "111" not allowed (name '-' is not assignable)

--
-- L0019.reg_sample: 1 values same, sample default same
--
alias uc_reg_sample: 	std_logic is ucode(60);
constant reg_sample_same: 	std_logic := '0';
constant reg_sample_sample: 	std_logic := '1';

--
-- L0021.seq_cond: 4 valuestrue,mode_1805,TPB,cond_3X,cond_4,cond_5,continue,continue_sw,cond_df,externalInt,counterInt,alu16_zero,cond_CX,traceEnabled,traceReady,falsedefault true
--
alias uc_seq_cond: 	std_logic_vector(3 downto 0) is ucode(59 downto 56);
constant seq_cond_true: 	integer := 0;
constant seq_cond_mode_1805: 	integer := 1;
constant seq_cond_TPB: 	integer := 2;
constant seq_cond_cond_3X: 	integer := 3;
constant seq_cond_cond_4: 	integer := 4;
constant seq_cond_cond_5: 	integer := 5;
constant seq_cond_continue: 	integer := 6;
constant seq_cond_continue_sw: 	integer := 7;
constant seq_cond_cond_df: 	integer := 8;
constant seq_cond_externalInt: 	integer := 9;
constant seq_cond_counterInt: 	integer := 10;
constant seq_cond_alu16_zero: 	integer := 11;
constant seq_cond_cond_CX: 	integer := 12;
constant seq_cond_traceEnabled: 	integer := 13;
constant seq_cond_traceReady: 	integer := 14;
constant seq_cond_false: 	integer := 15;

--
-- L0039.seq_then: 8 values next, repeat, return, fork, @ default next
--
alias uc_seq_then: 	std_logic_vector(7 downto 0) is ucode(55 downto 48);
constant seq_then_next: 	std_logic_vector(7 downto 0) := X"00";
constant seq_then_repeat: 	std_logic_vector(7 downto 0) := X"01";
constant seq_then_return: 	std_logic_vector(7 downto 0) := X"02";
constant seq_then_fork: 	std_logic_vector(7 downto 0) := X"03";
-- Jump targets allowed!

--
-- L0040.seq_else: 8 values next, repeat, return, fork, 0x00..0xFF, @ default next
--
alias uc_seq_else: 	std_logic_vector(7 downto 0) is ucode(47 downto 40);
constant seq_else_next: 	std_logic_vector(7 downto 0) := X"00";
constant seq_else_repeat: 	std_logic_vector(7 downto 0) := X"01";
constant seq_else_return: 	std_logic_vector(7 downto 0) := X"02";
constant seq_else_fork: 	std_logic_vector(7 downto 0) := X"03";
-- Values from X"00" to X"FF" allowed
-- Jump targets allowed!

--
-- L0043.reg_d: 3 values same, alu_y, shift_dn_df, shift_dn_0 default same
--
alias uc_reg_d: 	std_logic_vector(2 downto 0) is ucode(39 downto 37);
constant reg_d_same: 	std_logic_vector(2 downto 0) := "000";
constant reg_d_alu_y: 	std_logic_vector(2 downto 0) := "001";
constant reg_d_shift_dn_df: 	std_logic_vector(2 downto 0) := "010";
constant reg_d_shift_dn_0: 	std_logic_vector(2 downto 0) := "011";

--
-- L0044.reg_df: 2 values same, d_msb, d_lsb, alu_cout default same
--
alias uc_reg_df: 	std_logic_vector(1 downto 0) is ucode(36 downto 35);
constant reg_df_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_df_d_msb: 	std_logic_vector(1 downto 0) := "01";
constant reg_df_d_lsb: 	std_logic_vector(1 downto 0) := "10";
constant reg_df_alu_cout: 	std_logic_vector(1 downto 0) := "11";

--
-- L0045.reg_t: 2 values same, alu_y, xp, in default same
--
alias uc_reg_t: 	std_logic_vector(1 downto 0) is ucode(34 downto 33);
constant reg_t_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_t_alu_y: 	std_logic_vector(1 downto 0) := "01";
constant reg_t_xp: 	std_logic_vector(1 downto 0) := "10";
constant reg_t_in: 	std_logic_vector(1 downto 0) := "11";

--
-- L0046.reg_b: 2 values same, alu_y, t, df_d_dn default same
--
alias uc_reg_b: 	std_logic_vector(1 downto 0) is ucode(32 downto 31);
constant reg_b_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_b_alu_y: 	std_logic_vector(1 downto 0) := "01";
constant reg_b_t: 	std_logic_vector(1 downto 0) := "10";
constant reg_b_df_d_dn: 	std_logic_vector(1 downto 0) := "11";

--
-- L0047.reg_x: 2 values same, n, alu_yhi, p default same
--
alias uc_reg_x: 	std_logic_vector(1 downto 0) is ucode(30 downto 29);
constant reg_x_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_x_n: 	std_logic_vector(1 downto 0) := "01";
constant reg_x_alu_yhi: 	std_logic_vector(1 downto 0) := "10";
constant reg_x_p: 	std_logic_vector(1 downto 0) := "11";

--
-- L0048.reg_p: 2 values same, n, alu_ylo, default same
--
alias uc_reg_p: 	std_logic_vector(1 downto 0) is ucode(28 downto 27);
constant reg_p_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_p_n: 	std_logic_vector(1 downto 0) := "01";
constant reg_p_alu_ylo: 	std_logic_vector(1 downto 0) := "10";
-- Value "11" allowed

--
-- L0049.reg_in: 1 values same, alu_y default same
--
alias uc_reg_in: 	std_logic is ucode(26);
constant reg_in_same: 	std_logic := '0';
constant reg_in_alu_y: 	std_logic := '1';

--
-- L0050.reg_q: 2 values same, zero, one default same
--
alias uc_reg_q: 	std_logic_vector(1 downto 0) is ucode(25 downto 24);
constant reg_q_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_q_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_q_one: 	std_logic_vector(1 downto 0) := "10";

--
-- L0051.reg_mie: 2 values same, enable, disable default same
--
alias uc_reg_mie: 	std_logic_vector(1 downto 0) is ucode(23 downto 22);
constant reg_mie_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_mie_enable: 	std_logic_vector(1 downto 0) := "01";
constant reg_mie_disable: 	std_logic_vector(1 downto 0) := "10";

--
-- L0054.reg_trace: 2 values same,ss_enable_zero,ss_disable_zero,ss_disable_chardefault same
--
alias uc_reg_trace: 	std_logic_vector(1 downto 0) is ucode(21 downto 20);
constant reg_trace_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_trace_ss_enable_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_trace_ss_disable_zero: 	std_logic_vector(1 downto 0) := "10";
constant reg_trace_ss_disable_char: 	std_logic_vector(1 downto 0) := "11";

--
-- L0060.reg_extend: 2 values same, zero, one default same
--
alias uc_reg_extend: 	std_logic_vector(1 downto 0) is ucode(19 downto 18);
constant reg_extend_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_extend_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_extend_one: 	std_logic_vector(1 downto 0) := "10";

--
-- L0065.sel_reg: 3 values zero, one, two, x, n, p default zero
--
alias uc_sel_reg: 	std_logic_vector(2 downto 0) is ucode(17 downto 15);
constant sel_reg_zero: 	std_logic_vector(2 downto 0) := "000";
constant sel_reg_one: 	std_logic_vector(2 downto 0) := "001";
constant sel_reg_two: 	std_logic_vector(2 downto 0) := "010";
constant sel_reg_x: 	std_logic_vector(2 downto 0) := "011";
constant sel_reg_n: 	std_logic_vector(2 downto 0) := "100";
constant sel_reg_p: 	std_logic_vector(2 downto 0) := "101";

--
-- L0071.reg_r: 3 values same, zero, r_plus_one, r_minus_one, yhi_rlo, rhi_ylo, b_t, -  default same
--
alias uc_reg_r: 	std_logic_vector(2 downto 0) is ucode(14 downto 12);
constant reg_r_same: 	std_logic_vector(2 downto 0) := "000";
constant reg_r_zero: 	std_logic_vector(2 downto 0) := "001";
constant reg_r_r_plus_one: 	std_logic_vector(2 downto 0) := "010";
constant reg_r_r_minus_one: 	std_logic_vector(2 downto 0) := "011";
constant reg_r_yhi_rlo: 	std_logic_vector(2 downto 0) := "100";
constant reg_r_rhi_ylo: 	std_logic_vector(2 downto 0) := "101";
constant reg_r_b_t: 	std_logic_vector(2 downto 0) := "110";
-- Value "111" not allowed (name '-' is not assignable)

--
-- L0075.alu_r: 2 values t, d, b, reg_hi default t
--
alias uc_alu_r: 	std_logic_vector(1 downto 0) is ucode(11 downto 10);
constant alu_r_t: 	std_logic_vector(1 downto 0) := "00";
constant alu_r_d: 	std_logic_vector(1 downto 0) := "01";
constant alu_r_b: 	std_logic_vector(1 downto 0) := "10";
constant alu_r_reg_hi: 	std_logic_vector(1 downto 0) := "11";

--
-- L0076.alu_s: 2 values bus,  d, const, reg_lo default bus
--
alias uc_alu_s: 	std_logic_vector(1 downto 0) is ucode(9 downto 8);
constant alu_s_bus: 	std_logic_vector(1 downto 0) := "00";
constant alu_s_d: 	std_logic_vector(1 downto 0) := "01";
constant alu_s_const: 	std_logic_vector(1 downto 0) := "10";
constant alu_s_reg_lo: 	std_logic_vector(1 downto 0) := "11";

--
-- L0086.alu_f: 3 values xor, and, ior, pass_r, r_plus_s, r_plus_ns, nr_plus_s, pass_s default xor
--
alias uc_alu_f: 	std_logic_vector(2 downto 0) is ucode(7 downto 5);
constant alu_f_xor: 	std_logic_vector(2 downto 0) := "000";
constant alu_f_and: 	std_logic_vector(2 downto 0) := "001";
constant alu_f_ior: 	std_logic_vector(2 downto 0) := "010";
constant alu_f_pass_r: 	std_logic_vector(2 downto 0) := "011";
constant alu_f_r_plus_s: 	std_logic_vector(2 downto 0) := "100";
constant alu_f_r_plus_ns: 	std_logic_vector(2 downto 0) := "101";
constant alu_f_nr_plus_s: 	std_logic_vector(2 downto 0) := "110";
constant alu_f_pass_s: 	std_logic_vector(2 downto 0) := "111";

--
-- L0087.alu_cin: 1 values f1_or_f0, df default f1_or_f0
--
alias uc_alu_cin: 	std_logic is ucode(4);
constant alu_cin_f1_or_f0: 	std_logic := '0';
constant alu_cin_df: 	std_logic := '1';

--
-- L0090.sc: 2 valuessc_fetch,sc_execute,sc_dma,sc_interrupt default sc_execute
--
alias uc_sc: 	std_logic_vector(1 downto 0) is ucode(3 downto 2);
constant sc_sc_fetch: 	std_logic_vector(1 downto 0) := "00";
constant sc_sc_execute: 	std_logic_vector(1 downto 0) := "01";
constant sc_sc_dma: 	std_logic_vector(1 downto 0) := "10";
constant sc_sc_interrupt: 	std_logic_vector(1 downto 0) := "11";

--
-- L0096.ct_oper: 2 values disable, enable default disable
--
alias uc_ct_oper: 	std_logic_vector(1 downto 0) is ucode(1 downto 0);
constant ct_oper_disable: 	std_logic_vector(1 downto 0) := "00";
constant ct_oper_enable: 	std_logic_vector(1 downto 0) := "01";



constant microcode: code_memory := (

-- L0143@0000._reset: reg_trace <= ss_enable_zero
0 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "01" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0145@0001._reset1: reg_trace <= ss_enable_zero
1 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "01" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0147@0002._reset2: reg_q <= zero,alu_f = xor, alu_r = d, alu_s = d, reg_in <= alu_y
2 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '1' & "01" & "00" & "00" & "00" & O"0" & O"0" & "01" & "01" & O"0" & '0' & "01" & "00",

-- L0151@0003._reset3: reg_r <= zero, sel_reg = zero,reg_mie <= enable,reg_t <= xp,alu_f = xor, alu_r = d, alu_s = d, reg_x <= n, reg_p <= n,reg_extend <= zero
3 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "10" & "00" & "01" & "01" & '0' & "00" & "01" & "00" & "01" & O"0" & O"1" & "01" & "01" & O"0" & '0' & "01" & "00",

-- L0159@0004.fetch: sc = sc_fetch, direction = mem2any, sel_reg = p, reg_in <= alu_y, alu_f = pass_s, alu_s = bus, reg_sample <= sample, reg_r <= r_plus_one
4 => O"4" & '1' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '1' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "00" & "00",

-- L0163@0005.load_b: direction = mem2any, sel_reg = x, reg_b <= alu_y, alu_f = pass_s, alu_s = bus,if traceEnabled then traceState else fork
5 => O"4" & '0' & X"D" & X"20" & X"03" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"0" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0170@0010.dma_or_int: reg_sample <= sample, if continue_sw then fetch else dma_or_int
16 => O"0" & '1' & X"7" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0173@0011.fetch1: sc = sc_fetch, direction = mem2any, sel_reg = p, reg_in <= alu_y, alu_f = pass_s, alu_s = bus, reg_sample <= sample, reg_r <= r_plus_one,if false then next else load_b
17 => O"4" & '1' & X"F" & X"00" & X"05" & O"0" & "00" & "00" & "00" & "00" & "00" & '1' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "00" & "00",

-- L0177@0013.int_ack: sc = sc_interrupt,alu_f = pass_s, alu_s = const, reg_t <= xp, reg_x <= alu_yhi, reg_p <= alu_ylo,reg_mie <= disable,if true then fetch else 0x21
19 => O"0" & '0' & X"0" & X"04" & X"21" & O"0" & "00" & "10" & "00" & "10" & "10" & '0' & "00" & "10" & "00" & "00" & O"0" & O"0" & "00" & "10" & O"7" & '0' & "11" & "00",

-- L0183@0015.dma_out: sc = sc_dma, direction = mem2any, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
21 => O"4" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & "10" & "00",

-- L0187@0017. sc = sc_dma, direction = mem2any, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
23 => O"4" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & "10" & "00",

-- L0191@0019.dma_in: sc = sc_dma, direction = dev2any, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
25 => O"2" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & "10" & "00",

-- L0195@001B. sc = sc_dma, direction = dev2any, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
27 => O"2" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & "10" & "00",

-- L0199@001D. sc = sc_dma, direction = dev2any, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
29 => O"2" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & "10" & "00",

-- L0203@001F. sc = sc_dma, direction = dev2any, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
31 => O"2" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & "10" & "00",

-- L0213@0020.traceState: alu_f = pass_r, alu_r = d, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else 'D'
32 => O"0" & '0' & X"0" & X"6B" & X"44" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "01" & "00" & O"3" & '0' & "01" & "00",

-- L0214@0021. if false then next else traceET
33 => O"0" & '0' & X"F" & X"00" & X"66" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0216@0022. alu_f = pass_r, alu_r = b, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else 'B'
34 => O"0" & '0' & X"0" & X"6B" & X"42" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0217@0023. if false then next else traceET
35 => O"0" & '0' & X"F" & X"00" & X"66" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0219@0024. reg_trace <= ss_disable_char, if true then traceChar else 'D'
36 => O"0" & '0' & X"0" & X"6B" & X"44" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0220@0025. reg_trace <= ss_disable_char, if true then traceChar else 'F'
37 => O"0" & '0' & X"0" & X"6B" & X"46" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0221@0026. reg_trace <= ss_disable_char, if true then traceChar else '='
38 => O"0" & '0' & X"0" & X"6B" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0222@0027. if cond_df then trace1 else next
39 => O"0" & '0' & X"8" & X"2B" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0223@0028. reg_trace <= ss_disable_char, if true then traceChar else '0'
40 => O"0" & '0' & X"0" & X"6B" & X"30" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0224@0029. reg_trace <= ss_disable_char, if true then traceChar else ' '
41 => O"0" & '0' & X"0" & X"6B" & X"20" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0225@002A. if false then next else traceX
42 => O"0" & '0' & X"F" & X"00" & X"2D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0226@002B.trace1: reg_trace <= ss_disable_char, if true then traceChar else '1'
43 => O"0" & '0' & X"0" & X"6B" & X"31" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0227@002C. reg_trace <= ss_disable_char, if true then traceChar else ' '
44 => O"0" & '0' & X"0" & X"6B" & X"20" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0229@002D.traceX: reg_t <= xp, reg_trace <= ss_disable_char, if true then traceChar else 'X'
45 => O"0" & '0' & X"0" & X"6B" & X"58" & O"0" & "00" & "10" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0230@002E. reg_trace <= ss_disable_char, if true then traceChar else 'P'
46 => O"0" & '0' & X"0" & X"6B" & X"50" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0231@002F. if false then next else traceET
47 => O"0" & '0' & X"F" & X"00" & X"66" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0233@0030. reg_t <= in, reg_trace <= ss_disable_char, if true then traceChar else 'I'
48 => O"0" & '0' & X"0" & X"6B" & X"49" & O"0" & "00" & "11" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0234@0031. reg_trace <= ss_disable_char, if true then traceChar else 'N'
49 => O"0" & '0' & X"0" & X"6B" & X"4E" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0235@0032. if false then next else traceET
50 => O"0" & '0' & X"F" & X"00" & X"66" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0237@0033. reg_trace <= ss_disable_char, if true then traceChar else 'R'
51 => O"0" & '0' & X"0" & X"6B" & X"52" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0238@0034. reg_trace <= ss_disable_char, if true then traceChar else '0'
52 => O"0" & '0' & X"0" & X"6B" & X"30" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0239@0035. if false then next else traceReg0
53 => O"0" & '0' & X"F" & X"00" & X"48" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0241@0036. reg_trace <= ss_disable_char, if true then traceChar else 'R'
54 => O"0" & '0' & X"0" & X"6B" & X"52" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0242@0037. reg_trace <= ss_disable_char, if true then traceChar else '1'
55 => O"0" & '0' & X"0" & X"6B" & X"31" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0243@0038. if false then next else traceReg1
56 => O"0" & '0' & X"F" & X"00" & X"4D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0245@0039. reg_trace <= ss_disable_char, if true then traceChar else 'R'
57 => O"0" & '0' & X"0" & X"6B" & X"52" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0246@003A. reg_trace <= ss_disable_char, if true then traceChar else '2'
58 => O"0" & '0' & X"0" & X"6B" & X"32" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0247@003B. if false then next else traceReg2
59 => O"0" & '0' & X"F" & X"00" & X"52" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0249@003C. reg_trace <= ss_disable_char, if true then traceChar else 'R'
60 => O"0" & '0' & X"0" & X"6B" & X"52" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0250@003D. reg_trace <= ss_disable_char, if true then traceChar else 'X'
61 => O"0" & '0' & X"0" & X"6B" & X"58" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0251@003E. if false then next else traceRegX
62 => O"0" & '0' & X"F" & X"00" & X"57" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0253@003F. reg_trace <= ss_disable_char, if true then traceChar else 'R'
63 => O"0" & '0' & X"0" & X"6B" & X"52" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0254@0040. reg_trace <= ss_disable_char, if true then traceChar else 'P'
64 => O"0" & '0' & X"0" & X"6B" & X"50" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0255@0041. if false then next else traceRegP
65 => O"0" & '0' & X"F" & X"00" & X"5C" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0257@0042. reg_trace <= ss_disable_char, if true then traceChar else 'R'
66 => O"0" & '0' & X"0" & X"6B" & X"52" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0258@0043. reg_trace <= ss_disable_char, if true then traceChar else 'N'
67 => O"0" & '0' & X"0" & X"6B" & X"4E" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0259@0044. if false then next else traceRegN
68 => O"0" & '0' & X"F" & X"00" & X"61" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0261@0045. reg_trace <= ss_disable_char, if true then traceChar else 0x0D
69 => O"0" & '0' & X"0" & X"6B" & X"0D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0262@0046. reg_trace <= ss_disable_char, if true then traceChar else 0x0A
70 => O"0" & '0' & X"0" & X"6B" & X"0A" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0264@0047. reg_trace <= ss_enable_zero,if TPB then fork else repeat
71 => O"0" & '0' & X"2" & X"03" & X"01" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "01" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0267@0048.traceReg0: alu_f = pass_r, alu_r = reg_hi, sel_reg = zero, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
72 => O"0" & '0' & X"0" & X"6B" & X"3D" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0268@0049. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
73 => O"0" & '0' & X"0" & X"6B" & X"81" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0269@004A. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
74 => O"0" & '0' & X"0" & X"6B" & X"80" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0270@004B. alu_f = pass_s, alu_s = reg_lo, sel_reg = zero, reg_t <= alu_y, if false then next else traceT
75 => O"0" & '0' & X"F" & X"00" & X"67" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0271@004C. if false then next else return
76 => O"0" & '0' & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0273@004D.traceReg1: alu_f = pass_r, alu_r = reg_hi, sel_reg = one, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
77 => O"0" & '0' & X"0" & X"6B" & X"3D" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"1" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0274@004E. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
78 => O"0" & '0' & X"0" & X"6B" & X"81" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0275@004F. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
79 => O"0" & '0' & X"0" & X"6B" & X"80" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0276@0050. alu_f = pass_s, alu_s = reg_lo, sel_reg = one, reg_t <= alu_y, if false then next else traceT
80 => O"0" & '0' & X"F" & X"00" & X"67" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"1" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0277@0051. if false then next else return
81 => O"0" & '0' & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0279@0052.traceReg2: alu_f = pass_r, alu_r = reg_hi, sel_reg = two, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
82 => O"0" & '0' & X"0" & X"6B" & X"3D" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"2" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0280@0053. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
83 => O"0" & '0' & X"0" & X"6B" & X"81" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0281@0054. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
84 => O"0" & '0' & X"0" & X"6B" & X"80" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0282@0055. alu_f = pass_s, alu_s = reg_lo, sel_reg = two, reg_t <= alu_y, if false then next else traceT
85 => O"0" & '0' & X"F" & X"00" & X"67" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"2" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0283@0056. if false then next else return
86 => O"0" & '0' & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0285@0057.traceRegX: alu_f = pass_r, alu_r = reg_hi, sel_reg = x, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
87 => O"0" & '0' & X"0" & X"6B" & X"3D" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"3" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0286@0058. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
88 => O"0" & '0' & X"0" & X"6B" & X"81" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0287@0059. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
89 => O"0" & '0' & X"0" & X"6B" & X"80" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0288@005A. alu_f = pass_s, alu_s = reg_lo, sel_reg = x, reg_t <= alu_y, if false then next else traceT
90 => O"0" & '0' & X"F" & X"00" & X"67" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0289@005B. if false then next else return
91 => O"0" & '0' & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0291@005C.traceRegP: alu_f = pass_r, alu_r = reg_hi, sel_reg = p, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
92 => O"0" & '0' & X"0" & X"6B" & X"3D" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"5" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0292@005D. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
93 => O"0" & '0' & X"0" & X"6B" & X"81" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0293@005E. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
94 => O"0" & '0' & X"0" & X"6B" & X"80" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0294@005F. alu_f = pass_s, alu_s = reg_lo, sel_reg = p, reg_t <= alu_y, if false then next else traceT
95 => O"0" & '0' & X"F" & X"00" & X"67" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0295@0060. if false then next else return
96 => O"0" & '0' & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0297@0061.traceRegN: alu_f = pass_r, alu_r = reg_hi, sel_reg = n, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
97 => O"0" & '0' & X"0" & X"6B" & X"3D" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"4" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0298@0062. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
98 => O"0" & '0' & X"0" & X"6B" & X"81" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0299@0063. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
99 => O"0" & '0' & X"0" & X"6B" & X"80" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0300@0064. alu_f = pass_s, alu_s = reg_lo, sel_reg = n, reg_t <= alu_y, if false then next else traceT
100 => O"0" & '0' & X"F" & X"00" & X"67" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0301@0065. if false then next else return
101 => O"0" & '0' & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0303@0066.traceET: reg_trace <= ss_disable_char, if true then traceChar else '='
102 => O"0" & '0' & X"0" & X"6B" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0304@0067.traceT: reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
103 => O"0" & '0' & X"0" & X"6B" & X"81" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0305@0068. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
104 => O"0" & '0' & X"0" & X"6B" & X"80" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0306@0069. reg_trace <= ss_disable_char, if true then traceChar else ' '
105 => O"0" & '0' & X"0" & X"6B" & X"20" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0307@006A. if false then next else return
106 => O"0" & '0' & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0309@006B.traceChar: if traceReady then next else repeat
107 => O"0" & '0' & X"E" & X"00" & X"01" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0310@006C. reg_trace <= ss_disable_zero, if false then next else return
108 => O"0" & '0' & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "10" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0313@006D.XNOP: if false then next else NOP
109 => O"0" & '0' & X"F" & X"00" & X"98" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0319@006E.LDN: direction = mem2any, sel_reg = n, alu_f = pass_s, alu_s = bus, reg_d <= alu_y,if continue then fetch else dma_or_int
110 => O"4" & '0' & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0323@006F.IDL: reg_sample <= sample
111 => O"0" & '1' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0325@0070. if continue then IDL else dma_or_int
112 => O"0" & '0' & X"6" & X"6F" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0328@0071.INC: sel_reg = n, reg_r <= r_plus_one,if continue then fetch else dma_or_int
113 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"2" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0332@0072.DEC: sel_reg = n, reg_r <= r_minus_one,if continue then fetch else dma_or_int
114 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"3" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0336@0073.SBRANCH: direction = mem2any, sel_reg = p, alu_f = pass_s, alu_s = bus, reg_b <= alu_y,if cond_3X then sbranch2 else next
115 => O"4" & '0' & X"3" & X"75" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"0" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0339@0074.skip1: sel_reg = p, reg_r <= r_plus_one,if continue then fetch else dma_or_int
116 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0342@0075.sbranch2: sel_reg = p, reg_r <= rhi_ylo, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
117 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"5" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0346@0076.LDA: direction = mem2any, sel_reg = n, alu_f = pass_s, alu_s = bus, reg_d <= alu_y,if false then next else INC
118 => O"4" & '0' & X"F" & X"00" & X"71" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0350@0077.STR: direction = cpu2mem, sel_reg = n, alu_f = pass_r, alu_r = d,if continue then fetch else dma_or_int
119 => O"3" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "01" & "00" & O"3" & '0' & "01" & "00",

-- L0354@0078.OUT: sel_reg = x, reg_r <= r_plus_one, direction = mem2any,if continue then fetch else dma_or_int
120 => O"4" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0358@0079.IRX: sel_reg = x, reg_r <= r_plus_one,if continue then fetch else dma_or_int
121 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0362@007A.INP: sel_reg = x, alu_f = pass_s, alu_s = bus, reg_d <= alu_y, direction = dev2any,if continue then fetch else dma_or_int
122 => O"2" & '0' & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"0" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0366@007B.EXTEND: if mode_1805 then next else NOP
123 => O"0" & '0' & X"1" & X"00" & X"98" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0368@007C. sc = sc_fetch, direction = mem2any, sel_reg = p, reg_in <= alu_y, alu_f = pass_s, alu_s = bus, reg_sample <= sample, reg_extend <= one,reg_r <= r_plus_one,if false then next else load_b
124 => O"4" & '1' & X"F" & X"00" & X"05" & O"0" & "00" & "00" & "00" & "00" & "00" & '1' & "00" & "00" & "00" & "10" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "00" & "00",

-- L0373@007D.RET: alu_f = pass_r, alu_r = b, reg_x <= alu_yhi, reg_p <= alu_ylo, reg_mie <= enable,sel_reg = x, reg_r <= r_plus_one,if continue then fetch else dma_or_int
125 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "10" & "10" & '0' & "00" & "01" & "00" & "00" & O"3" & O"2" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0378@007E.DIS: alu_f = pass_r, alu_r = b, reg_x <= alu_yhi, reg_p <= alu_ylo, reg_mie <= disable,sel_reg = x, reg_r <= r_plus_one,if continue then fetch else dma_or_int
126 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "10" & "10" & '0' & "00" & "10" & "00" & "00" & O"3" & O"2" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0383@007F.LDXA: alu_f = pass_r, alu_r = b, reg_d <= alu_y
127 => O"0" & '0' & X"0" & X"00" & X"00" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0385@0080. sel_reg = x, reg_r <= r_plus_one,if continue then fetch else dma_or_int
128 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0389@0081.STXD: alu_f = pass_r, alu_r = d, direction = cpu2mem
129 => O"3" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "01" & "00" & O"3" & '0' & "01" & "00",

-- L0391@0082. sel_reg = x, reg_r <= r_minus_one,if continue then fetch else dma_or_int
130 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0396@0083.ADC: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = b, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
131 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"4" & '1' & "01" & "00",

-- L0400@0084.SDB: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_ns, alu_r = b, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
132 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"5" & '1' & "01" & "00",

-- L0404@0085.SHRC: reg_d <= shift_dn_df, reg_df <= d_lsb,if continue then fetch else dma_or_int
133 => O"0" & '0' & X"6" & X"04" & X"10" & O"2" & "10" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0409@0086.SMB: reg_df <= alu_cout, reg_d <= alu_y, alu_f = nr_plus_s, alu_r = b, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
134 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"6" & '1' & "01" & "00",

-- L0413@0087.SAV: reg_b <= alu_y, alu_f = pass_r, alu_r = t
135 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"3" & '0' & "01" & "00",

-- L0415@0088. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
136 => O"3" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"0" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0419@0089.MARK: reg_t <= xp
137 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "10" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0421@008A. reg_x <= p, direction = cpu2mem, sel_reg = two, alu_f = pass_r, alu_r = t, reg_r <= r_minus_one,if continue then fetch else dma_or_int
138 => O"3" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "11" & "00" & '0' & "00" & "00" & "00" & "00" & O"2" & O"3" & "00" & "00" & O"3" & '0' & "01" & "00",

-- L0425@008B.REQ: reg_q <= zero,if continue then fetch else dma_or_int
139 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "01" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0429@008C.SEQ: reg_q <= one,if continue then fetch else dma_or_int
140 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "10" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0434@008D.ADCI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else ADC
141 => O"4" & '0' & X"F" & X"00" & X"83" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0438@008E.SDBI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else SDB
142 => O"4" & '0' & X"F" & X"00" & X"84" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0442@008F.SHLC: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = d, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
143 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "01" & "01" & O"4" & '1' & "01" & "00",

-- L0447@0090.SMBI: sc = sc_execute, direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else SMB
144 => O"4" & '0' & X"F" & X"00" & X"86" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0451@0091.GLO: reg_d <= alu_y, alu_f = pass_s, alu_s = reg_lo, sel_reg = n,if continue then fetch else dma_or_int
145 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0455@0092.GHI: reg_d <= alu_y, alu_f = pass_r, alu_r = reg_hi, sel_reg = n,if continue then fetch else dma_or_int
146 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0459@0093.PLO: reg_r <= rhi_ylo, alu_f = pass_r, alu_r = d, sel_reg = n,if continue then fetch else dma_or_int
147 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"5" & "01" & "00" & O"3" & '0' & "01" & "00",

-- L0463@0094.PHI: reg_r <= yhi_rlo, alu_f = pass_r, alu_r = d, sel_reg = n,if continue then fetch else dma_or_int
148 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"4" & "01" & "00" & O"3" & '0' & "01" & "00",

-- L0467@0095.LBRANCH: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if cond_CX then next else skip1
149 => O"4" & '0' & X"C" & X"00" & X"74" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0470@0096. direction = mem2any, sel_reg = p, reg_r <= rhi_ylo, alu_f = pass_s, alu_s = bus
150 => O"4" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"5" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0472@0097. sel_reg = p, reg_r <= yhi_rlo, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
151 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"4" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0476@0098.NOP: if continue then fetch else dma_or_int
152 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0479@0099.SEP: reg_p <= n,if continue then fetch else dma_or_int
153 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "01" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0483@009A.SEX: reg_x <= n,if continue then fetch else dma_or_int
154 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "01" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0487@009B.LDX: reg_d <= alu_y, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
155 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0491@009C.OR: reg_d <= alu_y, alu_f = ior, alu_r = b, alu_s = d,if continue then fetch else dma_or_int
156 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"2" & '0' & "01" & "00",

-- L0495@009D.AND: reg_d <= alu_y, alu_f = and, alu_r = b, alu_s = d,if continue then fetch else dma_or_int
157 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"1" & '0' & "01" & "00",

-- L0499@009E.XOR: reg_d <= alu_y, alu_f = xor, alu_r = b, alu_s = d,if continue then fetch else dma_or_int
158 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"0" & '0' & "01" & "00",

-- L0504@009F.ADD: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = b, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
159 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"4" & '0' & "01" & "00",

-- L0508@00A0.SD: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_ns, alu_r = b, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
160 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"5" & '0' & "01" & "00",

-- L0512@00A1.SHR: reg_d <= shift_dn_0, reg_df <= d_lsb,if continue then fetch else dma_or_int
161 => O"0" & '0' & X"6" & X"04" & X"10" & O"3" & "10" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0517@00A2.SM: reg_df <= alu_cout, reg_d <= alu_y, alu_f = nr_plus_s, alu_r = b, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
162 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"6" & '0' & "01" & "00",

-- L0521@00A3.LDI: direction = mem2any, sel_reg = p, reg_d <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if continue then fetch else dma_or_int
163 => O"4" & '0' & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0525@00A4.ORI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else OR
164 => O"4" & '0' & X"F" & X"00" & X"9C" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0529@00A5.ANI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else AND
165 => O"4" & '0' & X"F" & X"00" & X"9D" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0533@00A6.XRI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else XOR
166 => O"4" & '0' & X"F" & X"00" & X"9E" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0538@00A7.ADI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else ADD
167 => O"4" & '0' & X"F" & X"00" & X"9F" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0542@00A8.SDI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else SD
168 => O"4" & '0' & X"F" & X"00" & X"A0" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0546@00A9.SHL: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = d, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
169 => O"0" & '0' & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "01" & "01" & O"4" & '0' & "01" & "00",

-- L0551@00AA.SMI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else SM
170 => O"4" & '0' & X"F" & X"00" & X"A2" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0558@00AB.STPC: sel_reg = n,if continue then fetch else dma_or_int
171 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0562@00AC.DTC: sel_reg = n,if continue then fetch else dma_or_int
172 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0566@00AD.SPM2: sel_reg = n,if continue then fetch else dma_or_int
173 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0570@00AE.SCM2: sel_reg = n,if continue then fetch else dma_or_int
174 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0574@00AF.SPM1: sel_reg = n,if continue then fetch else dma_or_int
175 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0578@00B0.SCM1: sel_reg = n,if continue then fetch else dma_or_int
176 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0582@00B1.LDC: sel_reg = n,if continue then fetch else dma_or_int
177 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0586@00B2.STM: sel_reg = n,if continue then fetch else dma_or_int
178 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0590@00B3.GEC: sel_reg = n,if continue then fetch else dma_or_int
179 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0594@00B4.ETQ: sel_reg = n,if continue then fetch else dma_or_int
180 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0598@00B5.XIE: sel_reg = n,if continue then fetch else dma_or_int
181 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0602@00B6.XID: sel_reg = n,if continue then fetch else dma_or_int
182 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0606@00B7.CIE: sel_reg = n,if continue then fetch else dma_or_int
183 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0610@00B8.CID: sel_reg = n,if continue then fetch else dma_or_int
184 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0614@00B9.DBNZ: sel_reg = n, reg_r <= r_minus_one,if alu16_zero then skip2 else next
185 => O"0" & '0' & X"B" & X"BD" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"3" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0617@00BA. direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
186 => O"4" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0619@00BB. direction = mem2any, sel_reg = p, reg_r <= rhi_ylo, alu_f = pass_s, alu_s = bus
187 => O"4" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"5" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0621@00BC. sel_reg = p, reg_r <= yhi_rlo, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
188 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"4" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0624@00BD.skip2: sel_reg = p, reg_r <= r_plus_one,if false then next else skip1
189 => O"0" & '0' & X"F" & X"00" & X"74" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0628@00BE.BCI: direction = mem2any, sel_reg = p, alu_f = pass_s, alu_s = bus, reg_b <= alu_y,if counterInt then sbranch2 else skip1
190 => O"4" & '0' & X"A" & X"75" & X"74" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"0" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0632@00BF.BXI: direction = mem2any, sel_reg = p, alu_f = pass_s, alu_s = bus, reg_b <= alu_y,if externalInt then sbranch2 else skip1
191 => O"4" & '0' & X"9" & X"75" & X"74" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"0" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0636@00C0.RLXA: direction = mem2any, sel_reg = x, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
192 => O"4" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0638@00C1. direction = mem2any, sel_reg = x, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
193 => O"4" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0640@00C2. sel_reg = n, reg_r <= yhi_rlo, alu_f = pass_r, alu_r = b, reg_b <= t
194 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "10" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"4" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0642@00C3. sel_reg = n, reg_r <= rhi_ylo, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
195 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"5" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0646@00C4.DSAV: sel_reg = x, reg_r <= r_minus_one
196 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0648@00C5. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = t, reg_r <= r_minus_one
197 => O"3" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "00" & "00" & O"3" & '0' & "01" & "00",

-- L0650@00C6. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = d, reg_r <= r_minus_one, reg_b <= df_d_dn
198 => O"3" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "11" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "01" & "00" & O"3" & '0' & "01" & "00",

-- L0652@00C7. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = b, reg_r <= r_minus_one,if continue then fetch else dma_or_int
199 => O"3" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0656@00C8.SCAL: sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
200 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0658@00C9. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
201 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0660@00CA. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = t, reg_r <= r_minus_one
202 => O"3" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "00" & "00" & O"3" & '0' & "01" & "00",

-- L0662@00CB. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = b, reg_r <= r_minus_one
203 => O"3" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0664@00CC. sel_reg = p, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
204 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0666@00CD. sel_reg = p, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
205 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0668@00CE. sel_reg = n, reg_r <= b_t
206 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"6" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0670@00CF. direction = mem2any, sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
207 => O"4" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0672@00D0. direction = mem2any, sel_reg = n, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
208 => O"4" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0674@00D1. sel_reg = p, reg_r <= b_t,if continue then fetch else dma_or_int
209 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"6" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0678@00D2.SRET: sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
210 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0680@00D3. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
211 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0682@00D4. sel_reg = x, reg_r <= r_plus_one
212 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0684@00D5. sel_reg = p, reg_r <= b_t
213 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"6" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0686@00D6. direction = mem2any, sel_reg = x, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
214 => O"4" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0688@00D7. direction = mem2any, sel_reg = x, reg_b <= alu_y, alu_f = pass_s, alu_s = bus,if false then next else load_n
215 => O"4" & '0' & X"F" & X"00" & X"E1" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"0" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0692@00D8.RSXD: sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
216 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0694@00D9. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
217 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0696@00DA. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = t, reg_r <= r_minus_one
218 => O"3" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "00" & "00" & O"3" & '0' & "01" & "00",

-- L0698@00DB. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = b, reg_r <= r_minus_one,if continue then fetch else dma_or_int
219 => O"3" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "10" & "00" & O"3" & '0' & "01" & "00",

-- L0702@00DC.RNX: sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
220 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "11" & O"7" & '0' & "01" & "00",

-- L0704@00DD. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
221 => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "11" & "00" & O"3" & '0' & "01" & "00",

-- L0706@00DE. sel_reg = x, reg_r <= b_t,if continue then fetch else dma_or_int
222 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"6" & "00" & "00" & O"0" & '0' & "01" & "00",

-- L0710@00DF.RLDI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
223 => O"4" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0712@00E0. direction = mem2any, sel_reg = p, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
224 => O"4" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & "01" & "00",

-- L0714@00E1.load_n: sel_reg = n, reg_r <= b_t,if continue then fetch else dma_or_int
225 => O"0" & '0' & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"6" & "00" & "00" & O"0" & '0' & "01" & "00",

-- 47 location(s) in following ranges will be filled with default value
-- 0006 .. 000F
-- 0012 .. 0012
-- 0014 .. 0014
-- 0016 .. 0016
-- 0018 .. 0018
-- 001A .. 001A
-- 001C .. 001C
-- 001E .. 001E
-- 00E2 .. 00FF

others => O"0" & '0' & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & "01" & "00"
);

end cdp180x_code;

