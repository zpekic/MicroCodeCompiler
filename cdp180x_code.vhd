--------------------------------------------------------
-- mcc V0.9.0627 - Custom microcode compiler (c)2020-... 
--    https://github.com/zpekic/MicroCodeCompiler
--------------------------------------------------------
-- Auto-generated file, do not modify. To customize, create 'code_template.vhd' file in mcc.exe folder
-- Supported placeholders:  [NAME], [SIZES], [TYPE], [FIELDS], [SIGNAL], [MEMORY].
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.numeric_std.all;

package cdp180x_code is

-- memory block size
constant CODE_DATA_WIDTH: 	positive := 64;
constant CODE_ADDRESS_WIDTH: 	positive := 8;
constant CODE_ADDRESS_LAST: 	positive := 255;
constant CODE_IF_WIDTH: 	positive := 4;


type cpu_code_memory is array(0 to 255) of std_logic_vector(63 downto 0);

signal cpu_uinstruction: std_logic_vector(63 downto 0);

--
-- L0010.bus_state: 4 valuesexec_nop,exec_memread,exec_memwrite,exec_ioread,exec_iowrite,dma_memread,dma_memwrite,int_nop,fetch_memread,-,-,-,-,-,-,-default exec_nop
--
alias cpu_bus_state: 	std_logic_vector(3 downto 0) is cpu_uinstruction(63 downto 60);
constant bus_state_exec_nop: 	std_logic_vector(3 downto 0) := X"0";
constant bus_state_exec_memread: 	std_logic_vector(3 downto 0) := X"1";
constant bus_state_exec_memwrite: 	std_logic_vector(3 downto 0) := X"2";
constant bus_state_exec_ioread: 	std_logic_vector(3 downto 0) := X"3";
constant bus_state_exec_iowrite: 	std_logic_vector(3 downto 0) := X"4";
constant bus_state_dma_memread: 	std_logic_vector(3 downto 0) := X"5";
constant bus_state_dma_memwrite: 	std_logic_vector(3 downto 0) := X"6";
constant bus_state_int_nop: 	std_logic_vector(3 downto 0) := X"7";
constant bus_state_fetch_memread: 	std_logic_vector(3 downto 0) := X"8";
-- Value X"9" not allowed (name '-' is not assignable)
-- Value X"A" not allowed (name '-' is not assignable)
-- Value X"B" not allowed (name '-' is not assignable)
-- Value X"C" not allowed (name '-' is not assignable)
-- Value X"D" not allowed (name '-' is not assignable)
-- Value X"E" not allowed (name '-' is not assignable)
-- Value X"F" not allowed (name '-' is not assignable)

--
-- L0029.seq_cond: 4 valuestrue,mode_1805,sync,cond_3X,cond_4,cond_5,continue,continue_sw,cond_8,externalInt,counterInt,alu16_zero,cond_CX,traceEnabled,traceReady,falsedefault true
--
alias cpu_seq_cond: 	std_logic_vector(3 downto 0) is cpu_uinstruction(59 downto 56);
constant seq_cond_true: 	integer := 0;
constant seq_cond_mode_1805: 	integer := 1;
constant seq_cond_sync: 	integer := 2;
constant seq_cond_cond_3X: 	integer := 3;
constant seq_cond_cond_4: 	integer := 4;
constant seq_cond_cond_5: 	integer := 5;
constant seq_cond_continue: 	integer := 6;
constant seq_cond_continue_sw: 	integer := 7;
constant seq_cond_cond_8: 	integer := 8;
constant seq_cond_externalInt: 	integer := 9;
constant seq_cond_counterInt: 	integer := 10;
constant seq_cond_alu16_zero: 	integer := 11;
constant seq_cond_cond_CX: 	integer := 12;
constant seq_cond_traceEnabled: 	integer := 13;
constant seq_cond_traceReady: 	integer := 14;
constant seq_cond_false: 	integer := 15;

--
-- L0047.seq_then: 8 values next, repeat, return, fork, @ default next
--
alias cpu_seq_then: 	std_logic_vector(7 downto 0) is cpu_uinstruction(55 downto 48);
constant seq_then_next: 	std_logic_vector(7 downto 0) := X"00";
constant seq_then_repeat: 	std_logic_vector(7 downto 0) := X"01";
constant seq_then_return: 	std_logic_vector(7 downto 0) := X"02";
constant seq_then_fork: 	std_logic_vector(7 downto 0) := X"03";
-- Jump targets allowed!

--
-- L0048.seq_else: 8 values next, repeat, return, fork, 0x00..0xFF, @ default next
--
alias cpu_seq_else: 	std_logic_vector(7 downto 0) is cpu_uinstruction(47 downto 40);
constant seq_else_next: 	std_logic_vector(7 downto 0) := X"00";
constant seq_else_repeat: 	std_logic_vector(7 downto 0) := X"01";
constant seq_else_return: 	std_logic_vector(7 downto 0) := X"02";
constant seq_else_fork: 	std_logic_vector(7 downto 0) := X"03";
-- Values from X"00" to X"FF" allowed
-- Jump targets allowed!

--
-- L0051.reg_d: 3 values same, alu_y, shift_dn_df, shift_dn_0 default same
--
alias cpu_reg_d: 	std_logic_vector(2 downto 0) is cpu_uinstruction(39 downto 37);
constant reg_d_same: 	std_logic_vector(2 downto 0) := "000";
constant reg_d_alu_y: 	std_logic_vector(2 downto 0) := "001";
constant reg_d_shift_dn_df: 	std_logic_vector(2 downto 0) := "010";
constant reg_d_shift_dn_0: 	std_logic_vector(2 downto 0) := "011";

--
-- L0052.reg_df: 2 values same, d_msb, d_lsb, alu_cout default same
--
alias cpu_reg_df: 	std_logic_vector(1 downto 0) is cpu_uinstruction(36 downto 35);
constant reg_df_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_df_d_msb: 	std_logic_vector(1 downto 0) := "01";
constant reg_df_d_lsb: 	std_logic_vector(1 downto 0) := "10";
constant reg_df_alu_cout: 	std_logic_vector(1 downto 0) := "11";

--
-- L0053.reg_t: 2 values same, alu_y, xp, in default same
--
alias cpu_reg_t: 	std_logic_vector(1 downto 0) is cpu_uinstruction(34 downto 33);
constant reg_t_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_t_alu_y: 	std_logic_vector(1 downto 0) := "01";
constant reg_t_xp: 	std_logic_vector(1 downto 0) := "10";
constant reg_t_in: 	std_logic_vector(1 downto 0) := "11";

--
-- L0054.reg_b: 2 values same, alu_y, t, df_d_dn default same
--
alias cpu_reg_b: 	std_logic_vector(1 downto 0) is cpu_uinstruction(32 downto 31);
constant reg_b_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_b_alu_y: 	std_logic_vector(1 downto 0) := "01";
constant reg_b_t: 	std_logic_vector(1 downto 0) := "10";
constant reg_b_df_d_dn: 	std_logic_vector(1 downto 0) := "11";

--
-- L0055.reg_x: 2 values same, n, alu_yhi, p default same
--
alias cpu_reg_x: 	std_logic_vector(1 downto 0) is cpu_uinstruction(30 downto 29);
constant reg_x_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_x_n: 	std_logic_vector(1 downto 0) := "01";
constant reg_x_alu_yhi: 	std_logic_vector(1 downto 0) := "10";
constant reg_x_p: 	std_logic_vector(1 downto 0) := "11";

--
-- L0056.reg_p: 2 values same, n, alu_ylo, default same
--
alias cpu_reg_p: 	std_logic_vector(1 downto 0) is cpu_uinstruction(28 downto 27);
constant reg_p_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_p_n: 	std_logic_vector(1 downto 0) := "01";
constant reg_p_alu_ylo: 	std_logic_vector(1 downto 0) := "10";
-- Value "11" allowed

--
-- L0057.reg_in: 1 values same, alu_y default same
--
alias cpu_reg_in: 	std_logic is cpu_uinstruction(26);
constant reg_in_same: 	std_logic := '0';
constant reg_in_alu_y: 	std_logic := '1';

--
-- L0058.reg_q: 2 values same, zero, one default same
--
alias cpu_reg_q: 	std_logic_vector(1 downto 0) is cpu_uinstruction(25 downto 24);
constant reg_q_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_q_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_q_one: 	std_logic_vector(1 downto 0) := "10";

--
-- L0059.reg_mie: 2 values same, enable, disable default same
--
alias cpu_reg_mie: 	std_logic_vector(1 downto 0) is cpu_uinstruction(23 downto 22);
constant reg_mie_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_mie_enable: 	std_logic_vector(1 downto 0) := "01";
constant reg_mie_disable: 	std_logic_vector(1 downto 0) := "10";

--
-- L0062.reg_trace: 2 values same,ss_enable_zero,ss_disable_zero,ss_disable_chardefault same
--
alias cpu_reg_trace: 	std_logic_vector(1 downto 0) is cpu_uinstruction(21 downto 20);
constant reg_trace_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_trace_ss_enable_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_trace_ss_disable_zero: 	std_logic_vector(1 downto 0) := "10";
constant reg_trace_ss_disable_char: 	std_logic_vector(1 downto 0) := "11";

--
-- L0068.reg_extend: 2 values same, zero, one default same
--
alias cpu_reg_extend: 	std_logic_vector(1 downto 0) is cpu_uinstruction(19 downto 18);
constant reg_extend_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_extend_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_extend_one: 	std_logic_vector(1 downto 0) := "10";

--
-- L0071.sel_reg: 3 values zero, one, two, x, n, p default zero
--
alias cpu_sel_reg: 	std_logic_vector(2 downto 0) is cpu_uinstruction(17 downto 15);
constant sel_reg_zero: 	std_logic_vector(2 downto 0) := "000";
constant sel_reg_one: 	std_logic_vector(2 downto 0) := "001";
constant sel_reg_two: 	std_logic_vector(2 downto 0) := "010";
constant sel_reg_x: 	std_logic_vector(2 downto 0) := "011";
constant sel_reg_n: 	std_logic_vector(2 downto 0) := "100";
constant sel_reg_p: 	std_logic_vector(2 downto 0) := "101";

--
-- L0072.reg_r: 3 values same, zero, r_plus_one, r_minus_one, yhi_rlo, rhi_ylo, b_t, -  default same
--
alias cpu_reg_r: 	std_logic_vector(2 downto 0) is cpu_uinstruction(14 downto 12);
constant reg_r_same: 	std_logic_vector(2 downto 0) := "000";
constant reg_r_zero: 	std_logic_vector(2 downto 0) := "001";
constant reg_r_r_plus_one: 	std_logic_vector(2 downto 0) := "010";
constant reg_r_r_minus_one: 	std_logic_vector(2 downto 0) := "011";
constant reg_r_yhi_rlo: 	std_logic_vector(2 downto 0) := "100";
constant reg_r_rhi_ylo: 	std_logic_vector(2 downto 0) := "101";
constant reg_r_b_t: 	std_logic_vector(2 downto 0) := "110";
-- Value "111" not allowed (name '-' is not assignable)

--
-- L0076.alu_r: 2 values t, d, b, reg_hi default t
--
alias cpu_alu_r: 	std_logic_vector(1 downto 0) is cpu_uinstruction(11 downto 10);
constant alu_r_t: 	std_logic_vector(1 downto 0) := "00";
constant alu_r_d: 	std_logic_vector(1 downto 0) := "01";
constant alu_r_b: 	std_logic_vector(1 downto 0) := "10";
constant alu_r_reg_hi: 	std_logic_vector(1 downto 0) := "11";

--
-- L0077.alu_s: 2 values bus,  d, const, reg_lo default bus
--
alias cpu_alu_s: 	std_logic_vector(1 downto 0) is cpu_uinstruction(9 downto 8);
constant alu_s_bus: 	std_logic_vector(1 downto 0) := "00";
constant alu_s_d: 	std_logic_vector(1 downto 0) := "01";
constant alu_s_const: 	std_logic_vector(1 downto 0) := "10";
constant alu_s_reg_lo: 	std_logic_vector(1 downto 0) := "11";

--
-- L0087.alu_f: 3 values xor, and, ior, pass_r, r_plus_s, r_plus_ns, nr_plus_s, pass_s default xor
--
alias cpu_alu_f: 	std_logic_vector(2 downto 0) is cpu_uinstruction(7 downto 5);
constant alu_f_xor: 	std_logic_vector(2 downto 0) := "000";
constant alu_f_and: 	std_logic_vector(2 downto 0) := "001";
constant alu_f_ior: 	std_logic_vector(2 downto 0) := "010";
constant alu_f_pass_r: 	std_logic_vector(2 downto 0) := "011";
constant alu_f_r_plus_s: 	std_logic_vector(2 downto 0) := "100";
constant alu_f_r_plus_ns: 	std_logic_vector(2 downto 0) := "101";
constant alu_f_nr_plus_s: 	std_logic_vector(2 downto 0) := "110";
constant alu_f_pass_s: 	std_logic_vector(2 downto 0) := "111";

--
-- L0088.alu_cin: 1 values f1_or_f0, df default f1_or_f0
--
alias cpu_alu_cin: 	std_logic is cpu_uinstruction(4);
constant alu_cin_f1_or_f0: 	std_logic := '0';
constant alu_cin_df: 	std_logic := '1';

--
-- L0090.ct_oper: 4 values disable, enable default disable
--
alias cpu_ct_oper: 	std_logic_vector(3 downto 0) is cpu_uinstruction(3 downto 0);
constant ct_oper_disable: 	std_logic_vector(3 downto 0) := X"0";
constant ct_oper_enable: 	std_logic_vector(3 downto 0) := X"1";



constant cpu_microcode: cpu_code_memory := (

-- L0141@0000._reset: reg_trace <= ss_enable_zero
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 01, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
0 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "01" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0143@0001._reset1: reg_trace <= ss_enable_zero
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 01, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
1 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "01" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0145@0002._reset2: reg_q <= zero,alu_f = xor, alu_r = d, alu_s = d, reg_in <= alu_y
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 1, reg_q <= 01, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 01, alu_s = 01, alu_f = 000, alu_cin = 0, ct_oper = 0000;
2 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '1' & "01" & "00" & "00" & "00" & O"0" & O"0" & "01" & "01" & O"0" & '0' & X"0",

-- L0149@0003._reset3: reg_r <= zero, sel_reg = zero,reg_mie <= enable,reg_t <= xp,alu_f = xor, alu_r = d, alu_s = d, reg_x <= n, reg_p <= n,reg_extend <= zero
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 10, reg_b <= 00, reg_x <= 01, reg_p <= 01, reg_in <= 0, reg_q <= 00, reg_mie <= 01, reg_trace <= 00, reg_extend <= 01, sel_reg = 000, reg_r <= 001, alu_r = 01, alu_s = 01, alu_f = 000, alu_cin = 0, ct_oper = 0000;
3 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "10" & "00" & "01" & "01" & '0' & "00" & "01" & "00" & "01" & O"0" & O"1" & "01" & "01" & O"0" & '0' & X"0",

-- L0157@0004.fetch: bus_state = fetch_memread, sel_reg = p, reg_in <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
--  bus_state = 1000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 1, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
4 => X"8" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '1' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0161@0005.load_b: bus_state = exec_memread, sel_reg = x, reg_b <= alu_y, alu_f = pass_s, alu_s = bus,if traceEnabled then traceState else fork
--  bus_state = 0001, if (1101) then 00100000 else 00000011, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
5 => X"1" & X"D" & X"20" & X"03" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"0" & "00" & "00" & O"7" & '0' & X"0",

-- L0168@0010.dma_or_int: if continue_sw then fetch else dma_or_int
--  bus_state = 0000, if (0111) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
16 => X"0" & X"7" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0171@0011.fetch1: bus_state = fetch_memread, sel_reg = p, reg_in <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else load_b
--  bus_state = 1000, if (1111) then 00000000 else 00000101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 1, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
17 => X"8" & X"F" & X"00" & X"05" & O"0" & "00" & "00" & "00" & "00" & "00" & '1' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0175@0013.int_ack: bus_state = int_nop,alu_f = pass_s, alu_s = const, reg_t <= xp, reg_x <= alu_yhi, reg_p <= alu_ylo,reg_mie <= disable,if true then fetch else 0x21
--  bus_state = 0111, if (0000) then 00000100 else 00100001, reg_d <= 000, reg_df <= 00, reg_t <= 10, reg_b <= 00, reg_x <= 10, reg_p <= 10, reg_in <= 0, reg_q <= 00, reg_mie <= 10, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 10, alu_f = 111, alu_cin = 0, ct_oper = 0000;
19 => X"7" & X"0" & X"04" & X"21" & O"0" & "00" & "10" & "00" & "10" & "10" & '0' & "00" & "10" & "00" & "00" & O"0" & O"0" & "00" & "10" & O"7" & '0' & X"0",

-- L0181@0015.dma_out: bus_state = dma_memread, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0101, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
21 => X"5" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0185@0017. bus_state = dma_memread, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0101, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
23 => X"5" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0189@0019.dma_in: bus_state = dma_memwrite, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0110, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
25 => X"6" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0193@001B. bus_state = dma_memwrite, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0110, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
27 => X"6" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0197@001D. bus_state = dma_memwrite, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0110, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
29 => X"6" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0201@001F. bus_state = dma_memwrite, sel_reg = zero, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0110, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
31 => X"6" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0211@0020.traceState: reg_trace <= ss_disable_char, if true then traceChar else 'D'
--  bus_state = 0000, if (0000) then 01110111 else 01000100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
32 => X"0" & X"0" & X"77" & X"44" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0212@0021. reg_trace <= ss_disable_char, if true then traceChar else '='
--  bus_state = 0000, if (0000) then 01110111 else 00111101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
33 => X"0" & X"0" & X"77" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0213@0022. reg_trace <= ss_disable_char, if true then traceChar else 0b1000_0111
--  bus_state = 0000, if (0000) then 01110111 else 10000111, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
34 => X"0" & X"0" & X"77" & X"87" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0214@0023. reg_trace <= ss_disable_char, if true then traceChar else 0b1000_0110
--  bus_state = 0000, if (0000) then 01110111 else 10000110, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
35 => X"0" & X"0" & X"77" & X"86" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0215@0024. reg_trace <= ss_disable_char, if true then traceChar else ' '
--  bus_state = 0000, if (0000) then 01110111 else 00100000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
36 => X"0" & X"0" & X"77" & X"20" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0217@0025. reg_trace <= ss_disable_char, if true then traceChar else 'B'
--  bus_state = 0000, if (0000) then 01110111 else 01000010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
37 => X"0" & X"0" & X"77" & X"42" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0218@0026. reg_trace <= ss_disable_char, if true then traceChar else '='
--  bus_state = 0000, if (0000) then 01110111 else 00111101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
38 => X"0" & X"0" & X"77" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0219@0027. reg_trace <= ss_disable_char, if true then traceChar else 0b1000_0101
--  bus_state = 0000, if (0000) then 01110111 else 10000101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
39 => X"0" & X"0" & X"77" & X"85" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0220@0028. reg_trace <= ss_disable_char, if true then traceChar else 0b1000_0100
--  bus_state = 0000, if (0000) then 01110111 else 10000100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
40 => X"0" & X"0" & X"77" & X"84" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0221@0029. reg_trace <= ss_disable_char, if true then traceChar else ' '
--  bus_state = 0000, if (0000) then 01110111 else 00100000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
41 => X"0" & X"0" & X"77" & X"20" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0223@002A. reg_trace <= ss_disable_char, if true then traceChar else 'F'
--  bus_state = 0000, if (0000) then 01110111 else 01000110, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
42 => X"0" & X"0" & X"77" & X"46" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0224@002B. reg_trace <= ss_disable_char, if true then traceChar else 'L'
--  bus_state = 0000, if (0000) then 01110111 else 01001100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
43 => X"0" & X"0" & X"77" & X"4C" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0225@002C. reg_trace <= ss_disable_char, if true then traceChar else '='
--  bus_state = 0000, if (0000) then 01110111 else 00111101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
44 => X"0" & X"0" & X"77" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0226@002D. reg_trace <= ss_disable_char, if true then traceChar else 0b1000_0011
--  bus_state = 0000, if (0000) then 01110111 else 10000011, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
45 => X"0" & X"0" & X"77" & X"83" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0227@002E. reg_trace <= ss_disable_char, if true then traceChar else 0b1000_0010
--  bus_state = 0000, if (0000) then 01110111 else 10000010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
46 => X"0" & X"0" & X"77" & X"82" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0228@002F. reg_trace <= ss_disable_char, if true then traceChar else ' '
--  bus_state = 0000, if (0000) then 01110111 else 00100000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
47 => X"0" & X"0" & X"77" & X"20" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0230@0030. reg_trace <= ss_disable_char, if true then traceChar else 'X'
--  bus_state = 0000, if (0000) then 01110111 else 01011000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
48 => X"0" & X"0" & X"77" & X"58" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0231@0031. reg_trace <= ss_disable_char, if true then traceChar else 'P'
--  bus_state = 0000, if (0000) then 01110111 else 01010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
49 => X"0" & X"0" & X"77" & X"50" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0232@0032. reg_trace <= ss_disable_char, if true then traceChar else '='
--  bus_state = 0000, if (0000) then 01110111 else 00111101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
50 => X"0" & X"0" & X"77" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0233@0033. reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1111
--  bus_state = 0000, if (0000) then 01110111 else 10001111, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
51 => X"0" & X"0" & X"77" & X"8F" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0234@0034. reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1110
--  bus_state = 0000, if (0000) then 01110111 else 10001110, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
52 => X"0" & X"0" & X"77" & X"8E" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0235@0035. reg_trace <= ss_disable_char, if true then traceChar else ' '
--  bus_state = 0000, if (0000) then 01110111 else 00100000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
53 => X"0" & X"0" & X"77" & X"20" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0237@0036. reg_trace <= ss_disable_char, if true then traceChar else 'I'
--  bus_state = 0000, if (0000) then 01110111 else 01001001, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
54 => X"0" & X"0" & X"77" & X"49" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0238@0037. reg_trace <= ss_disable_char, if true then traceChar else 'N'
--  bus_state = 0000, if (0000) then 01110111 else 01001110, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
55 => X"0" & X"0" & X"77" & X"4E" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0239@0038. reg_trace <= ss_disable_char, if true then traceChar else '='
--  bus_state = 0000, if (0000) then 01110111 else 00111101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
56 => X"0" & X"0" & X"77" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0240@0039. reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1001
--  bus_state = 0000, if (0000) then 01110111 else 10001001, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
57 => X"0" & X"0" & X"77" & X"89" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0241@003A. reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1000
--  bus_state = 0000, if (0000) then 01110111 else 10001000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
58 => X"0" & X"0" & X"77" & X"88" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0243@003B. if false then next else traceSpR
--  bus_state = 0000, if (1111) then 00000000 else 01110100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
59 => X"0" & X"F" & X"00" & X"74" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0244@003C. if false then next else traceReg0
--  bus_state = 0000, if (1111) then 00000000 else 01001010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
60 => X"0" & X"F" & X"00" & X"4A" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0246@003D. if false then next else traceSpR
--  bus_state = 0000, if (1111) then 00000000 else 01110100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
61 => X"0" & X"F" & X"00" & X"74" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0247@003E. if false then next else traceReg1
--  bus_state = 0000, if (1111) then 00000000 else 01010001, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
62 => X"0" & X"F" & X"00" & X"51" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0249@003F. if false then next else traceSpR
--  bus_state = 0000, if (1111) then 00000000 else 01110100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
63 => X"0" & X"F" & X"00" & X"74" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0250@0040. if false then next else traceReg2
--  bus_state = 0000, if (1111) then 00000000 else 01011000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
64 => X"0" & X"F" & X"00" & X"58" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0252@0041. if false then next else traceSpR
--  bus_state = 0000, if (1111) then 00000000 else 01110100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
65 => X"0" & X"F" & X"00" & X"74" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0253@0042. if false then next else traceRegX
--  bus_state = 0000, if (1111) then 00000000 else 01011111, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
66 => X"0" & X"F" & X"00" & X"5F" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0255@0043. if false then next else traceSpR
--  bus_state = 0000, if (1111) then 00000000 else 01110100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
67 => X"0" & X"F" & X"00" & X"74" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0256@0044. if false then next else traceRegP
--  bus_state = 0000, if (1111) then 00000000 else 01100110, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
68 => X"0" & X"F" & X"00" & X"66" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0258@0045. if false then next else traceSpR
--  bus_state = 0000, if (1111) then 00000000 else 01110100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
69 => X"0" & X"F" & X"00" & X"74" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0259@0046. if false then next else traceRegN
--  bus_state = 0000, if (1111) then 00000000 else 01101101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
70 => X"0" & X"F" & X"00" & X"6D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0261@0047. reg_trace <= ss_disable_char, if true then traceChar else 0x0D
--  bus_state = 0000, if (0000) then 01110111 else 00001101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
71 => X"0" & X"0" & X"77" & X"0D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0262@0048. reg_trace <= ss_disable_char, if true then traceChar else 0x0A
--  bus_state = 0000, if (0000) then 01110111 else 00001010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
72 => X"0" & X"0" & X"77" & X"0A" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0264@0049. reg_trace <= ss_enable_zero,if sync then fork else repeat
--  bus_state = 0000, if (0010) then 00000011 else 00000001, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 01, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
73 => X"0" & X"2" & X"03" & X"01" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "01" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0267@004A.traceReg0: reg_trace <= ss_disable_char, if true then traceChar else '0'
--  bus_state = 0000, if (0000) then 01110111 else 00110000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
74 => X"0" & X"0" & X"77" & X"30" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0268@004B. reg_trace <= ss_disable_char, if true then traceChar else '='
--  bus_state = 0000, if (0000) then 01110111 else 00111101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
75 => X"0" & X"0" & X"77" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0269@004C. sel_reg = zero, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1101
--  bus_state = 0000, if (0000) then 01110111 else 10001101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
76 => X"0" & X"0" & X"77" & X"8D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0270@004D. sel_reg = zero, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1100
--  bus_state = 0000, if (0000) then 01110111 else 10001100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
77 => X"0" & X"0" & X"77" & X"8C" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0271@004E. sel_reg = zero, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1011
--  bus_state = 0000, if (0000) then 01110111 else 10001011, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
78 => X"0" & X"0" & X"77" & X"8B" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0272@004F. sel_reg = zero, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1010
--  bus_state = 0000, if (0000) then 01110111 else 10001010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
79 => X"0" & X"0" & X"77" & X"8A" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0273@0050. if false then next else return
--  bus_state = 0000, if (1111) then 00000000 else 00000010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
80 => X"0" & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0275@0051.traceReg1: reg_trace <= ss_disable_char, if true then traceChar else '1'
--  bus_state = 0000, if (0000) then 01110111 else 00110001, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
81 => X"0" & X"0" & X"77" & X"31" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0276@0052. reg_trace <= ss_disable_char, if true then traceChar else '='
--  bus_state = 0000, if (0000) then 01110111 else 00111101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
82 => X"0" & X"0" & X"77" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0277@0053. sel_reg = one, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1101
--  bus_state = 0000, if (0000) then 01110111 else 10001101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 001, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
83 => X"0" & X"0" & X"77" & X"8D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"1" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0278@0054. sel_reg = one, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1100
--  bus_state = 0000, if (0000) then 01110111 else 10001100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 001, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
84 => X"0" & X"0" & X"77" & X"8C" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"1" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0279@0055. sel_reg = one, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1011
--  bus_state = 0000, if (0000) then 01110111 else 10001011, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 001, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
85 => X"0" & X"0" & X"77" & X"8B" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"1" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0280@0056. sel_reg = one, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1010
--  bus_state = 0000, if (0000) then 01110111 else 10001010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 001, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
86 => X"0" & X"0" & X"77" & X"8A" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"1" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0281@0057. if false then next else return
--  bus_state = 0000, if (1111) then 00000000 else 00000010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
87 => X"0" & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0283@0058.traceReg2: reg_trace <= ss_disable_char, if true then traceChar else '2'
--  bus_state = 0000, if (0000) then 01110111 else 00110010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
88 => X"0" & X"0" & X"77" & X"32" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0284@0059. reg_trace <= ss_disable_char, if true then traceChar else '='
--  bus_state = 0000, if (0000) then 01110111 else 00111101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
89 => X"0" & X"0" & X"77" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0285@005A. sel_reg = two, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1101
--  bus_state = 0000, if (0000) then 01110111 else 10001101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 010, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
90 => X"0" & X"0" & X"77" & X"8D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"2" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0286@005B. sel_reg = two, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1100
--  bus_state = 0000, if (0000) then 01110111 else 10001100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 010, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
91 => X"0" & X"0" & X"77" & X"8C" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"2" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0287@005C. sel_reg = two, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1011
--  bus_state = 0000, if (0000) then 01110111 else 10001011, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 010, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
92 => X"0" & X"0" & X"77" & X"8B" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"2" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0288@005D. sel_reg = two, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1010
--  bus_state = 0000, if (0000) then 01110111 else 10001010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 010, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
93 => X"0" & X"0" & X"77" & X"8A" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"2" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0289@005E. if false then next else return
--  bus_state = 0000, if (1111) then 00000000 else 00000010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
94 => X"0" & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0291@005F.traceRegX: reg_trace <= ss_disable_char, if true then traceChar else 'X'
--  bus_state = 0000, if (0000) then 01110111 else 01011000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
95 => X"0" & X"0" & X"77" & X"58" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0292@0060. reg_trace <= ss_disable_char, if true then traceChar else '='
--  bus_state = 0000, if (0000) then 01110111 else 00111101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
96 => X"0" & X"0" & X"77" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0293@0061. sel_reg = x, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1101
--  bus_state = 0000, if (0000) then 01110111 else 10001101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 011, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
97 => X"0" & X"0" & X"77" & X"8D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"3" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0294@0062. sel_reg = x, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1100
--  bus_state = 0000, if (0000) then 01110111 else 10001100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 011, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
98 => X"0" & X"0" & X"77" & X"8C" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"3" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0295@0063. sel_reg = x, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1011
--  bus_state = 0000, if (0000) then 01110111 else 10001011, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 011, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
99 => X"0" & X"0" & X"77" & X"8B" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"3" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0296@0064. sel_reg = x, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1010
--  bus_state = 0000, if (0000) then 01110111 else 10001010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 011, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
100 => X"0" & X"0" & X"77" & X"8A" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"3" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0297@0065. if false then next else return
--  bus_state = 0000, if (1111) then 00000000 else 00000010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
101 => X"0" & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0299@0066.traceRegP: reg_trace <= ss_disable_char, if true then traceChar else 'P'
--  bus_state = 0000, if (0000) then 01110111 else 01010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
102 => X"0" & X"0" & X"77" & X"50" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0300@0067. reg_trace <= ss_disable_char, if true then traceChar else '='
--  bus_state = 0000, if (0000) then 01110111 else 00111101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
103 => X"0" & X"0" & X"77" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0301@0068. sel_reg = p, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1101
--  bus_state = 0000, if (0000) then 01110111 else 10001101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 101, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
104 => X"0" & X"0" & X"77" & X"8D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"5" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0302@0069. sel_reg = p, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1100
--  bus_state = 0000, if (0000) then 01110111 else 10001100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 101, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
105 => X"0" & X"0" & X"77" & X"8C" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"5" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0303@006A. sel_reg = p, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1011
--  bus_state = 0000, if (0000) then 01110111 else 10001011, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 101, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
106 => X"0" & X"0" & X"77" & X"8B" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"5" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0304@006B. sel_reg = p, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1010
--  bus_state = 0000, if (0000) then 01110111 else 10001010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 101, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
107 => X"0" & X"0" & X"77" & X"8A" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"5" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0305@006C. if false then next else return
--  bus_state = 0000, if (1111) then 00000000 else 00000010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
108 => X"0" & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0307@006D.traceRegN: reg_trace <= ss_disable_char, if true then traceChar else 'N'
--  bus_state = 0000, if (0000) then 01110111 else 01001110, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
109 => X"0" & X"0" & X"77" & X"4E" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0308@006E. reg_trace <= ss_disable_char, if true then traceChar else '='
--  bus_state = 0000, if (0000) then 01110111 else 00111101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
110 => X"0" & X"0" & X"77" & X"3D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0309@006F. sel_reg = n, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1101
--  bus_state = 0000, if (0000) then 01110111 else 10001101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
111 => X"0" & X"0" & X"77" & X"8D" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0310@0070. sel_reg = n, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1100
--  bus_state = 0000, if (0000) then 01110111 else 10001100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
112 => X"0" & X"0" & X"77" & X"8C" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0311@0071. sel_reg = n, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1011
--  bus_state = 0000, if (0000) then 01110111 else 10001011, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
113 => X"0" & X"0" & X"77" & X"8B" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0312@0072. sel_reg = n, reg_trace <= ss_disable_char, if true then traceChar else 0b1000_1010
--  bus_state = 0000, if (0000) then 01110111 else 10001010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
114 => X"0" & X"0" & X"77" & X"8A" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0313@0073. if false then next else return
--  bus_state = 0000, if (1111) then 00000000 else 00000010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
115 => X"0" & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0315@0074.traceSpR: reg_trace <= ss_disable_char, if true then traceChar else ' '
--  bus_state = 0000, if (0000) then 01110111 else 00100000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
116 => X"0" & X"0" & X"77" & X"20" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0316@0075. reg_trace <= ss_disable_char, if true then traceChar else 'R'
--  bus_state = 0000, if (0000) then 01110111 else 01010010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 11, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
117 => X"0" & X"0" & X"77" & X"52" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "11" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0317@0076. if false then next else return
--  bus_state = 0000, if (1111) then 00000000 else 00000010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
118 => X"0" & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0319@0077.traceChar: if traceReady then next else repeat
--  bus_state = 0000, if (1110) then 00000000 else 00000001, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
119 => X"0" & X"E" & X"00" & X"01" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0320@0078. reg_trace <= ss_disable_zero, if false then next else return
--  bus_state = 0000, if (1111) then 00000000 else 00000010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 10, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
120 => X"0" & X"F" & X"00" & X"02" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "10" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0323@0079.XNOP: reg_extend <= zero, if false then next else NOP
--  bus_state = 0000, if (1111) then 00000000 else 10100101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
121 => X"0" & X"F" & X"00" & X"A5" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0329@007A.LDN: bus_state = exec_memread, sel_reg = n, alu_f = pass_s, alu_s = bus, reg_d <= alu_y,if continue then fetch else dma_or_int
--  bus_state = 0001, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
122 => X"1" & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "00" & O"7" & '0' & X"0",

-- L0333@007B.IDL: if true then next else next
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
123 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0335@007C. if continue then IDL else dma_or_int
--  bus_state = 0000, if (0110) then 01111011 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
124 => X"0" & X"6" & X"7B" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0339@007D.INC: sel_reg = n, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
125 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0343@007E.DEC: sel_reg = n, reg_r <= r_minus_one,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 011, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
126 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"3" & "00" & "00" & O"0" & '0' & X"0",

-- L0347@007F.SBRANCH: bus_state = exec_memread, sel_reg = p, alu_f = pass_s, alu_s = bus, reg_b <= alu_y,if cond_3X then sbranch2 else next
--  bus_state = 0001, if (0011) then 10000001 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
127 => X"1" & X"3" & X"81" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"0" & "00" & "00" & O"7" & '0' & X"0",

-- L0351@0080.SKIP: sel_reg = p, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
128 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0354@0081.sbranch2: sel_reg = p, reg_r <= rhi_ylo, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 101, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
129 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"5" & "10" & "00" & O"3" & '0' & X"0",

-- L0358@0082.LDA: bus_state = exec_memread, sel_reg = n, alu_f = pass_s, alu_s = bus, reg_d <= alu_y, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0001, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
130 => X"1" & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0362@0083.STR: bus_state = exec_memwrite, sel_reg = n, alu_f = pass_r, alu_r = d,if continue then fetch else dma_or_int
--  bus_state = 0010, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 01, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
131 => X"2" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "01" & "00" & O"3" & '0' & X"0",

-- L0366@0084.OUT: bus_state = exec_iowrite, sel_reg = x, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0100, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
132 => X"4" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0370@0085.IRX: sel_reg = x, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
133 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0374@0086.INP: bus_state = exec_ioread, sel_reg = x, alu_f = pass_s, alu_s = bus, reg_d <= alu_y,if continue then fetch else dma_or_int
--  bus_state = 0011, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
134 => X"3" & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"0" & "00" & "00" & O"7" & '0' & X"0",

-- L0378@0087.EXTEND: if mode_1805 then next else NOP
--  bus_state = 0000, if (0001) then 00000000 else 10100101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
135 => X"0" & X"1" & X"00" & X"A5" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0380@0088. bus_state = fetch_memread, sel_reg = p, reg_in <= alu_y, alu_f = pass_s, alu_s = bus, reg_extend <= one,reg_r <= r_plus_one,if false then next else load_b
--  bus_state = 1000, if (1111) then 00000000 else 00000101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 1, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 10, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
136 => X"8" & X"F" & X"00" & X"05" & O"0" & "00" & "00" & "00" & "00" & "00" & '1' & "00" & "00" & "00" & "10" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0385@0089.RET: alu_f = pass_r, alu_r = b, reg_x <= alu_yhi, reg_p <= alu_ylo, reg_mie <= enable,sel_reg = x, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 10, reg_p <= 10, reg_in <= 0, reg_q <= 00, reg_mie <= 01, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 010, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
137 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "10" & "10" & '0' & "00" & "01" & "00" & "00" & O"3" & O"2" & "10" & "00" & O"3" & '0' & X"0",

-- L0390@008A.DIS: alu_f = pass_r, alu_r = b, reg_x <= alu_yhi, reg_p <= alu_ylo, reg_mie <= disable,sel_reg = x, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 10, reg_p <= 10, reg_in <= 0, reg_q <= 00, reg_mie <= 10, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 010, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
138 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "10" & "10" & '0' & "00" & "10" & "00" & "00" & O"3" & O"2" & "10" & "00" & O"3" & '0' & X"0",

-- L0395@008B.LDXA: alu_f = pass_r, alu_r = b, reg_d <= alu_y
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 001, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
139 => X"0" & X"0" & X"00" & X"00" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "00" & O"3" & '0' & X"0",

-- L0397@008C. sel_reg = x, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
140 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0401@008D.STXD: bus_state = exec_memwrite, alu_f = pass_r, alu_r = d, sel_reg = x
--  bus_state = 0010, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 000, alu_r = 01, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
141 => X"2" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"0" & "01" & "00" & O"3" & '0' & X"0",

-- L0403@008E. sel_reg = x, reg_r <= r_minus_one,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 011, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
142 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "00" & "00" & O"0" & '0' & X"0",

-- L0408@008F.ADC: reg_extend <= zero, reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = b, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 11, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 000, reg_r <= 000, alu_r = 10, alu_s = 01, alu_f = 100, alu_cin = 1, ct_oper = 0000;
143 => X"0" & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"0" & O"0" & "10" & "01" & O"4" & '1' & X"0",

-- L0412@0090.SDB: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_ns, alu_r = b, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 11, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 10, alu_s = 01, alu_f = 101, alu_cin = 1, ct_oper = 0000;
144 => X"0" & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"5" & '1' & X"0",

-- L0416@0091.SHRC: reg_d <= shift_dn_df, reg_df <= d_lsb,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 010, reg_df <= 10, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
145 => X"0" & X"6" & X"04" & X"10" & O"2" & "10" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0421@0092.SMB: reg_extend <= zero, reg_df <= alu_cout, reg_d <= alu_y, alu_f = nr_plus_s, alu_r = b, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 11, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 000, reg_r <= 000, alu_r = 10, alu_s = 01, alu_f = 110, alu_cin = 1, ct_oper = 0000;
146 => X"0" & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"0" & O"0" & "10" & "01" & O"6" & '1' & X"0",

-- L0425@0093.SAV: bus_state = exec_memwrite, sel_reg = x, alu_f = pass_r, alu_r = t,if continue then fetch else dma_or_int
--  bus_state = 0010, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
147 => X"2" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"0" & "00" & "00" & O"3" & '0' & X"0",

-- L0429@0094.MARK: reg_t <= xp
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 10, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
148 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "10" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0431@0095. bus_state = exec_memwrite, reg_x <= p, sel_reg = two, alu_f = pass_r, alu_r = t, reg_r <= r_minus_one,if continue then fetch else dma_or_int
--  bus_state = 0010, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 11, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 010, reg_r <= 011, alu_r = 00, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
149 => X"2" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "11" & "00" & '0' & "00" & "00" & "00" & "00" & O"2" & O"3" & "00" & "00" & O"3" & '0' & X"0",

-- L0435@0096.REQ: reg_q <= zero,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 01, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
150 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "01" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0439@0097.SEQ: reg_q <= one,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 10, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
151 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "10" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0444@0098.ADCI: bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else ADC
--  bus_state = 0001, if (1111) then 00000000 else 10001111, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
152 => X"1" & X"F" & X"00" & X"8F" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0448@0099.SDBI: bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else SDB
--  bus_state = 0001, if (1111) then 00000000 else 10010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
153 => X"1" & X"F" & X"00" & X"90" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0452@009A.SHLC: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = d, alu_s = d, alu_cin = df,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 11, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 01, alu_s = 01, alu_f = 100, alu_cin = 1, ct_oper = 0000;
154 => X"0" & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "01" & "01" & O"4" & '1' & X"0",

-- L0457@009B.SMBI: bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else SMB
--  bus_state = 0001, if (1111) then 00000000 else 10010010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
155 => X"1" & X"F" & X"00" & X"92" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0461@009C.GLO: reg_d <= alu_y, alu_f = pass_s, alu_s = reg_lo, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 11, alu_f = 111, alu_cin = 0, ct_oper = 0000;
156 => X"0" & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "00" & "11" & O"7" & '0' & X"0",

-- L0465@009D.GHI: reg_d <= alu_y, alu_f = pass_r, alu_r = reg_hi, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 11, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
157 => X"0" & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "11" & "00" & O"3" & '0' & X"0",

-- L0469@009E.PLO: reg_r <= rhi_ylo, alu_f = pass_r, alu_r = d, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 101, alu_r = 01, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
158 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"5" & "01" & "00" & O"3" & '0' & X"0",

-- L0473@009F.PHI: reg_r <= yhi_rlo, alu_f = pass_r, alu_r = d, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 100, alu_r = 01, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
159 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"4" & "01" & "00" & O"3" & '0' & X"0",

-- L0477@00A0.LBRANCH: bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if cond_CX then next else SKIP
--  bus_state = 0001, if (1100) then 00000000 else 10000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
160 => X"1" & X"C" & X"00" & X"80" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0480@00A1. bus_state = exec_memread, sel_reg = p, reg_r <= rhi_ylo, alu_f = pass_s, alu_s = bus
--  bus_state = 0001, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 101, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
161 => X"1" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"5" & "00" & "00" & O"7" & '0' & X"0",

-- L0482@00A2. sel_reg = p, reg_r <= yhi_rlo, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 100, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
162 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"4" & "10" & "00" & O"3" & '0' & X"0",

-- L0492@00A3.LSKIP: if cond_CX then next else NOP
--  bus_state = 0000, if (1100) then 00000000 else 10100101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
163 => X"0" & X"C" & X"00" & X"A5" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0495@00A4.SKIP2: sel_reg = p, reg_r <= r_plus_one,if false then next else SKIP
--  bus_state = 0000, if (1111) then 00000000 else 10000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
164 => X"0" & X"F" & X"00" & X"80" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0499@00A5.NOP: if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
165 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0502@00A6.SEP: reg_p <= n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 01, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
166 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "01" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0506@00A7.SEX: reg_x <= n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 01, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
167 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "01" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0510@00A8.LDX: reg_d <= alu_y, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
168 => X"0" & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "00" & O"3" & '0' & X"0",

-- L0514@00A9.OR: reg_d <= alu_y, alu_f = ior, alu_r = b, alu_s = d,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 10, alu_s = 01, alu_f = 010, alu_cin = 0, ct_oper = 0000;
169 => X"0" & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"2" & '0' & X"0",

-- L0518@00AA.AND: reg_d <= alu_y, alu_f = and, alu_r = b, alu_s = d,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 10, alu_s = 01, alu_f = 001, alu_cin = 0, ct_oper = 0000;
170 => X"0" & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"1" & '0' & X"0",

-- L0522@00AB.XOR: reg_d <= alu_y, alu_f = xor, alu_r = b, alu_s = d,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 10, alu_s = 01, alu_f = 000, alu_cin = 0, ct_oper = 0000;
171 => X"0" & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"0" & '0' & X"0",

-- L0527@00AC.ADD: reg_extend <= zero, reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = b, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 11, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 000, reg_r <= 000, alu_r = 10, alu_s = 01, alu_f = 100, alu_cin = 0, ct_oper = 0000;
172 => X"0" & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"0" & O"0" & "10" & "01" & O"4" & '0' & X"0",

-- L0531@00AD.SD: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_ns, alu_r = b, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 11, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 10, alu_s = 01, alu_f = 101, alu_cin = 0, ct_oper = 0000;
173 => X"0" & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "10" & "01" & O"5" & '0' & X"0",

-- L0535@00AE.SHR: reg_d <= shift_dn_0, reg_df <= d_lsb,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 011, reg_df <= 10, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
174 => X"0" & X"6" & X"04" & X"10" & O"3" & "10" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0540@00AF.SM: reg_extend <= zero, reg_df <= alu_cout, reg_d <= alu_y, alu_f = nr_plus_s, alu_r = b, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 11, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 000, reg_r <= 000, alu_r = 10, alu_s = 01, alu_f = 110, alu_cin = 0, ct_oper = 0000;
175 => X"0" & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"0" & O"0" & "10" & "01" & O"6" & '0' & X"0",

-- L0544@00B0.LDI: bus_state = exec_memread, sel_reg = p, reg_d <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if continue then fetch else dma_or_int
--  bus_state = 0001, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
176 => X"1" & X"6" & X"04" & X"10" & O"1" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0548@00B1.ORI: bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else OR
--  bus_state = 0001, if (1111) then 00000000 else 10101001, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
177 => X"1" & X"F" & X"00" & X"A9" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0552@00B2.ANI: bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else AND
--  bus_state = 0001, if (1111) then 00000000 else 10101010, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
178 => X"1" & X"F" & X"00" & X"AA" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0556@00B3.XRI: bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else XOR
--  bus_state = 0001, if (1111) then 00000000 else 10101011, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
179 => X"1" & X"F" & X"00" & X"AB" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0561@00B4.ADI: bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else ADD
--  bus_state = 0001, if (1111) then 00000000 else 10101100, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
180 => X"1" & X"F" & X"00" & X"AC" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0565@00B5.SDI: bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else SD
--  bus_state = 0001, if (1111) then 00000000 else 10101101, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
181 => X"1" & X"F" & X"00" & X"AD" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0569@00B6.SHL: reg_df <= alu_cout, reg_d <= alu_y, alu_f = r_plus_s, alu_r = d, alu_s = d, alu_cin = f1_or_f0,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 001, reg_df <= 11, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 000, reg_r <= 000, alu_r = 01, alu_s = 01, alu_f = 100, alu_cin = 0, ct_oper = 0000;
182 => X"0" & X"6" & X"04" & X"10" & O"1" & "11" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "01" & "01" & O"4" & '0' & X"0",

-- L0574@00B7.SMI: bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one,if false then next else SM
--  bus_state = 0001, if (1111) then 00000000 else 10101111, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
183 => X"1" & X"F" & X"00" & X"AF" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0581@00B8.STPC: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
184 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0585@00B9.DTC: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
185 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0589@00BA.SPM2: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
186 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0593@00BB.SCM2: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
187 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0597@00BC.SPM1: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
188 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0601@00BD.SCM1: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
189 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0605@00BE.LDC: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
190 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0609@00BF.STM: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
191 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0613@00C0.GEC: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
192 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0617@00C1.ETQ: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
193 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0621@00C2.XIE: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
194 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0625@00C3.XID: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
195 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0629@00C4.CIE: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
196 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0633@00C5.CID: reg_extend <= zero, sel_reg = n,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
197 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "00" & O"0" & '0' & X"0",

-- L0637@00C6.DBNZ: reg_extend <= zero, sel_reg = n, reg_r <= r_minus_one,if alu16_zero then skip2 else next
--  bus_state = 0000, if (1011) then 11001010 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 011, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
198 => X"0" & X"B" & X"CA" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"3" & "00" & "00" & O"0" & '0' & X"0",

-- L0640@00C7. bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
--  bus_state = 0001, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
199 => X"1" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0642@00C8. bus_state = exec_memread, sel_reg = p, reg_r <= rhi_ylo, alu_f = pass_s, alu_s = bus
--  bus_state = 0001, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 101, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
200 => X"1" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"5" & "00" & "00" & O"7" & '0' & X"0",

-- L0644@00C9. sel_reg = p, reg_r <= yhi_rlo, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 100, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
201 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"4" & "10" & "00" & O"3" & '0' & X"0",

-- L0647@00CA.skip2: sel_reg = p, reg_r <= r_plus_one,if false then next else SKIP
--  bus_state = 0000, if (1111) then 00000000 else 10000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
202 => X"0" & X"F" & X"00" & X"80" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0651@00CB.BCI: reg_extend <= zero, bus_state = exec_memread, sel_reg = p, alu_f = pass_s, alu_s = bus, reg_b <= alu_y,if counterInt then sbranch2 else SKIP
--  bus_state = 0001, if (1010) then 10000001 else 10000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 101, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
203 => X"1" & X"A" & X"81" & X"80" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"5" & O"0" & "00" & "00" & O"7" & '0' & X"0",

-- L0655@00CC.BXI: reg_extend <= zero, bus_state = exec_memread, sel_reg = p, alu_f = pass_s, alu_s = bus, reg_b <= alu_y,if externalInt then sbranch2 else SKIP
--  bus_state = 0001, if (1001) then 10000001 else 10000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 101, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
204 => X"1" & X"9" & X"81" & X"80" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"5" & O"0" & "00" & "00" & O"7" & '0' & X"0",

-- L0659@00CD.RLXA: reg_extend <= zero, bus_state = exec_memread, sel_reg = x, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
--  bus_state = 0001, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 011, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
205 => X"1" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"3" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0661@00CE. bus_state = exec_memread, sel_reg = x, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
--  bus_state = 0001, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 01, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
206 => X"1" & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0663@00CF. sel_reg = n, reg_r <= yhi_rlo, alu_f = pass_r, alu_r = b, reg_b <= t
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 10, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 100, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
207 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "10" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"4" & "10" & "00" & O"3" & '0' & X"0",

-- L0665@00D0. sel_reg = n, reg_r <= rhi_ylo, alu_f = pass_r, alu_r = b,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 101, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
208 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"5" & "10" & "00" & O"3" & '0' & X"0",

-- L0669@00D1.DSAV: reg_extend <= zero, sel_reg = x, reg_r <= r_minus_one
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 011, reg_r <= 011, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
209 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"3" & O"3" & "00" & "00" & O"0" & '0' & X"0",

-- L0671@00D2. bus_state = exec_memwrite, sel_reg = x, alu_f = pass_r, alu_r = t, reg_r <= r_minus_one
--  bus_state = 0010, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 011, alu_r = 00, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
210 => X"2" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "00" & "00" & O"3" & '0' & X"0",

-- L0673@00D3. bus_state = exec_memwrite, sel_reg = x, alu_f = pass_r, alu_r = d, reg_r <= r_minus_one, reg_b <= df_d_dn
--  bus_state = 0010, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 11, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 011, alu_r = 01, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
211 => X"2" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "11" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "01" & "00" & O"3" & '0' & X"0",

-- L0675@00D4. bus_state = exec_memwrite, sel_reg = x, alu_f = pass_r, alu_r = b, reg_r <= r_minus_one,if continue then fetch else dma_or_int
--  bus_state = 0010, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 011, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
212 => X"2" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "10" & "00" & O"3" & '0' & X"0",

-- L0679@00D5.SCAL: reg_extend <= zero, sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 01, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 11, alu_f = 111, alu_cin = 0, ct_oper = 0000;
213 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "11" & O"7" & '0' & X"0",

-- L0681@00D6. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 11, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
214 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "11" & "00" & O"3" & '0' & X"0",

-- L0683@00D7. bus_state = exec_memwrite, sel_reg = x, alu_f = pass_r, alu_r = t, reg_r <= r_minus_one
--  bus_state = 0010, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 011, alu_r = 00, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
215 => X"2" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "00" & "00" & O"3" & '0' & X"0",

-- L0685@00D8. bus_state = exec_memwrite, sel_reg = x, alu_f = pass_r, alu_r = b, reg_r <= r_minus_one
--  bus_state = 0010, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 011, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
216 => X"2" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "10" & "00" & O"3" & '0' & X"0",

-- L0687@00D9. sel_reg = p, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 01, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 000, alu_r = 00, alu_s = 11, alu_f = 111, alu_cin = 0, ct_oper = 0000;
217 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"0" & "00" & "11" & O"7" & '0' & X"0",

-- L0689@00DA. sel_reg = p, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 000, alu_r = 11, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
218 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"0" & "11" & "00" & O"3" & '0' & X"0",

-- L0691@00DB. sel_reg = n, reg_r <= b_t
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 110, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
219 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"6" & "00" & "00" & O"0" & '0' & X"0",

-- L0693@00DC. bus_state = exec_memread, sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
--  bus_state = 0001, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 01, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
220 => X"1" & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0695@00DD. bus_state = exec_memread, sel_reg = n, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
--  bus_state = 0001, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
221 => X"1" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0697@00DE. sel_reg = p, reg_r <= b_t,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 110, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
222 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"6" & "00" & "00" & O"0" & '0' & X"0",

-- L0701@00DF.SRET: reg_extend <= zero, sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 01, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 11, alu_f = 111, alu_cin = 0, ct_oper = 0000;
223 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "11" & O"7" & '0' & X"0",

-- L0703@00E0. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 11, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
224 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "11" & "00" & O"3" & '0' & X"0",

-- L0705@00E1. sel_reg = x, reg_r <= r_plus_one
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
225 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"0" & '0' & X"0",

-- L0707@00E2. sel_reg = p, reg_r <= b_t
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 110, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
226 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"6" & "00" & "00" & O"0" & '0' & X"0",

-- L0709@00E3. bus_state = exec_memread, sel_reg = x, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
--  bus_state = 0001, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 01, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
227 => X"1" & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0711@00E4. bus_state = exec_memread, sel_reg = x, reg_b <= alu_y, alu_f = pass_s, alu_s = bus,if false then next else load_n
--  bus_state = 0001, if (1111) then 00000000 else 11101110, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 000, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
228 => X"1" & X"F" & X"00" & X"EE" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"0" & "00" & "00" & O"7" & '0' & X"0",

-- L0715@00E5.RSXD: reg_extend <= zero, sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 01, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 11, alu_f = 111, alu_cin = 0, ct_oper = 0000;
229 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "11" & O"7" & '0' & X"0",

-- L0717@00E6. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 11, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
230 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "11" & "00" & O"3" & '0' & X"0",

-- L0719@00E7. bus_state = exec_memwrite, sel_reg = x, alu_f = pass_r, alu_r = t, reg_r <= r_minus_one
--  bus_state = 0010, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 011, alu_r = 00, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
231 => X"2" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "00" & "00" & O"3" & '0' & X"0",

-- L0721@00E8. bus_state = exec_memwrite, sel_reg = x, alu_f = pass_r, alu_r = b, reg_r <= r_minus_one,if continue then fetch else dma_or_int
--  bus_state = 0010, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 011, alu_r = 10, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
232 => X"2" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"3" & "10" & "00" & O"3" & '0' & X"0",

-- L0725@00E9.RNX: reg_extend <= zero, sel_reg = n, reg_t <= alu_y, alu_f = pass_s, alu_s = reg_lo
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 01, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 100, reg_r <= 000, alu_r = 00, alu_s = 11, alu_f = 111, alu_cin = 0, ct_oper = 0000;
233 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"4" & O"0" & "00" & "11" & O"7" & '0' & X"0",

-- L0727@00EA. sel_reg = n, reg_b <= alu_y, alu_f = pass_r, alu_r = reg_hi
--  bus_state = 0000, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 000, alu_r = 11, alu_s = 00, alu_f = 011, alu_cin = 0, ct_oper = 0000;
234 => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"0" & "11" & "00" & O"3" & '0' & X"0",

-- L0729@00EB. sel_reg = x, reg_r <= b_t,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 011, reg_r <= 110, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
235 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"3" & O"6" & "00" & "00" & O"0" & '0' & X"0",

-- L0733@00EC.RLDI: reg_extend <= zero, bus_state = exec_memread, sel_reg = p, reg_b <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
--  bus_state = 0001, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 01, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 01, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
236 => X"1" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "01" & "00" & "00" & '0' & "00" & "00" & "00" & "01" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0735@00ED. bus_state = exec_memread, sel_reg = p, reg_t <= alu_y, alu_f = pass_s, alu_s = bus, reg_r <= r_plus_one
--  bus_state = 0001, if (0000) then 00000000 else 00000000, reg_d <= 000, reg_df <= 00, reg_t <= 01, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 101, reg_r <= 010, alu_r = 00, alu_s = 00, alu_f = 111, alu_cin = 0, ct_oper = 0000;
237 => X"1" & X"0" & X"00" & X"00" & O"0" & "00" & "01" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"5" & O"2" & "00" & "00" & O"7" & '0' & X"0",

-- L0737@00EE.load_n: sel_reg = n, reg_r <= b_t,if continue then fetch else dma_or_int
--  bus_state = 0000, if (0110) then 00000100 else 00010000, reg_d <= 000, reg_df <= 00, reg_t <= 00, reg_b <= 00, reg_x <= 00, reg_p <= 00, reg_in <= 0, reg_q <= 00, reg_mie <= 00, reg_trace <= 00, reg_extend <= 00, sel_reg = 100, reg_r <= 110, alu_r = 00, alu_s = 00, alu_f = 000, alu_cin = 0, ct_oper = 0000;
238 => X"0" & X"6" & X"04" & X"10" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"4" & O"6" & "00" & "00" & O"0" & '0' & X"0",

-- 34 location(s) in following ranges will be filled with default value
-- 0006 .. 000F
-- 0012 .. 0012
-- 0014 .. 0014
-- 0016 .. 0016
-- 0018 .. 0018
-- 001A .. 001A
-- 001C .. 001C
-- 001E .. 001E
-- 00EF .. 00FF

others => X"0" & X"0" & X"00" & X"00" & O"0" & "00" & "00" & "00" & "00" & "00" & '0' & "00" & "00" & "00" & "00" & O"0" & O"0" & "00" & "00" & O"0" & '0' & X"0"
);

end cdp180x_code;

