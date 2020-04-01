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

type code_memory is array(0 to 255) of std_logic_vector(71 downto 0);

signal ucode: std_logic_vector(71 downto 0);

--
-- L0008.seq_cond: 4 valuestrue, mode_1805, continue, cond_3X, tpa_wait, tpb_wait, fastMemAccess, dma_in, dma_out, interrupt, cond_a, cond_b, cond_CX, traceEnabled, traceReady, falsedefault true
--
alias uc_seq_cond: 	std_logic_vector(3 downto 0) is ucode(71 downto 68);
constant seq_cond_true: 	std_logic_vector(3 downto 0) := X"0";
constant seq_cond_mode_1805: 	std_logic_vector(3 downto 0) := X"1";
constant seq_cond_continue: 	std_logic_vector(3 downto 0) := X"2";
constant seq_cond_cond_3X: 	std_logic_vector(3 downto 0) := X"3";
constant seq_cond_tpa_wait: 	std_logic_vector(3 downto 0) := X"4";
constant seq_cond_tpb_wait: 	std_logic_vector(3 downto 0) := X"5";
constant seq_cond_fastMemAccess: 	std_logic_vector(3 downto 0) := X"6";
constant seq_cond_dma_in: 	std_logic_vector(3 downto 0) := X"7";
constant seq_cond_dma_out: 	std_logic_vector(3 downto 0) := X"8";
constant seq_cond_interrupt: 	std_logic_vector(3 downto 0) := X"9";
constant seq_cond_cond_a: 	std_logic_vector(3 downto 0) := X"A";
constant seq_cond_cond_b: 	std_logic_vector(3 downto 0) := X"B";
constant seq_cond_cond_CX: 	std_logic_vector(3 downto 0) := X"C";
constant seq_cond_traceEnabled: 	std_logic_vector(3 downto 0) := X"D";
constant seq_cond_traceReady: 	std_logic_vector(3 downto 0) := X"E";
constant seq_cond_false: 	std_logic_vector(3 downto 0) := X"F";

--
-- L0026.seq_then: 8 values next, repeat, return, fork, @ default next
--
alias uc_seq_then: 	std_logic_vector(7 downto 0) is ucode(67 downto 60);
constant seq_then_next: 	std_logic_vector(7 downto 0) := X"00";
constant seq_then_repeat: 	std_logic_vector(7 downto 0) := X"01";
constant seq_then_return: 	std_logic_vector(7 downto 0) := X"02";
constant seq_then_fork: 	std_logic_vector(7 downto 0) := X"03";
-- Jump targets allowed!

--
-- L0027.seq_else: 8 values next, repeat, return, fork, 0x00..0xFF, @ default next
--
alias uc_seq_else: 	std_logic_vector(7 downto 0) is ucode(59 downto 52);
constant seq_else_next: 	std_logic_vector(7 downto 0) := X"00";
constant seq_else_repeat: 	std_logic_vector(7 downto 0) := X"01";
constant seq_else_return: 	std_logic_vector(7 downto 0) := X"02";
constant seq_else_fork: 	std_logic_vector(7 downto 0) := X"03";
-- Values from X"00" to X"FF" allowed
-- Jump targets allowed!

--
-- L0030.reg_d: 2 values same, alu_y, shift_up, shift_dn default same
--
alias uc_reg_d: 	std_logic_vector(1 downto 0) is ucode(51 downto 50);
constant reg_d_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_d_alu_y: 	std_logic_vector(1 downto 0) := "01";
constant reg_d_shift_up: 	std_logic_vector(1 downto 0) := "10";
constant reg_d_shift_dn: 	std_logic_vector(1 downto 0) := "11";

--
-- L0031.reg_df: 2 values same, zero, one, alu_cout default same
--
alias uc_reg_df: 	std_logic_vector(1 downto 0) is ucode(49 downto 48);
constant reg_df_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_df_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_df_one: 	std_logic_vector(1 downto 0) := "10";
constant reg_df_alu_cout: 	std_logic_vector(1 downto 0) := "11";

--
-- L0032.reg_b: 3 values same, alu_y, bus, t, flags, xp, t default same
--
alias uc_reg_b: 	std_logic_vector(2 downto 0) is ucode(47 downto 45);
constant reg_b_same: 	std_logic_vector(2 downto 0) := "000";
constant reg_b_alu_y: 	std_logic_vector(2 downto 0) := "001";
constant reg_b_bus: 	std_logic_vector(2 downto 0) := "010";
constant reg_b_t: 	std_logic_vector(2 downto 0) := "011";
constant reg_b_flags: 	std_logic_vector(2 downto 0) := "100";
constant reg_b_xp: 	std_logic_vector(2 downto 0) := "101";
constant reg_b_t: 	std_logic_vector(2 downto 0) := "110";

--
-- L0033.reg_p: 2 values same, n, default same
--
alias uc_reg_p: 	std_logic_vector(1 downto 0) is ucode(44 downto 43);
constant reg_p_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_p_n: 	std_logic_vector(1 downto 0) := "01";
-- Values from "10" to "10" allowed

--
-- L0034.reg_x: 2 values same, n, default same
--
alias uc_reg_x: 	std_logic_vector(1 downto 0) is ucode(42 downto 41);
constant reg_x_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_x_n: 	std_logic_vector(1 downto 0) := "01";
-- Values from "10" to "10" allowed

--
-- L0035.reg_in: 1 values same, bus default same
--
alias uc_reg_in: 	std_logic is ucode(40);
constant reg_in_same: 	std_logic := '0';
constant reg_in_bus: 	std_logic := '1';

--
-- L0036.reg_t: 3 values same, xp, b default same
--
alias uc_reg_t: 	std_logic_vector(2 downto 0) is ucode(39 downto 37);
constant reg_t_same: 	std_logic_vector(2 downto 0) := "000";
constant reg_t_xp: 	std_logic_vector(2 downto 0) := "001";
constant reg_t_b: 	std_logic_vector(2 downto 0) := "010";

--
-- L0037.reg_q: 2 values same, zero, one default same
--
alias uc_reg_q: 	std_logic_vector(1 downto 0) is ucode(36 downto 35);
constant reg_q_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_q_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_q_one: 	std_logic_vector(1 downto 0) := "10";

--
-- L0038.reg_mie: 2 values same, enable, disable default same
--
alias uc_reg_mie: 	std_logic_vector(1 downto 0) is ucode(34 downto 33);
constant reg_mie_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_mie_enable: 	std_logic_vector(1 downto 0) := "01";
constant reg_mie_disable: 	std_logic_vector(1 downto 0) := "10";

--
-- L0041.reg_trace: 2 values same, ss_enable_zero, ss_disable_zero, ss_disable_chardefault same
--
alias uc_reg_trace: 	std_logic_vector(1 downto 0) is ucode(32 downto 31);
constant reg_trace_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_trace_ss_enable_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_trace_ss_disable_zero: 	std_logic_vector(1 downto 0) := "10";
constant reg_trace_ss_disable_char: 	std_logic_vector(1 downto 0) := "11";

--
-- L0047.reg_extend: 2 values same, zero, one default same
--
alias uc_reg_extend: 	std_logic_vector(1 downto 0) is ucode(30 downto 29);
constant reg_extend_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_extend_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_extend_one: 	std_logic_vector(1 downto 0) := "10";

--
-- L0048.reg_n: 2 values same, zero, n default same
--
alias uc_reg_n: 	std_logic_vector(1 downto 0) is ucode(28 downto 27);
constant reg_n_same: 	std_logic_vector(1 downto 0) := "00";
constant reg_n_zero: 	std_logic_vector(1 downto 0) := "01";
constant reg_n_n: 	std_logic_vector(1 downto 0) := "10";

--
-- L0049.reg_sample: 1 values same, capture default same
--
alias uc_reg_sample: 	std_logic is ucode(26);
constant reg_sample_same: 	std_logic := '0';
constant reg_sample_capture: 	std_logic := '1';

--
-- L0053.reg_lo: 1 values alu16_ylo, alu_y default alu16_ylo
--
alias uc_reg_lo: 	std_logic is ucode(25);
constant reg_lo_alu16_ylo: 	std_logic := '0';
constant reg_lo_alu_y: 	std_logic := '1';

--
-- L0054.reg_hi: 1 values alu16_yhi, alu_y default alu16_yhi
--
alias uc_reg_hi: 	std_logic is ucode(24);
constant reg_hi_alu16_yhi: 	std_logic := '0';
constant reg_hi_alu_y: 	std_logic := '1';

--
-- L0055.reg_addr: 3 values same, zero, one, two, x, n, p default zero
--
alias uc_reg_addr: 	std_logic_vector(2 downto 0) is ucode(23 downto 21);
constant reg_addr_same: 	std_logic_vector(2 downto 0) := "000";
constant reg_addr_zero: 	std_logic_vector(2 downto 0) := "001";
constant reg_addr_one: 	std_logic_vector(2 downto 0) := "010";
constant reg_addr_two: 	std_logic_vector(2 downto 0) := "011";
constant reg_addr_x: 	std_logic_vector(2 downto 0) := "100";
constant reg_addr_n: 	std_logic_vector(2 downto 0) := "101";
constant reg_addr_p: 	std_logic_vector(2 downto 0) := "110";

--
-- L0058.alu16_f: 2 values nop, clear, plus_one, minus_one default nop
--
alias uc_alu16_f: 	std_logic_vector(1 downto 0) is ucode(20 downto 19);
constant alu16_f_nop: 	std_logic_vector(1 downto 0) := "00";
constant alu16_f_clear: 	std_logic_vector(1 downto 0) := "01";
constant alu16_f_plus_one: 	std_logic_vector(1 downto 0) := "10";
constant alu16_f_minus_one: 	std_logic_vector(1 downto 0) := "11";

--
-- L0061.alu_r: 2 values zero, d, not_b, reg_hi default zero
--
alias uc_alu_r: 	std_logic_vector(1 downto 0) is ucode(18 downto 17);
constant alu_r_zero: 	std_logic_vector(1 downto 0) := "00";
constant alu_r_d: 	std_logic_vector(1 downto 0) := "01";
constant alu_r_not_b: 	std_logic_vector(1 downto 0) := "10";
constant alu_r_reg_hi: 	std_logic_vector(1 downto 0) := "11";

--
-- L0062.alu_s: 3 values zero, b, not_d, reg_lo default zero
--
alias uc_alu_s: 	std_logic_vector(2 downto 0) is ucode(16 downto 14);
constant alu_s_zero: 	std_logic_vector(2 downto 0) := "000";
constant alu_s_b: 	std_logic_vector(2 downto 0) := "001";
constant alu_s_not_d: 	std_logic_vector(2 downto 0) := "010";
constant alu_s_reg_lo: 	std_logic_vector(2 downto 0) := "011";

--
-- L0063.alu_f: 2 values ior, and, xor, adc default ior
--
alias uc_alu_f: 	std_logic_vector(1 downto 0) is ucode(13 downto 12);
constant alu_f_ior: 	std_logic_vector(1 downto 0) := "00";
constant alu_f_and: 	std_logic_vector(1 downto 0) := "01";
constant alu_f_xor: 	std_logic_vector(1 downto 0) := "10";
constant alu_f_adc: 	std_logic_vector(1 downto 0) := "11";

--
-- L0064.alu_cin: 2 values zero, one, reg_df default zero
--
alias uc_alu_cin: 	std_logic_vector(1 downto 0) is ucode(11 downto 10);
constant alu_cin_zero: 	std_logic_vector(1 downto 0) := "00";
constant alu_cin_one: 	std_logic_vector(1 downto 0) := "01";
constant alu_cin_reg_df: 	std_logic_vector(1 downto 0) := "10";

--
-- L0065.alu_mode: 2 values same, binary, decimal default binary
--
alias uc_alu_mode: 	std_logic_vector(1 downto 0) is ucode(9 downto 8);
constant alu_mode_same: 	std_logic_vector(1 downto 0) := "00";
constant alu_mode_binary: 	std_logic_vector(1 downto 0) := "01";
constant alu_mode_decimal: 	std_logic_vector(1 downto 0) := "10";

--
-- L0068.sc: 2 values sc_fetch, sc_execute, sc_dma, sc_interrupt default sc_execute
--
alias uc_sc: 	std_logic_vector(1 downto 0) is ucode(7 downto 6);
constant sc_sc_fetch: 	std_logic_vector(1 downto 0) := "00";
constant sc_sc_execute: 	std_logic_vector(1 downto 0) := "01";
constant sc_sc_dma: 	std_logic_vector(1 downto 0) := "10";
constant sc_sc_interrupt: 	std_logic_vector(1 downto 0) := "11";

--
-- L0069.tpa: 1 values 0, 1 default 0
--
alias uc_tpa: 	std_logic is ucode(5);
-- Values from '0' to '0' allowed
-- Values from '1' to '1' allowed

--
-- L0070.tpb: 1 values 0, 1 default 0
--
alias uc_tpb: 	std_logic is ucode(4);
-- Values from '0' to '0' allowed
-- Values from '1' to '1' allowed

--
-- L0071.mrd: 1 values 0, 1 default 1
--
alias uc_mrd: 	std_logic is ucode(3);
-- Values from '0' to '0' allowed
-- Values from '1' to '1' allowed

--
-- L0072.mwr: 1 values 0, 1 default 1
--
alias uc_mwr: 	std_logic is ucode(2);
-- Values from '0' to '0' allowed
-- Values from '1' to '1' allowed

--
-- L0073.amux: 1 values 0, 1 default 0
--
alias uc_amux: 	std_logic is ucode(1);
-- Values from '0' to '0' allowed
-- Values from '1' to '1' allowed

--
-- L0074.dataout: 1 values 0, 1 default 1
--
alias uc_dataout: 	std_logic is ucode(0);
-- Values from '0' to '0' allowed
-- Values from '1' to '1' allowed



constant microcode: code_memory := (
-- L0110@0000._reset: reg_q <= zero, reg_n <= zero, reg_trace <= ss_enable_zero
0 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "01" & "00" & "01" & "00" & "01" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0111@0001._reset1: reg_t <= xp
1 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "001" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0112@0002._reset2: reg_addr <= zero, reg_mie <= enable, reg_x <= zero, reg_p <= zero
2 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "01" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0113@0003._reset3: alu16_f = clear,  reg_hi <= alu16_yhi, reg_lo <= alu16_ylo
3 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "01" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0118@0004.fetch: sc = sc_fetch, amux = 1,   alu_mode <= binary, reg_addr <= p, reg_extend <= 0
4 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "00" & '0' & '0' & '1' & '1' & '1' & '1',

-- L0119@0005.fetch1: sc = sc_fetch, amux = 1, tpa = 1, mrd = 0,  if fastMemAccess then next else fetch6
5 => X"6" & X"00" & X"0A" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "00" & '1' & '0' & '0' & '1' & '1' & '1',

-- L0120@0006. sc = sc_fetch, amux = 1, tpa = 1, mrd = 0,  if tpa_wait then repeat else next
6 => X"4" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "00" & '1' & '0' & '0' & '1' & '1' & '1',

-- L0121@0007. sc = sc_fetch, amux = 1,  mrd = 0
7 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "00" & '0' & '0' & '0' & '1' & '1' & '1',

-- L0122@0008. sc = sc_fetch, amux = 0,  mrd = 0
8 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "00" & '0' & '0' & '0' & '1' & '0' & '1',

-- L0123@0009. sc = sc_fetch, amux = 0, tpb = 1, mrd = 0
9 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "00" & '0' & '1' & '0' & '1' & '0' & '1',

-- L0124@000A.fetch6: sc = sc_fetch, amux = 0, tpb = 1, mrd = 0,  reg_in <= bus, if tpb_wait then repeat else next
10 => X"5" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '1' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "00" & '0' & '1' & '0' & '1' & '0' & '1',

-- L0125@000B. sc = sc_fetch, amux = 0,  mrd = 0,  alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, reg_addr <= n, reg_sample <= capture, if traceEnabled then traceState else fork
11 => X"D" & X"31" & X"03" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "101" & "10" & "00" & "000" & "00" & "00" & "01" & "00" & '0' & '0' & '0' & '1' & '0' & '1',

-- L0130@000C.read_b: sc = sc_execute, amux = 1, reg_n <= zero
12 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "01" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '1' & '1',

-- L0131@000D. sc = sc_execute, amux = 1, tpa = 1, mrd = 0, if fastMemAccess then next else read_b6
13 => X"6" & X"00" & X"12" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '1' & '0' & '0' & '1' & '1' & '1',

-- L0132@000E. sc = sc_execute, amux = 1, tpa = 1, mrd = 0, if tpa_wait then repeat else next
14 => X"4" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '1' & '0' & '0' & '1' & '1' & '1',

-- L0133@000F. sc = sc_execute, amux = 1,  mrd = 0
15 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '0' & '1' & '1' & '1',

-- L0134@0010. sc = sc_execute, amux = 0,  mrd = 0
16 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '0' & '1' & '0' & '1',

-- L0135@0011. sc = sc_execute, amux = 0, tpb = 1, mrd = 0
17 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '1' & '0' & '1' & '0' & '1',

-- L0136@0012.read_b6: sc = sc_execute, amux = 0, tpb = 1, mrd = 0, reg_b <= bus, if tpb_wait then repeat else next
18 => X"5" & X"01" & X"00" & "00" & "00" & "010" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '1' & '0' & '1' & '0' & '1',

-- L0137@0013. sc = sc_execute, amux = 0,  mrd = 0, if false then next else return
19 => X"F" & X"00" & X"02" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '0' & '1' & '0' & '1',

-- L0142@0014.write_b: sc = sc_execute, amux = 1, reg_n <= zero
20 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "01" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '1' & '1',

-- L0143@0015. sc = sc_execute, amux = 1, tpa = 1, dataout = 0, if fastMemAccess then next else write_b6
21 => X"6" & X"00" & X"1A" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '1' & '0' & '1' & '1' & '1' & '0',

-- L0144@0016. sc = sc_execute, amux = 1, tpa = 1, dataout = 0, if tpa_wait then repeat else next
22 => X"4" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '1' & '0' & '1' & '1' & '1' & '0',

-- L0145@0017. sc = sc_execute, amux = 1,  dataout = 0, mwr = 0
23 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '0' & '1' & '0',

-- L0146@0018. sc = sc_execute, amux = 0,  dataout = 0, mwr = 0
24 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '0' & '0' & '0',

-- L0147@0019. sc = sc_execute, amux = 0, tpb = 1, dataout = 0, mwr = 0
25 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '1' & '1' & '0' & '0' & '0',

-- L0148@001A.write_b6: sc = sc_execute, amux = 0, tpb = 1, dataout = 0, mwr = 0, if tpb_wait then repeat else next
26 => X"5" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '1' & '1' & '0' & '0' & '0',

-- L0149@001B. sc = sc_execute, amux = 0,  dataout = 0, if false then next else return
27 => X"F" & X"00" & X"02" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '0',

-- L0154@001C.dma_or_int: reg_addr <= zero, if dma_in then dma_in else next
28 => X"7" & X"21" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0156@001D. reg_addr <= zero, if dma_out then dma_out else next
29 => X"8" & X"29" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0158@001E. if intreq then next else fetch
30 => X"0" & X"00" & X"04" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0160@001F.int_ack: sc = sc_interrupt, reg_t <= xp
31 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "001" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "11" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0162@0020. sc = sc_interrupt, reg_p <= 1, reg_x <= two, reg_mie <= 0, if false then next else fetch
32 => X"F" & X"00" & X"04" & "00" & "00" & "000" & "01" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "11" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0164@0021.dma_in: sc = sc_dma, amux = 1, reg_n <= zero
33 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "01" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '0' & '1' & '1' & '1' & '1',

-- L0165@0022. sc = sc_dma, amux = 1, tpa = 1, if fastMemAccess then next else dma_in6
34 => X"6" & X"00" & X"27" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '1' & '0' & '1' & '1' & '1' & '1',

-- L0166@0023. sc = sc_dma, amux = 1, tpa = 1, if tpa_wait then repeat else next
35 => X"4" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '1' & '0' & '1' & '1' & '1' & '1',

-- L0167@0024. sc = sc_dma, amux = 1,  mwr = 0
36 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '0' & '1' & '0' & '1' & '1',

-- L0168@0025. sc = sc_dma, amux = 0,  mwr = 0
37 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '0' & '1' & '0' & '0' & '1',

-- L0169@0026. sc = sc_dma, amux = 0, tpb = 1, mwr = 0
38 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '1' & '1' & '0' & '0' & '1',

-- L0170@0027.dma_in6: sc = sc_dma, amux = 0, tpb = 1, mwr = 0, reg_sample <= capture, if tpb_wait then repeat else next
39 => X"5" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '1' & '1' & '0' & '0' & '1',

-- L0171@0028. sc = sc_dma, amux = 0,  alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
40 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0173@0029.dma_out: sc = sc_dma, amux = 1, reg_n <= zero
41 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "01" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '0' & '1' & '1' & '1' & '1',

-- L0174@002A. sc = sc_dma, amux = 1, tpa = 1, mrd = 0, if fastMemAccess then next else dma_out6
42 => X"6" & X"00" & X"2F" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '1' & '0' & '0' & '1' & '1' & '1',

-- L0175@002B. sc = sc_dma, amux = 1, tpa = 1, mrd = 0, if tpa_wait then repeat else next
43 => X"4" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '1' & '0' & '0' & '1' & '1' & '1',

-- L0176@002C. sc = sc_dma, amux = 1,  mrd = 0
44 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '0' & '0' & '1' & '1' & '1',

-- L0177@002D. sc = sc_dma, amux = 0,  mrd = 0
45 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '0' & '0' & '1' & '0' & '1',

-- L0178@002E. sc = sc_dma, amux = 0, tpb = 1, mrd = 0
46 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '1' & '0' & '1' & '0' & '1',

-- L0179@002F.dma_out6: sc = sc_dma, amux = 0, tpb = 1, mrd = 0, if tpb_wait then repeat else next
47 => X"5" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '1' & '0' & '1' & '0' & '1',

-- L0180@0030. sc = sc_dma, amux = 0,  mrd = 0, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
48 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "00" & "000" & "00" & "00" & "01" & "10" & '0' & '0' & '0' & '1' & '0' & '1',

-- L0189@0031.traceState: reg_trace <= ss_disable_char, if true then traceChar else 'D'
49 => X"0" & X"5E" & X"44" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0190@0032. reg_trace <= ss_disable_char, if true then traceChar else '= '
50 => X"0" & X"5E" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0191@0033. if false then next else traceB
51 => X"F" & X"00" & X"59" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0193@0034. reg_b <= flags, reg_trace <= ss_disable_char, if true then traceChar else 'F'
52 => X"0" & X"5E" & X"46" & "00" & "00" & "100" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0194@0035. reg_trace <= ss_disable_char, if true then traceChar else 'L'
53 => X"0" & X"5E" & X"4C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0195@0036. if false then next else traceB
54 => X"F" & X"00" & X"59" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0197@0037. reg_b <= xp, reg_trace <= ss_disable_char, if true then traceChar else 'X'
55 => X"0" & X"5E" & X"58" & "00" & "00" & "101" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0198@0038. reg_trace <= ss_disable_char, if true then traceChar else 'P'
56 => X"0" & X"5E" & X"50" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0199@0039. if false then next else traceB
57 => X"F" & X"00" & X"59" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0201@003A. reg_b <= in, reg_trace <= ss_disable_char, if true then traceChar else 'I'
58 => X"0" & X"5E" & X"49" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0202@003B. reg_trace <= ss_disable_char, if true then traceChar else 'N'
59 => X"0" & X"5E" & X"4E" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0203@003C. if false then next else traceB
60 => X"F" & X"00" & X"59" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0205@003D. reg_addr <= zero, reg_trace <= ss_disable_char, if true then traceChar else 'R'
61 => X"0" & X"5E" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0206@003E. reg_trace <= ss_disable_char, if true then traceChar else '0'
62 => X"0" & X"5E" & X"30" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0207@003F. if false then next else traceReg
63 => X"F" & X"00" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0209@0040. reg_addr <= one, reg_trace <= ss_disable_char, if true then traceChar else 'R'
64 => X"0" & X"5E" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "010" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0210@0041. reg_trace <= ss_disable_char, if true then traceChar else '1'
65 => X"0" & X"5E" & X"31" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0211@0042. if false then next else traceReg
66 => X"F" & X"00" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0213@0043. reg_addr <= two, reg_trace <= ss_disable_char, if true then traceChar else 'R'
67 => X"0" & X"5E" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "011" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0214@0044. reg_trace <= ss_disable_char, if true then traceChar else '2'
68 => X"0" & X"5E" & X"32" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0215@0045. if false then next else traceReg
69 => X"F" & X"00" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0217@0046. reg_addr <= x, reg_trace <= ss_disable_char, if true then traceChar else 'R'
70 => X"0" & X"5E" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0218@0047. reg_trace <= ss_disable_char, if true then traceChar else 'X'
71 => X"0" & X"5E" & X"58" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0219@0048. if false then next else traceReg
72 => X"F" & X"00" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0221@0049. reg_addr <= p, reg_trace <= ss_disable_char, if true then traceChar else 'R'
73 => X"0" & X"5E" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0222@004A. reg_trace <= ss_disable_char, if true then traceChar else 'P'
74 => X"0" & X"5E" & X"50" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0223@004B. if false then next else traceReg
75 => X"F" & X"00" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0225@004C. reg_addr <= n, reg_trace <= ss_disable_char, if true then traceChar else 'R'
76 => X"0" & X"5E" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "101" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0226@004D. reg_trace <= ss_disable_char, if true then traceChar else 'P'
77 => X"0" & X"5E" & X"50" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0227@004E. if false then next else traceReg
78 => X"F" & X"00" & X"52" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0229@004F. reg_trace <= ss_disable_char, if true then traceChar else 0x0D
79 => X"0" & X"5E" & X"0D" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0230@0050. reg_trace <= ss_disable_char, if true then traceChar else 0x0A
80 => X"0" & X"5E" & X"0A" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0232@0051. reg_trace <= ss_enable_zero, if false then next else fork
81 => X"F" & X"00" & X"03" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "01" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0234@0052.traceReg: reg_trace <= ss_disable_char, if true then traceChar else '= '
82 => X"0" & X"5E" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0235@0053. alu_f = ior, alu_r = reg_hi, alu_s = zero, reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
83 => X"0" & X"5E" & X"81" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "11" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0236@0054. alu_f = ior, alu_r = reg_hi, alu_s = zero, reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
84 => X"0" & X"5E" & X"80" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "11" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0237@0055. alu_f = ior, alu_r = zero, alu_s = reg_lo, reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
85 => X"0" & X"5E" & X"81" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "011" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0238@0056. alu_f = ior, alu_r = zero, alu_s = reg_lo, reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
86 => X"0" & X"5E" & X"80" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "011" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0239@0057. reg_trace <= ss_disable_char, if true then traceChar else ' '
87 => X"0" & X"5E" & X"20" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0240@0058. if false then next else return
88 => X"F" & X"00" & X"02" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0242@0059.traceB: reg_trace <= ss_disable_char, if true then traceChar else '= '
89 => X"0" & X"5E" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0243@005A. alu_f = ior, alu_r = zero, alu_s = b, reg_trace <= ss_disable_char, if true then traceChar else 0b10000_001
90 => X"0" & X"5E" & X"81" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0244@005B. alu_f = ior, alu_r = zero, alu_s = b, reg_trace <= ss_disable_char, if true then traceChar else 0b10000_000
91 => X"0" & X"5E" & X"80" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0245@005C. reg_trace <= ss_disable_char, if true then traceChar else ' '
92 => X"0" & X"5E" & X"20" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "11" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0246@005D. if false then next else return
93 => X"F" & X"00" & X"02" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0248@005E.traceChar: if traceReady then next else repeat
94 => X"E" & X"00" & X"01" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0249@005F. reg_trace <= ss_disable_zero, if false then next else return
95 => X"F" & X"00" & X"02" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "10" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0255@0060.LDN: if false then next else read_b
96 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0257@0061. reg_d <= alu_y, alu_f = ior, alu_r = zero, alu_s = b, if continue then fetch else dma_or_int
97 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0261@0062.IDL: reg_sample <= capture
98 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0263@0063. if continue then IDL else dma_or_int
99 => X"2" & X"62" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0266@0064.INC: alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
100 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0270@0065.DEC: alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
101 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "11" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0274@0066.SBRANCH: reg_addr <= p, if cond_3X then next else INC
102 => X"3" & X"00" & X"64" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0277@0067. if false then next else read_b
103 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0279@0068.sbranch2: reg_lo <= alu_y, alu_f = ior, alu_r = zero, alu_s = b, if continue then fetch else dma_or_int
104 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '1' & '0' & "001" & "00" & "00" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0283@0069.LDA: if false then next else read_b
105 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0285@006A. reg_d <= alu_y, alu_f = ior, alu_r = zero, alu_s = b, if false then next else INC
106 => X"F" & X"00" & X"64" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0289@006B.STR: reg_b <= alu_y, alu_f = ior, alu_r = d, alu_s = zero, if false then next else write_b
107 => X"F" & X"00" & X"14" & "00" & "00" & "001" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "01" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0291@006C. if continue then fetch else dma_or_int
108 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0294@006D.OUT: sc = sc_execute, amux = 1, reg_addr <= x, reg_n <= n
109 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "10" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '1' & '1',

-- L0295@006E. sc = sc_execute, amux = 1, tpa = 1, mrd = 0, if fastMemAccess then next else out6
110 => X"6" & X"00" & X"73" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '1' & '0' & '0' & '1' & '1' & '1',

-- L0296@006F. sc = sc_execute, amux = 1, tpa = 1, mrd = 0, if tpa_wait then repeat else next
111 => X"4" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '1' & '0' & '0' & '1' & '1' & '1',

-- L0297@0070. sc = sc_execute, amux = 1,  mrd = 0
112 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '0' & '1' & '1' & '1',

-- L0298@0071. sc = sc_execute, amux = 0,  mrd = 0
113 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '0' & '1' & '0' & '1',

-- L0299@0072. sc = sc_execute, amux = 0, tpb = 1, mrd = 0
114 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '1' & '0' & '1' & '0' & '1',

-- L0300@0073.out6: sc = sc_execute, amux = 0, tpb = 1, mrd = 0, if tpb_wait then repeat else next
115 => X"5" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '1' & '0' & '1' & '0' & '1',

-- L0301@0074. sc = sc_execute, amux = 0,  mrd = 0, reg_n <= zero, if false then next else INC
116 => X"F" & X"00" & X"64" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "01" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '0' & '1' & '0' & '1',

-- L0305@0075.IRX: reg_addr <= x, if false then next else INC
117 => X"F" & X"00" & X"64" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0309@0076.INP: sc = sc_execute, amux = 1, reg_addr <= x, reg_n <= n, reg_enableoutput <= false
118 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "10" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '1' & '1',

-- L0310@0077. sc = sc_execute, amux = 1, tpa = 1, if fastMemAccess then next else write_b6
119 => X"6" & X"00" & X"1A" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '1' & '0' & '1' & '1' & '1' & '1',

-- L0311@0078. sc = sc_execute, amux = 1, tpa = 1, if tpa_wait then repeat else next
120 => X"4" & X"01" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '1' & '0' & '1' & '1' & '1' & '1',

-- L0312@0079. sc = sc_execute, amux = 1,  mwr = 0
121 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '0' & '1' & '1',

-- L0313@007A. sc = sc_execute, amux = 0,  mwr = 0
122 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '0' & '0' & '1',

-- L0314@007B. sc = sc_execute, amux = 0, tpb = 1, mwr = 0
123 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '1' & '1' & '0' & '0' & '1',

-- L0315@007C.inp6: sc = sc_execute, amux = 0, tpb = 1, mwr = 0, reg_b <= bus, if tpb_wait then repeat else next
124 => X"5" & X"01" & X"00" & "00" & "00" & "010" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '1' & '1' & '0' & '0' & '1',

-- L0316@007D. sc = sc_execute, amux = 0,  reg_n <= zero, reg_d <= alu_y, alu_f = ior, alu_r = zero, alu_s = b, if continue then fetch else dma_or_int
125 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "01" & '0' & '0' & '0' & "001" & "00" & "00" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0320@007E.EXTEND: if mode_1805 then next else NOP
126 => X"1" & X"00" & X"A7" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0322@007F. sc = sc_fetch, amux = 1, alu_mode <= decimal, reg_addr <= p, reg_extend <= one, if false then next else fetch1
127 => X"F" & X"00" & X"05" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "10" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "10" & "00" & '0' & '0' & '1' & '1' & '1' & '1',

-- L0326@0080.RET: reg_addr <= x, if false then next else read_b
128 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0328@0081. reg_x <= b_hi, reg_p <= b_lo, reg_mie <= one, if false then next else INC
129 => X"F" & X"00" & X"64" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0331@0082.DIS: reg_addr <= x, if false then next else read_b
130 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0333@0083. reg_x <= b_hi, reg_p <= b_lo, reg_mie <= zero, if false then next else INC
131 => X"F" & X"00" & X"64" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0336@0084.LDXA: reg_addr <= x, if false then next else read_b
132 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0338@0085. reg_d <= alu_y, alu_f = ior, alu_r = zero, alu_s = b, if false then next else INC
133 => X"F" & X"00" & X"64" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0342@0086.STXD: reg_addr <= x, reg_b <= alu_y, alu_f = ior, alu_r = d, alu_s = zero, if false then next else write_b
134 => X"F" & X"00" & X"14" & "00" & "00" & "001" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "01" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0344@0087. alu16_f = minus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
135 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "11" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0347@0088.ADC: reg_addr <= x, if false then next else read_b
136 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0349@0089. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = d, alu_s = b, alu_cin = df, if continue then fetch else dma_or_int
137 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "01" & "001" & "11" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0353@008A.SDB: reg_addr <= x, if false then next else read_b
138 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0355@008B. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = b, alu_s = notd, alu_cin = df, if continue then fetch else dma_or_int
139 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "11" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0359@008C.SHRC: reg_d <= shift_dn, reg_df <= d0, shift_in = df, if continue then fetch else dma_or_int
140 => X"2" & X"04" & X"1C" & "11" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0363@008D.SMB: reg_addr <= x, if false then next else read_b
141 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0365@008E. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = d, alu_s = notb, alu_cin = df, if continue then fetch else dma_or_int
142 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "01" & "000" & "11" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0369@008F.SAV: reg_addr <= x, reg_b <= t, if false then next else write_b
143 => X"F" & X"00" & X"14" & "00" & "00" & "011" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0371@0090. if continue then fetch else dma_or_int
144 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0374@0091.MARK: reg_addr <= two, reg_t <= xp
145 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "001" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "011" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0376@0092. reg_b <= t, if false then next else write_b
146 => X"F" & X"00" & X"14" & "00" & "00" & "011" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0378@0093. reg_x <= p, if false then next else DEC
147 => X"F" & X"00" & X"65" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0381@0094.REQ: reg_q <= zero, if continue then fetch else dma_or_int
148 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "01" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0385@0095.SEQ: reg_q <= one, if continue then fetch else dma_or_int
149 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "10" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0389@0096.ADCI: reg_addr <= p, if false then next else read_b
150 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0391@0097. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = d, alu_s = b, alu_cin = df, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
151 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "01" & "001" & "11" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0397@0098.SDBI: reg_addr <= p, if false then next else read_b
152 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0399@0099. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = b, alu_s = notd, alu_cin = df, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
153 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "00" & "000" & "11" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0405@009A.SHLC: reg_d <= shift_up, reg_df <= d7, shift_in = df, if continue then fetch else dma_or_int
154 => X"2" & X"04" & X"1C" & "10" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0408@009B.SMBI: reg_addr <= p, if false then next else read_b
155 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0410@009C. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = d, alu_s = notb, alu_cin = df, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
156 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "01" & "000" & "11" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0415@009D.GLO: reg_d <= alu_y, alu_f = ior, alu_r = zero, alu_s = reg_lo, if continue then fetch else dma_or_int
157 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "011" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0419@009E.GHI: reg_d <= alu_y, alu_f = ior, alu_r = reg_hi, alu_s = zero, if continue then fetch else dma_or_int
158 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "11" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0423@009F.PLO: reg_lo <= alu_y, alu_f = ior, alu_r = d, alu_s = zero, if continue then fetch else dma_or_int
159 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '1' & '0' & "001" & "00" & "01" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0427@00A0.PHI: reg_hi <= alu_y, alu_f = ior, alu_r = d, alu_s = zero, if continue then fetch else dma_or_int
160 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '1' & "001" & "00" & "01" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0431@00A1.LBRANCH: reg_addr <= p; if cond_CX then next else inc2
161 => X"0" & X"00" & X"00" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0433@00A2. if false then next else read_b
162 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0435@00A3. reg_t <= b, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if false then next else read_b
163 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "010" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0437@00A4. reg_lo <= alu_y, alu_f = ior, alu_r = zero, alu_s = b, reg_b <= t
164 => X"0" & X"00" & X"00" & "00" & "00" & "011" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '1' & '0' & "001" & "00" & "00" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0439@00A5. reg_hi <= alu_y, alu_f = ior, alu_r = zero, alu_s = b, if continue then fetch else dma_or_int
165 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '1' & "001" & "00" & "00" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0441@00A6.inc2: alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if false then next else INC
166 => X"F" & X"00" & X"64" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0445@00A7.NOP: if continue then fetch else dma_or_int
167 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0448@00A8.SEP: reg_p <= n, if continue then fetch else dma_or_int
168 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "01" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0452@00A9.SEX: reg_x <= n, if continue then fetch else dma_or_int
169 => X"2" & X"04" & X"1C" & "00" & "00" & "000" & "00" & "01" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0456@00AA.LDX: reg_addr <= x, if false then next else read_b
170 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0458@00AB. reg_d <= alu_y, alu_f = ior, alu_r = zero, alu_s = b, if continue then fetch else dma_or_int
171 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0462@00AC.OR: reg_addr <= x, if false then next else read_b
172 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0464@00AD. reg_d <= alu_y, alu_f = ior, alu_r = d, alu_s = b, if continue then fetch else dma_or_int
173 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "01" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0468@00AE.AND: reg_addr <= x, if false then next else read_b
174 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0470@00AF. reg_d <= alu_y, alu_f = and, alu_r = d, alu_s = b, if continue then fetch else dma_or_int
175 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "01" & "001" & "01" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0474@00B0.XOR: reg_addr <= x, if false then next else read_b
176 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0476@00B1. reg_d <= alu_y, alu_f = xor, alu_r = d, alu_s = b, if continue then fetch else dma_or_int
177 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "01" & "001" & "10" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0480@00B2.ADD: reg_addr <= x, if false then next else read_b
178 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0482@00B3. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = d, alu_s = b, alu_cin = zero, if continue then fetch else dma_or_int
179 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "01" & "001" & "11" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0486@00B4.SD: reg_addr <= x, if false then next else read_b
180 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0488@00B5. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = b, alu_s = notd, alu_cin = one, if continue then fetch else dma_or_int
181 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "11" & "01" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0492@00B6.SHR: reg_d <= shift_dn, reg_df <= d0, shift_in = zero, if continue then fetch else dma_or_int
182 => X"2" & X"04" & X"1C" & "11" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0496@00B7.SM: reg_addr <= x, if false then next else read_b
183 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "100" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0498@00B8. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = d, alu_s = notb, alu_cin = one, if continue then fetch else dma_or_int
184 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "01" & "000" & "11" & "01" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0502@00B9.LDI: reg_addr <= p, if false then next else read_b
185 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0504@00BA. reg_d <= alu_y, alu_f = ior, alu_r = zero, alu_s = b, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
186 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "00" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0509@00BB.ORI: reg_addr <= p, if false then next else read_b
187 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0511@00BC. reg_d <= alu_y, alu_f = ior, alu_r = d, alu_s = b, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
188 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "01" & "001" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0516@00BD.ANI: reg_addr <= p, if false then next else read_b
189 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0518@00BE. reg_d <= alu_y, alu_f = and, alu_r = d, alu_s = b, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
190 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "01" & "001" & "01" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0523@00BF.XRI: reg_addr <= p, if false then next else read_b
191 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0525@00C0. reg_d <= alu_y, alu_f = xor, alu_r = d, alu_s = b, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
192 => X"2" & X"04" & X"1C" & "01" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "01" & "001" & "10" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0530@00C1.ADI: reg_addr <= p, if false then next else read_b
193 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0532@00C2. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = d, alu_s = b, alu_cin = zero, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
194 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "01" & "001" & "11" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0537@00C3.SDI: reg_addr <= p, if false then next else read_b
195 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0539@00C4. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = b, alu_s = notd, alu_cin = one, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
196 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "00" & "000" & "11" & "01" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0544@00C5.SHL: reg_d <= shift_up, reg_df <= d7, shift_in = zero, if continue then fetch else dma_or_int
197 => X"2" & X"04" & X"1C" & "10" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0548@00C6.SMI: reg_addr <= p, if false then next else read_b
198 => X"F" & X"00" & X"0C" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "110" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0550@00C7. reg_df <= alu_cout, reg_d <= alu_y, alu_f = adc, alu_r = d, alu_s = notb, alu_cin = one, alu16_f = plus_one, reg_hi <= alu16_yhi, reg_lo <= alu16_ylo, if continue then fetch else dma_or_int
199 => X"2" & X"04" & X"1C" & "01" & "11" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "10" & "01" & "000" & "11" & "01" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

-- L0558@00C8.XNOP: if false then next else NOP
200 => X"F" & X"00" & X"A7" & "00" & "00" & "000" & "00" & "00" & '0' & "000" & "00" & "00" & "00" & "00" & "00" & '0' & '0' & '0' & "001" & "00" & "00" & "000" & "00" & "00" & "01" & "01" & '0' & '0' & '1' & '1' & '0' & '1',

others => null
);

end cdp180x_code;

