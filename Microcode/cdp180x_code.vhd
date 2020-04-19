--------------------------------------------------------
-- mcc V0.9.0325 - Custom microcode compiler (c)2020-... 
--    https://github.com/zpekic/MicroCodeCompiler
--------------------------------------------------------
-- Auto-generated file, do not modify. To customize, create 'code_template.vhd' file in mcc.exe folder
-- Supported placeholders:  [NAME], [TYPE], [FIELDS], [SIGNAL], [MEMORY].
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

package cdp180x_code is

type code_memory is array(0 to 255) of std_logic_vector(63 downto 0);

signal ucode: std_logic_vector(63 downto 0);

--
-- L0008.direction: 3 valuesnop,,dev2any,cpu2mem,mem2any,,,default nop
--
alias uc_direction: 	std_logic_vector(2 downto 0) is ucode(63 downto 61);
constant direction_nop: 	std_logic_vector(2 downto 0) := "000";
-- Values from "001" to "001" allowed
constant direction_dev2any: 	std_logic_vector(2 downto 0) := "010";
constant direction_cpu2mem: 	std_logic_vector(2 downto 0) := "011";
constant direction_mem2any: 	std_logic_vector(2 downto 0) := "100";
-- Values from "101" to "101" allowed
-- Values from "110" to "110" allowed
-- Values from "111" to "111" allowed

--
-- L0018.reg_sample: 1 values same, sample default same
--
alias uc_reg_sample: 	std_logic is ucode(60);
constant reg_sample_same: 	std_logic := '0';
constant reg_sample_sample: 	std_logic := '1';

--
-- L0020.seq_cond: 4 valuestrue,mode_1805,cond_2,cond_3X,cond_4,cond_5,continue,continue_sw,cond_8,externalInt,counterInt,alu16_zero,cond_CX,traceEnabled,traceReady,falsedefault true
--
alias uc_seq_cond: 	std_logic_vector(3 downto 0) is ucode(59 downto 56);
constant seq_cond_true: 	std_logic_vector(3 downto 0) := X"0";
constant seq_cond_mode_1805: 	std_logic_vector(3 downto 0) := X"1";
constant seq_cond_cond_2: 	std_logic_vector(3 downto 0) := X"2";
constant seq_cond_cond_3X: 	std_logic_vector(3 downto 0) := X"3";
constant seq_cond_cond_4: 	std_logic_vector(3 downto 0) := X"4";
constant seq_cond_cond_5: 	std_logic_vector(3 downto 0) := X"5";
constant seq_cond_continue: 	std_logic_vector(3 downto 0) := X"6";
constant seq_cond_continue_sw: 	std_logic_vector(3 downto 0) := X"7";
constant seq_cond_cond_8: 	std_logic_vector(3 downto 0) := X"8";
constant seq_cond_externalInt: 	std_logic_vector(3 downto 0) := X"9";
constant seq_cond_counterInt: 	std_logic_vector(3 downto 0) := X"A";
constant seq_cond_alu16_zero: 	std_logic_vector(3 downto 0) := X"B";
constant seq_cond_cond_CX: 	std_logic_vector(3 downto 0) := X"C";
constant seq_cond_traceEnabled: 	std_logic_vector(3 downto 0) := X"D";
constant seq_cond_traceReady: 	std_logic_vector(3 downto 0) := X"E";
constant seq_cond_false: 	std_logic_vector(3 downto 0) := X"F";

--
-- L0038.seq_then: 8 values next, repeat, return, fork, @ default next
--
alias uc_seq_then: 	std_logic_vector(7 downto 0) is ucode(55 downto 48);
constant seq_then_next: 	std_logic_vector(7 downto 0) := X"00";
constant seq_then_repeat: 	std_logic_vector(7 downto 0) := X"01";
constant seq_then_return: 	std_logic_vector(7 downto 0) := X"02";
constant seq_then_fork: 	std_logic_vector(7 downto 0) := X"03";
-- Jump targets allowed!

--
-- L0039.seq_else: 8 values next, repeat, return, fork, 0x00..0xFF, @ default next
--
alias uc_seq_else: 	std_logic_vector(7 downto 0) is ucode(47 downto 40);
constant seq_else_next: 	std_logic_vector(7 downto 0) := X"00";
constant seq_else_repeat: 	std_logic_vector(7 downto 0) := X"01";
constant seq_else_return: 	std_logic_vector(7 downto 0) := X"02";
constant seq_else_fork: 	std_logic_vector(7 downto 0) := X"03";
-- Values from X"00" to X"FF" allowed
-- Jump targets allowed!

--
-- L0042.reg_d: 3 values same, alu_y, shift_dn_df, shift_dn_0 default same
--
alias uc_reg_d: 	std_logic_vector(2 downto 0) is ucode(39 downto 37);
constant reg_d_same: 	std_logic_vector(2 downto 0) := "000";
constant reg_d_alu_y: 	std_logic_vector(2 downto 0) := "001";
constant reg_d_shift_dn_df: 	std_logic_vector(2 downto 0) := "010";
constant reg_d_shift_dn_0: 	std_logic_vector(2 downto 0) := "011";

--
-- L0043.reg_df: 2 values same, d_msb, d_lsb, alu_cout default same
--
alias uc_reg_df: 	std_logic_vector(1 downto 0) is ucode(36 downto 35);
constant reg_df_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_df_d_msb: 	std_logic_vector(1 downto 0) := "01";
constant reg_df_d_lsb: 	std_logic_vector(1 downto 0) := "10";
constant reg_df_alu_cout: 	std_logic_vector(1 downto 0) := "11";

--
-- L0044.reg_t: 2 values same, alu_y, xp, flags default same
--
alias uc_reg_t: 	std_logic_vector(1 downto 0) is ucode(34 downto 33);
constant reg_t_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_t_alu_y: 	std_logic_vector(1 downto 0) := "01";
constant reg_t_xp: 	std_logic_vector(1 downto 0) := "10";
constant reg_t_flags: 	std_logic_vector(1 downto 0) := "11";

--
-- L0045.reg_b: 2 values same, alu_y, t, df_d_dn default same
--
alias uc_reg_b: 	std_logic_vector(1 downto 0) is ucode(32 downto 31);
constant reg_b_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_b_alu_y: 	std_logic_vector(1 downto 0) := "01";
constant reg_b_t: 	std_logic_vector(1 downto 0) := "10";
constant reg_b_df_d_dn: 	std_logic_vector(1 downto 0) := "11";

--
-- L0046.reg_x: 2 values same, n, alu_yhi, p default same
--
alias uc_reg_x: 	std_logic_vector(1 downto 0) is ucode(30 downto 29);
constant reg_x_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_x_n: 	std_logic_vector(1 downto 0) := "01";
constant reg_x_alu_yhi: 	std_logic_vector(1 downto 0) := "10";
constant reg_x_p: 	std_logic_vector(1 downto 0) := "11";

--
-- L0047.reg_p: 2 values same, n, alu_ylo, default same
--
alias uc_reg_p: 	std_logic_vector(1 downto 0) is ucode(28 downto 27);
constant reg_p_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_p_n: 	std_logic_vector(1 downto 0) := "01";
constant reg_p_alu_ylo: 	std_logic_vector(1 downto 0) := "10";
-- Values from "11" to "11" allowed

--
-- L0048.reg_in: 1 values same, alu_y default same
--
alias uc_reg_in: 	std_logic is ucode(26);
constant reg_in_same: 	std_logic := '0';
constant reg_in_alu_y: 	std_logic := '1';

--
-- L0049.reg_q: 2 values same, zero, one default same
--
alias uc_reg_q: 	std_logic_vector(1 downto 0) is ucode(25 downto 24);
constant reg_q_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_q_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_q_one: 	std_logic_vector(1 downto 0) := "10";

--
-- L0050.reg_mie: 2 values same, enable, disable default same
--
alias uc_reg_mie: 	std_logic_vector(1 downto 0) is ucode(23 downto 22);
constant reg_mie_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_mie_enable: 	std_logic_vector(1 downto 0) := "01";
constant reg_mie_disable: 	std_logic_vector(1 downto 0) := "10";

--
-- L0053.reg_trace: 2 values same,ss_enable_zero,ss_disable_zero,ss_disable_chardefault same
--
alias uc_reg_trace: 	std_logic_vector(1 downto 0) is ucode(21 downto 20);
constant reg_trace_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_trace_ss_enable_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_trace_ss_disable_zero: 	std_logic_vector(1 downto 0) := "10";
constant reg_trace_ss_disable_char: 	std_logic_vector(1 downto 0) := "11";

--
-- L0059.reg_extend: 2 values same, zero, one default same
--
alias uc_reg_extend: 	std_logic_vector(1 downto 0) is ucode(19 downto 18);
constant reg_extend_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_extend_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_extend_one: 	std_logic_vector(1 downto 0) := "10";

--
-- L0063.reg_lo: 1 values alu16_ylo, alu_y default alu16_ylo
--
alias uc_reg_lo: 	std_logic is ucode(17);
constant reg_lo_alu16_ylo: 	std_logic := '0';
constant reg_lo_alu_y: 	std_logic := '1';

--
-- L0064.reg_hi: 1 values alu16_yhi, alu_y default alu16_yhi
--
alias uc_reg_hi: 	std_logic is ucode(16);
constant reg_hi_alu16_yhi: 	std_logic := '0';
constant reg_hi_alu_y: 	std_logic := '1';

--
-- L0065.sel_reg: 3 values zero, one, two, x, n, p default zero
--
alias uc_sel_reg: 	std_logic_vector(2 downto 0) is ucode(15 downto 13);
constant sel_reg_zero: 	std_logic_vector(2 downto 0) := "000";
constant sel_reg_one: 	std_logic_vector(2 downto 0) := "001";
constant sel_reg_two: 	std_logic_vector(2 downto 0) := "010";
constant sel_reg_x: 	std_logic_vector(2 downto 0) := "011";
constant sel_reg_n: 	std_logic_vector(2 downto 0) := "100";
constant sel_reg_p: 	std_logic_vector(2 downto 0) := "101";

--
-- L0069.alu16_f: 2 values nop, clear, plus_one, minus_one default nop
--
alias uc_alu16_f: 	std_logic_vector(1 downto 0) is ucode(12 downto 11);
constant alu16_f_nop: 	std_logic_vector(1 downto 0) := "00";
constant alu16_f_clear: 	std_logic_vector(1 downto 0) := "01";
constant alu16_f_plus_one: 	std_logic_vector(1 downto 0) := "10";
constant alu16_f_minus_one: 	std_logic_vector(1 downto 0) := "11";

--
-- L0073.alu_r: 2 values t, d, b, reg_hi default t
--
alias uc_alu_r: 	std_logic_vector(1 downto 0) is ucode(10 downto 9);
constant alu_r_t: 	std_logic_vector(1 downto 0) := "00";
constant alu_r_d: 	std_logic_vector(1 downto 0) := "01";
constant alu_r_b: 	std_logic_vector(1 downto 0) := "10";
constant alu_r_reg_hi: 	std_logic_vector(1 downto 0) := "11";

--
-- L0074.alu_s: 2 values bus,  d, const, reg_lo default bus
--
alias uc_alu_s: 	std_logic_vector(1 downto 0) is ucode(8 downto 7);
constant alu_s_bus: 	std_logic_vector(1 downto 0) := "00";
constant alu_s_d: 	std_logic_vector(1 downto 0) := "01";
constant alu_s_const: 	std_logic_vector(1 downto 0) := "10";
constant alu_s_reg_lo: 	std_logic_vector(1 downto 0) := "11";

--
-- L0084.alu_f: 3 values xor, and, ior, pass_r, r_plus_s, r_plus_ns, nr_plus_s, pass_s default xor
--
alias uc_alu_f: 	std_logic_vector(2 downto 0) is ucode(6 downto 4);
constant alu_f_xor: 	std_logic_vector(2 downto 0) := "000";
constant alu_f_and: 	std_logic_vector(2 downto 0) := "001";
constant alu_f_ior: 	std_logic_vector(2 downto 0) := "010";
constant alu_f_pass_r: 	std_logic_vector(2 downto 0) := "011";
constant alu_f_r_plus_s: 	std_logic_vector(2 downto 0) := "100";
constant alu_f_r_plus_ns: 	std_logic_vector(2 downto 0) := "101";
constant alu_f_nr_plus_s: 	std_logic_vector(2 downto 0) := "110";
constant alu_f_pass_s: 	std_logic_vector(2 downto 0) := "111";

--
-- L0085.alu_cin: 1 values f1_or_f0, df default f1_or_f0
--
alias uc_alu_cin: 	std_logic is ucode(3);
constant alu_cin_f1_or_f0: 	std_logic := '0';
constant alu_cin_df: 	std_logic := '1';

--
-- L0088.sc: 2 valuessc_fetch,sc_execute,sc_dma,sc_interrupt default sc_execute
--
alias uc_sc: 	std_logic_vector(1 downto 0) is ucode(2 downto 1);
constant sc_sc_fetch: 	std_logic_vector(1 downto 0) := "00";
constant sc_sc_execute: 	std_logic_vector(1 downto 0) := "01";
constant sc_sc_dma: 	std_logic_vector(1 downto 0) := "10";
constant sc_sc_interrupt: 	std_logic_vector(1 downto 0) := "11";

--
-- L0094.ct_oper: 1 values disable, enable default disable
--
alias uc_ct_oper: 	std_logic is ucode(0);
constant ct_oper_disable: 	std_logic := '0';
constant ct_oper_enable: 	std_logic := '1';



constant microcode: code_memory := (
-- L0141@0000._reset: reg_trace <= ss_enable_zero
0 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "01" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0143@0001._reset1: reg_trace <= ss_enable_zero
1 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "01" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0145@0002._reset2: reg_q <= zero,alu_f = xor, alu_r = d, alu_s = d, reg_in <= alu_y
2 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '1' & "01" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "01" & "01" & "000" & '0' & "01" & '0',

-- L0149@0003._reset3: alu16_f = clear,  reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, sel_reg = zero,reg_mie <= enable,reg_t <= xp,alu_f = xor, alu_r = d, alu_s = d, reg_x <= n, reg_p <= n,reg_extend <= zero
3 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "10" & "00" & "01" & "01" & '0' & "00" & "01" & "00" & "01" & '0' & '0' & "000" & "01" & "01" & "01" & "000" & '0' & "01" & '0',

-- L0157@0004.fetch: sc = sc_fetch, direction = mem2any, sel_reg = p, reg_in <= alu_y, alu_f = pass_s, alu_s = bus, reg_sample <= sample, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
4 => "100" & '1' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '1' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "00" & '0',

-- L0161@0005.load_b: direction = mem2any, sel_reg = x, reg_b <= alu_y, alu_f = pass_s, alu_s = bus,if traceEnabled then traceState else fork
5 => "100" & '0' & X"D" & X"20" & X"03" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "00" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0168@0010.dma_or_int: reg_sample <= sample, if continue_sw then fetch else dma_or_int
16 => "000" & '1' & X"7" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0171@0011.fetch1: sc = sc_fetch, direction = mem2any, sel_reg = p, reg_in <= alu_y, alu_f = pass_s, alu_s = bus, reg_sample <= sample, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else load_b
17 => "100" & '1' & X"F" & X"00" & X"05" & "000" & "00" & "00" & "00" & "00" & "00" & '1' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "00" & '0',

-- L0175@0013.int_ack: sc = sc_interrupt,alu_f = pass_s, alu_s = const, reg_t <= xp, reg_x <= alu_yhi, reg_p <= alu_ylo,reg_mie <= disable,if true then fetch else 0x21
19 => "000" & '0' & X"0" & X"04" & X"21" & "000" & "00" & "10" & "00" & "10" & "10" & '0' & "00" & "10" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "10" & "111" & '0' & "11" & '0',

-- L0181@0015.dma_out: sc = sc_dma, direction = mem2any, sel_reg = zero, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
21 => "100" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "10" & "00" & "00" & "000" & '0' & "10" & '0',

-- L0185@0017. sc = sc_dma, direction = mem2any, sel_reg = zero, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
23 => "100" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "10" & "00" & "00" & "000" & '0' & "10" & '0',

-- L0189@0019.dma_in: sc = sc_dma, direction = dev2any, sel_reg = zero, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
25 => "010" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "10" & "00" & "00" & "000" & '0' & "10" & '0',

-- L0193@001B. sc = sc_dma, direction = dev2any, sel_reg = zero, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
27 => "010" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "10" & "00" & "00" & "000" & '0' & "10" & '0',

-- L0197@001D. sc = sc_dma, direction = dev2any, sel_reg = zero, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
29 => "010" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "10" & "00" & "00" & "000" & '0' & "10" & '0',

-- L0201@001F. sc = sc_dma, direction = dev2any, sel_reg = zero, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
31 => "010" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "10" & "00" & "00" & "000" & '0' & "10" & '0',

-- L0211@0020.traceState: alu_f = pass_r, alu_r = d, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else 'D'
32 => "000" & '0' & X"0" & X"5C" & X"44" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "01" & "00" & "011" & '0' & "01" & '0',

-- L0212@0021. if false then next else traceET
33 => "000" & '0' & X"F" & X"00" & X"57" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0214@0022. alu_f = pass_r, alu_r = b, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else 'B'
34 => "000" & '0' & X"0" & X"5C" & X"42" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0215@0023. if false then next else traceET
35 => "000" & '0' & X"F" & X"00" & X"57" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0217@0024. reg_t <= flags, reg_trace <= ss_disable_char, if true then traceChar else 'F'
36 => "000" & '0' & X"0" & X"5C" & X"46" & "000" & "00" & "11" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0218@0025. reg_trace <= ss_disable_char, if true then traceChar else 'L'
37 => "000" & '0' & X"0" & X"5C" & X"4C" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0219@0026. if false then next else traceET
38 => "000" & '0' & X"F" & X"00" & X"57" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0221@0027. reg_t <= xp, reg_trace <= ss_disable_char, if true then traceChar else 'X'
39 => "000" & '0' & X"0" & X"5C" & X"58" & "000" & "00" & "10" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0222@0028. reg_trace <= ss_disable_char, if true then traceChar else 'P'
40 => "000" & '0' & X"0" & X"5C" & X"50" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0223@0029. if false then next else traceET
41 => "000" & '0' & X"F" & X"00" & X"57" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0229@002A. reg_trace <= ss_disable_char, if true then traceChar else 'R'
42 => "000" & '0' & X"0" & X"5C" & X"52" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0230@002B. reg_trace <= ss_disable_char, if true then traceChar else '0'
43 => "000" & '0' & X"0" & X"5C" & X"30" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0231@002C. if false then next else traceReg0
44 => "000" & '0' & X"F" & X"00" & X"3F" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0233@002D. reg_trace <= ss_disable_char, if true then traceChar else 'R'
45 => "000" & '0' & X"0" & X"5C" & X"52" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0234@002E. reg_trace <= ss_disable_char, if true then traceChar else '1'
46 => "000" & '0' & X"0" & X"5C" & X"31" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0235@002F. if false then next else traceReg1
47 => "000" & '0' & X"F" & X"00" & X"43" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0237@0030. reg_trace <= ss_disable_char, if true then traceChar else 'R'
48 => "000" & '0' & X"0" & X"5C" & X"52" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0238@0031. reg_trace <= ss_disable_char, if true then traceChar else '2'
49 => "000" & '0' & X"0" & X"5C" & X"32" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0239@0032. if false then next else traceReg2
50 => "000" & '0' & X"F" & X"00" & X"47" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0241@0033. reg_trace <= ss_disable_char, if true then traceChar else 'R'
51 => "000" & '0' & X"0" & X"5C" & X"52" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0242@0034. reg_trace <= ss_disable_char, if true then traceChar else 'X'
52 => "000" & '0' & X"0" & X"5C" & X"58" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0243@0035. if false then next else traceRegX
53 => "000" & '0' & X"F" & X"00" & X"4B" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0245@0036. reg_trace <= ss_disable_char, if true then traceChar else 'R'
54 => "000" & '0' & X"0" & X"5C" & X"52" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0246@0037. reg_trace <= ss_disable_char, if true then traceChar else 'P'
55 => "000" & '0' & X"0" & X"5C" & X"50" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0247@0038. if false then next else traceRegP
56 => "000" & '0' & X"F" & X"00" & X"4F" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0249@0039. reg_trace <= ss_disable_char, if true then traceChar else 'R'
57 => "000" & '0' & X"0" & X"5C" & X"52" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0250@003A. reg_trace <= ss_disable_char, if true then traceChar else 'N'
58 => "000" & '0' & X"0" & X"5C" & X"4E" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0251@003B. if false then next else traceRegN
59 => "000" & '0' & X"F" & X"00" & X"53" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0253@003C. reg_trace <= ss_disable_char, if true then traceChar else 0x0D
60 => "000" & '0' & X"0" & X"5C" & X"0D" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0254@003D. reg_trace <= ss_disable_char, if true then traceChar else 0x0A
61 => "000" & '0' & X"0" & X"5C" & X"0A" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0256@003E. reg_trace <= ss_enable_zero,if false then next else fork
62 => "000" & '0' & X"F" & X"00" & X"03" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "01" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0259@003F.traceReg0: alu_f = pass_r, alu_r = reg_hi, sel_reg = zero, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
63 => "000" & '0' & X"0" & X"5C" & X"3D" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0260@0040. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
64 => "000" & '0' & X"0" & X"5C" & X"81" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0261@0041. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
65 => "000" & '0' & X"0" & X"5C" & X"80" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0262@0042. alu_f = pass_s, alu_s = reg_lo, sel_reg = zero, reg_t <= alu_y, if false then next else traceT
66 => "000" & '0' & X"F" & X"00" & X"58" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0264@0043.traceReg1: alu_f = pass_r, alu_r = reg_hi, sel_reg = one, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
67 => "000" & '0' & X"0" & X"5C" & X"3D" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "001" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0265@0044. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
68 => "000" & '0' & X"0" & X"5C" & X"81" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0266@0045. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
69 => "000" & '0' & X"0" & X"5C" & X"80" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0267@0046. alu_f = pass_s, alu_s = reg_lo, sel_reg = one, reg_t <= alu_y, if false then next else traceT
70 => "000" & '0' & X"F" & X"00" & X"58" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "001" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0269@0047.traceReg2: alu_f = pass_r, alu_r = reg_hi, sel_reg = two, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
71 => "000" & '0' & X"0" & X"5C" & X"3D" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "010" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0270@0048. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
72 => "000" & '0' & X"0" & X"5C" & X"81" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0271@0049. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
73 => "000" & '0' & X"0" & X"5C" & X"80" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0272@004A. alu_f = pass_s, alu_s = reg_lo, sel_reg = two, reg_t <= alu_y, if false then next else traceT
74 => "000" & '0' & X"F" & X"00" & X"58" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "010" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0274@004B.traceRegX: alu_f = pass_r, alu_r = reg_hi, sel_reg = x, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
75 => "000" & '0' & X"0" & X"5C" & X"3D" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "011" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0275@004C. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
76 => "000" & '0' & X"0" & X"5C" & X"81" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0276@004D. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
77 => "000" & '0' & X"0" & X"5C" & X"80" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0277@004E. alu_f = pass_s, alu_s = reg_lo, sel_reg = x, reg_t <= alu_y, if false then next else traceT
78 => "000" & '0' & X"F" & X"00" & X"58" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0279@004F.traceRegP: alu_f = pass_r, alu_r = reg_hi, sel_reg = p, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
79 => "000" & '0' & X"0" & X"5C" & X"3D" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "101" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0280@0050. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
80 => "000" & '0' & X"0" & X"5C" & X"81" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0281@0051. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
81 => "000" & '0' & X"0" & X"5C" & X"80" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0282@0052. alu_f = pass_s, alu_s = reg_lo, sel_reg = p, reg_t <= alu_y, if false then next else traceT
82 => "000" & '0' & X"F" & X"00" & X"58" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0284@0053.traceRegN: alu_f = pass_r, alu_r = reg_hi, sel_reg = n, reg_t <= alu_y, reg_trace <= ss_disable_char, if true then traceChar else '='
83 => "000" & '0' & X"0" & X"5C" & X"3D" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "100" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0285@0054. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
84 => "000" & '0' & X"0" & X"5C" & X"81" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0286@0055. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
85 => "000" & '0' & X"0" & X"5C" & X"80" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0287@0056. alu_f = pass_s, alu_s = reg_lo, sel_reg = n, reg_t <= alu_y, if false then next else traceT
86 => "000" & '0' & X"F" & X"00" & X"58" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0289@0057.traceET: reg_trace <= ss_disable_char, if true then traceChar else '='
87 => "000" & '0' & X"0" & X"5C" & X"3D" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0290@0058.traceT: reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
88 => "000" & '0' & X"0" & X"5C" & X"81" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0291@0059. reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
89 => "000" & '0' & X"0" & X"5C" & X"80" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0292@005A. reg_trace <= ss_disable_char, if true then traceChar else ' '
90 => "000" & '0' & X"0" & X"5C" & X"20" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0293@005B. if false then next else return
91 => "000" & '0' & X"F" & X"00" & X"02" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0295@005C.traceChar: if traceReady then next else repeat
92 => "000" & '0' & X"E" & X"00" & X"01" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0296@005D. reg_trace <= ss_disable_zero, if false then next else return
93 => "000" & '0' & X"F" & X"00" & X"02" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "10" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0299@005E.XNOP: if false then next else NOP
94 => "000" & '0' & X"F" & X"00" & X"89" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0305@005F.LDN: direction = mem2any, sel_reg = n, alu_f = pass_s, alu_s = bus, reg_d <= alu_y,if continue then fetch else dma_or_int
95 => "100" & '0' & X"6" & X"04" & X"10" & "001" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0309@0060.IDL: reg_sample <= sample
96 => "000" & '1' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0311@0061. if continue then IDL else dma_or_int
97 => "000" & '0' & X"6" & X"60" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0314@0062.INC: sel_reg = n, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
98 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "10" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0318@0063.DEC: sel_reg = n, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
99 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "11" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0322@0064.SBRANCH: direction = mem2any, sel_reg = p, alu_f = pass_s, alu_s = bus, reg_b <= alu_y,if cond_3X then sbranch2 else next
100 => "100" & '0' & X"3" & X"66" & X"00" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "00" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0325@0065.skip1: sel_reg = p, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
101 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0328@0066.sbranch2: sel_reg = p, reg_lo <= alu_y, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
102 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '1' & '0' & "101" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0332@0067.LDA: direction = mem2any, sel_reg = n, alu_f = pass_s, alu_s = bus, reg_d <= alu_y,if false then next else INC
103 => "100" & '0' & X"F" & X"00" & X"62" & "001" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0336@0068.STR: direction = cpu2mem, sel_reg = n, alu_f = pass_r, alu_r = d,if continue then fetch else dma_or_int
104 => "011" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "01" & "00" & "011" & '0' & "01" & '0',

-- L0340@0069.OUT: sel_reg = x, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, direction = mem2any,if continue then fetch else dma_or_int
105 => "100" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "10" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0344@006A.IRX: sel_reg = x, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
106 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "10" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0348@006B.INP: sel_reg = x, alu_f = pass_s, alu_s = bus, reg_d <= alu_y, direction = dev2any,if continue then fetch else dma_or_int
107 => "010" & '0' & X"6" & X"04" & X"10" & "001" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "00" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0352@006C.EXTEND: if mode_1805 then next else NOP
108 => "000" & '0' & X"1" & X"00" & X"89" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0354@006D. sc = sc_fetch, direction = mem2any, sel_reg = p, reg_in <= alu_y, alu_f = pass_s, alu_s = bus, reg_sample <= sample, reg_extend <= one,alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else load_b
109 => "100" & '1' & X"F" & X"00" & X"05" & "000" & "00" & "00" & "00" & "00" & "00" & '1' & "00" & "00" & "00" & "10" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "00" & '0',

-- L0359@006E.RET: alu_f = pass_r, alu_r = b, reg_x <= alu_yhi, reg_p <= alu_ylo, reg_mie <= enable,sel_reg = x, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
110 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "10" & "10" & '0' & "00" & "01" & "00" & "00" & '0' & '0' & "011" & "10" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0364@006F.DIS: alu_f = pass_r, alu_r = b, reg_x <= alu_yhi, reg_p <= alu_ylo, reg_mie <= disable,sel_reg = x, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
111 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "10" & "10" & '0' & "00" & "10" & "00" & "00" & '0' & '0' & "011" & "10" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0369@0070.LDXA: alu_f = pass_r, alu_r = b, reg_d <= alu_y
112 => "000" & '0' & X"0" & X"00" & X"00" & "001" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0371@0071. sel_reg = x, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
113 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "10" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0375@0072.STXD: alu_f = pass_r, alu_r = d, direction = cpu2mem
114 => "011" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "01" & "00" & "011" & '0' & "01" & '0',

-- L0377@0073. sel_reg = x, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
115 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "11" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0382@0074.ADC: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = b, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
116 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "10" & "01" & "100" & '1' & "01" & '0',

-- L0386@0075.SDB: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_ns, alu_r = b, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
117 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "10" & "01" & "101" & '1' & "01" & '0',

-- L0390@0076.SHRC: reg_d <= shift_dn_df, reg_df <= d_lsb,if continue then fetch else dma_or_int
118 => "000" & '0' & X"6" & X"04" & X"10" & "010" & "10" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0395@0077.SMB: reg_df <= alu_cout, reg_d <= alu_y, alu_f = nr_plus_s, alu_r = b, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
119 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "10" & "01" & "110" & '1' & "01" & '0',

-- L0399@0078.SAV: reg_b <= alu_y, alu_f = pass_r, alu_r = t
120 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "011" & '0' & "01" & '0',

-- L0401@0079. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
121 => "011" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0405@007A.MARK: reg_t <= xp
122 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "10" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0407@007B. reg_x <= p, direction = cpu2mem, sel_reg = two, alu_f = pass_r, alu_r = t, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
123 => "011" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "11" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "010" & "11" & "00" & "00" & "011" & '0' & "01" & '0',

-- L0411@007C.REQ: reg_q <= zero,if continue then fetch else dma_or_int
124 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "01" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0415@007D.SEQ: reg_q <= one,if continue then fetch else dma_or_int
125 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "10" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0420@007E.ADCI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else ADC
126 => "100" & '0' & X"F" & X"00" & X"74" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0424@007F.SDBI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else SDB
127 => "100" & '0' & X"F" & X"00" & X"75" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0428@0080.SHLC: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = d, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
128 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "01" & "01" & "100" & '1' & "01" & '0',

-- L0433@0081.SMBI: sc = sc_execute, direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else SMB
129 => "100" & '0' & X"F" & X"00" & X"77" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0437@0082.GLO: reg_d <= alu_y, alu_f = pass_s, alu_s = reg_lo,if continue then fetch else dma_or_int
130 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0441@0083.GHI: reg_d <= alu_y, alu_f = pass_r, alu_r = reg_hi,if continue then fetch else dma_or_int
131 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0445@0084.PLO: reg_lo <= alu_y, alu_f = pass_r, alu_r = d,if continue then fetch else dma_or_int
132 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '1' & '0' & "000" & "00" & "01" & "00" & "011" & '0' & "01" & '0',

-- L0449@0085.PHI: reg_hi <= alu_y, alu_f = pass_r, alu_r = d,if continue then fetch else dma_or_int
133 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '1' & "000" & "00" & "01" & "00" & "011" & '0' & "01" & '0',

-- L0453@0086.LBRANCH: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if cond_CX then next else skip1
134 => "100" & '0' & X"C" & X"00" & X"65" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0456@0087. direction = mem2any, sel_reg = p, reg_lo <= alu_y, alu_f = pass_s, alu_s = bus
135 => "100" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '1' & '0' & "101" & "00" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0458@0088. sel_reg = p, reg_hi <= alu_y, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
136 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '1' & "101" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0462@0089.NOP: if continue then fetch else dma_or_int
137 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0465@008A.SEP: reg_p <= n,if continue then fetch else dma_or_int
138 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "01" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0469@008B.SEX: reg_x <= n,if continue then fetch else dma_or_int
139 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "01" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0473@008C.LDX: reg_d <= alu_y, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
140 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0477@008D.OR: reg_d <= alu_y, alu_f = ior, alu_r = b, alu_s = d,if continue then fetch else dma_or_int
141 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "10" & "01" & "010" & '0' & "01" & '0',

-- L0481@008E.AND: reg_d <= alu_y, alu_f = and, alu_r = b, alu_s = d,if continue then fetch else dma_or_int
142 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "10" & "01" & "001" & '0' & "01" & '0',

-- L0485@008F.XOR: reg_d <= alu_y, alu_f = xor, alu_r = b, alu_s = d,if continue then fetch else dma_or_int
143 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "10" & "01" & "000" & '0' & "01" & '0',

-- L0490@0090.ADD: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = b, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
144 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "10" & "01" & "100" & '0' & "01" & '0',

-- L0494@0091.SD: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_ns, alu_r = b, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
145 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "10" & "01" & "101" & '0' & "01" & '0',

-- L0498@0092.SHR: reg_d <= shift_dn_0, reg_df <= d_lsb,if continue then fetch else dma_or_int
146 => "000" & '0' & X"6" & X"04" & X"10" & "011" & "10" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0503@0093.SM: reg_df <= alu_cout, reg_d <= alu_y, alu_f = nr_plus_s, alu_r = b, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
147 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "10" & "01" & "110" & '0' & "01" & '0',

-- L0507@0094.LDI: direction = mem2any, sel_reg = p, reg_d <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
148 => "100" & '0' & X"6" & X"04" & X"10" & "001" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0511@0095.ORI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else OR
149 => "100" & '0' & X"F" & X"00" & X"8D" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0515@0096.ANI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else AND
150 => "100" & '0' & X"F" & X"00" & X"8E" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0519@0097.XRI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else XOR
151 => "100" & '0' & X"F" & X"00" & X"8F" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0524@0098.ADI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else ADD
152 => "100" & '0' & X"F" & X"00" & X"90" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0528@0099.SDI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else SD
153 => "100" & '0' & X"F" & X"00" & X"91" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0532@009A.SHL: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = d, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
154 => "000" & '0' & X"6" & X"04" & X"10" & "001" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "000" & "00" & "01" & "01" & "100" & '0' & "01" & '0',

-- L0537@009B.SMI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else SM
155 => "100" & '0' & X"F" & X"00" & X"93" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0544@009C.STPC: sel_reg = n,if continue then fetch else dma_or_int
156 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0548@009D.DTC: sel_reg = n,if continue then fetch else dma_or_int
157 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0552@009E.SPM2: sel_reg = n,if continue then fetch else dma_or_int
158 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0556@009F.SCM2: sel_reg = n,if continue then fetch else dma_or_int
159 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0560@00A0.SPM1: sel_reg = n,if continue then fetch else dma_or_int
160 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0564@00A1.SCM1: sel_reg = n,if continue then fetch else dma_or_int
161 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0568@00A2.LDC: sel_reg = n,if continue then fetch else dma_or_int
162 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0572@00A3.STM: sel_reg = n,if continue then fetch else dma_or_int
163 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0576@00A4.GEC: sel_reg = n,if continue then fetch else dma_or_int
164 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0580@00A5.ETQ: sel_reg = n,if continue then fetch else dma_or_int
165 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0584@00A6.XIE: sel_reg = n,if continue then fetch else dma_or_int
166 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0588@00A7.XID: sel_reg = n,if continue then fetch else dma_or_int
167 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0592@00A8.CIE: sel_reg = n,if continue then fetch else dma_or_int
168 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0596@00A9.CID: sel_reg = n,if continue then fetch else dma_or_int
169 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0600@00AA.DBNZ: sel_reg = n, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if alu16_zero then skip2 else next
170 => "000" & '0' & X"B" & X"AE" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "11" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0603@00AB. direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
171 => "100" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0605@00AC. direction = mem2any, sel_reg = p, reg_lo <= alu_y, alu_f = pass_s, alu_s = bus
172 => "100" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '1' & '0' & "101" & "00" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0607@00AD. sel_reg = p, reg_hi <= alu_y, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
173 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '1' & "101" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0610@00AE.skip2: sel_reg = p, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if false then next else skip1
174 => "000" & '0' & X"F" & X"00" & X"65" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0614@00AF.BCI: direction = mem2any, sel_reg = p, alu_f = pass_s, alu_s = bus, reg_b <= alu_y,if counterInt then sbranch2 else skip1
175 => "100" & '0' & X"A" & X"66" & X"65" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "00" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0618@00B0.BXI: direction = mem2any, sel_reg = p, alu_f = pass_s, alu_s = bus, reg_b <= alu_y,if externalInt then sbranch2 else skip1
176 => "100" & '0' & X"9" & X"66" & X"65" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "00" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0622@00B1.RLXA: direction = mem2any, sel_reg = x, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
177 => "100" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0624@00B2. direction = mem2any, sel_reg = x, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
178 => "100" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0626@00B3. sel_reg = n, reg_hi <= alu_y, alu_f = pass_r, alu_r = b, reg_b <= t
179 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "10" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '1' & "100" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0628@00B4. sel_reg = n, reg_lo <= alu_y, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
180 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '1' & '0' & "100" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0632@00B5.DSAV: sel_reg = x, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
181 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "11" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0634@00B6. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = t, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
182 => "011" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "11" & "00" & "00" & "011" & '0' & "01" & '0',

-- L0636@00B7. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = d, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, reg_b <= df_d_dn
183 => "011" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "11" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "11" & "01" & "00" & "011" & '0' & "01" & '0',

-- L0638@00B8. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = b, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
184 => "011" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "11" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0642@00B9.SCAL: sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
185 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0644@00BA. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
186 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0646@00BB. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = t, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
187 => "011" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "11" & "00" & "00" & "011" & '0' & "01" & '0',

-- L0648@00BC. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = b, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
188 => "011" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "11" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0650@00BD. sel_reg = p, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
189 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0652@00BE. sel_reg = p, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
190 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0654@00BF. sel_reg = n, reg_lo <= alu_y, alu_f = pass_r, alu_r = t
191 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '1' & '0' & "100" & "00" & "00" & "00" & "011" & '0' & "01" & '0',

-- L0656@00C0. sel_reg = n, reg_hi <= alu_y, alu_f = pass_r, alu_r = b
192 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '1' & "100" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0658@00C1. direction = mem2any, sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
193 => "100" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0660@00C2. direction = mem2any, sel_reg = n, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
194 => "100" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0662@00C3. sel_reg = p, reg_lo <= alu_y, alu_f = pass_r, alu_r = t
195 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '1' & '0' & "101" & "00" & "00" & "00" & "011" & '0' & "01" & '0',

-- L0664@00C4. sel_reg = p, reg_hi <= alu_y, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
196 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '1' & "101" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0668@00C5.SRET: sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
197 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0670@00C6. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
198 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0672@00C7. sel_reg = x, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
199 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "10" & "00" & "00" & "000" & '0' & "01" & '0',

-- L0674@00C8. sel_reg = p, reg_lo <= alu_y, alu_f = pass_r, alu_r = t
200 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '1' & '0' & "101" & "00" & "00" & "00" & "011" & '0' & "01" & '0',

-- L0676@00C9. sel_reg = p, reg_hi <= alu_y, alu_f = pass_r, alu_r = b
201 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '1' & "101" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0678@00CA. direction = mem2any, sel_reg = x, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
202 => "100" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0680@00CB. direction = mem2any, sel_reg = x, reg_b <= alu_y, alu_f = pass_s, alu_s = bus,if false then next else load_n
203 => "100" & '0' & X"F" & X"00" & X"D6" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "00" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0684@00CC.RSXD: sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
204 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0686@00CD. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
205 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0688@00CE. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = t, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
206 => "011" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "11" & "00" & "00" & "011" & '0' & "01" & '0',

-- L0690@00CF. direction = cpu2mem, sel_reg = x, alu_f = pass_r, alu_r = b, alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo,if continue then fetch else dma_or_int
207 => "011" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "011" & "11" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0694@00D0.RNX: sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
208 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "00" & "11" & "111" & '0' & "01" & '0',

-- L0696@00D1. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
209 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "100" & "00" & "11" & "00" & "011" & '0' & "01" & '0',

-- L0698@00D2. sel_reg = x, reg_lo <= alu_y, alu_f = pass_r, alu_r = t
210 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '1' & '0' & "011" & "00" & "00" & "00" & "011" & '0' & "01" & '0',

-- L0700@00D3. sel_reg = x, reg_hi <= alu_y, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
211 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '1' & "011" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

-- L0704@00D4.RLDI: direction = mem2any, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
212 => "100" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0706@00D5. direction = mem2any, sel_reg = p, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
213 => "100" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '0' & "101" & "10" & "00" & "00" & "111" & '0' & "01" & '0',

-- L0708@00D6.load_n: sel_reg = n, reg_lo <= alu_y, alu_f = pass_r, alu_r = t
214 => "000" & '0' & X"0" & X"00" & X"00" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '1' & '0' & "100" & "00" & "00" & "00" & "011" & '0' & "01" & '0',

-- L0710@00D7. sel_reg = n, reg_hi <= alu_y, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
215 => "000" & '0' & X"6" & X"04" & X"10" & "000" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & '0' & '1' & "100" & "00" & "10" & "00" & "011" & '0' & "01" & '0',

others => null
);

end cdp180x_code;

