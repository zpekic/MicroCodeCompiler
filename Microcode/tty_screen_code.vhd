--------------------------------------------------------
-- mcc V0.9.0509 - Custom microcode compiler (c)2020-... 
--    https://github.com/zpekic/MicroCodeCompiler
--------------------------------------------------------
-- Auto-generated file, do not modify. To customize, create 'code_template.vhd' file in mcc.exe folder
-- Supported placeholders:  [NAME], [SIZES], [TYPE], [FIELDS], [SIGNAL], [MEMORY].
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

package tty_screen_code is

-- memory block size
constant CODE_DATA_WIDTH: 	positive := 32;
constant CODE_ADDRESS_WIDTH: 	positive := 6;
constant CODE_ADDRESS_LAST: 	positive := 63;
constant CODE_IF_WIDTH: 	positive := 3;


type code_memory is array(0 to 63) of std_logic_vector(31 downto 0);

signal ucode: std_logic_vector(31 downto 0);

--
-- L0008.ready: 1 values no, yes default no
--
alias uc_ready: 	std_logic is ucode(31);
constant ready_no: 	std_logic := '0';
constant ready_yes: 	std_logic := '1';

--
-- L0010.seq_cond: 3 valuestrue,char_is_zero,cursorx_ge_maxcol,cursory_ge_maxrow,cursorx_is_zero,cursory_is_zero,memory_ready,falsedefault true
--
alias uc_seq_cond: 	std_logic_vector(2 downto 0) is ucode(30 downto 28);
constant seq_cond_true: 	integer := 0;
constant seq_cond_char_is_zero: 	integer := 1;
constant seq_cond_cursorx_ge_maxcol: 	integer := 2;
constant seq_cond_cursory_ge_maxrow: 	integer := 3;
constant seq_cond_cursorx_is_zero: 	integer := 4;
constant seq_cond_cursory_is_zero: 	integer := 5;
constant seq_cond_memory_ready: 	integer := 6;
constant seq_cond_false: 	integer := 7;

--
-- L0020.seq_then: 6 values next, repeat, return, fork, @ default next
--
alias uc_seq_then: 	std_logic_vector(5 downto 0) is ucode(27 downto 22);
constant seq_then_next: 	std_logic_vector(5 downto 0) := "000000";
constant seq_then_repeat: 	std_logic_vector(5 downto 0) := "000001";
constant seq_then_return: 	std_logic_vector(5 downto 0) := "000010";
constant seq_then_fork: 	std_logic_vector(5 downto 0) := "000011";
-- Jump targets allowed!

--
-- L0021.seq_else: 6 values next, repeat, return, fork, 0x00..0x3F, @ default next
--
alias uc_seq_else: 	std_logic_vector(5 downto 0) is ucode(21 downto 16);
constant seq_else_next: 	std_logic_vector(5 downto 0) := "000000";
constant seq_else_repeat: 	std_logic_vector(5 downto 0) := "000001";
constant seq_else_return: 	std_logic_vector(5 downto 0) := "000010";
constant seq_else_fork: 	std_logic_vector(5 downto 0) := "000011";
-- Values from "000000" to "111111" allowed
-- Jump targets allowed!

--
-- L0023.cursorx: 3 values same, zero, inc, dec, maxcol default same
--
alias uc_cursorx: 	std_logic_vector(2 downto 0) is ucode(15 downto 13);
constant cursorx_same: 	std_logic_vector(2 downto 0) := "000";
constant cursorx_zero: 	std_logic_vector(2 downto 0) := "001";
constant cursorx_inc: 	std_logic_vector(2 downto 0) := "010";
constant cursorx_dec: 	std_logic_vector(2 downto 0) := "011";
constant cursorx_maxcol: 	std_logic_vector(2 downto 0) := "100";

--
-- L0025.cursory: 3 values same, zero, inc, dec, maxrow default same
--
alias uc_cursory: 	std_logic_vector(2 downto 0) is ucode(12 downto 10);
constant cursory_same: 	std_logic_vector(2 downto 0) := "000";
constant cursory_zero: 	std_logic_vector(2 downto 0) := "001";
constant cursory_inc: 	std_logic_vector(2 downto 0) := "010";
constant cursory_dec: 	std_logic_vector(2 downto 0) := "011";
constant cursory_maxrow: 	std_logic_vector(2 downto 0) := "100";

--
-- L0027.data: 2 values same, char, memory, space default same
--
alias uc_data: 	std_logic_vector(1 downto 0) is ucode(9 downto 8);
constant data_same: 	std_logic_vector(1 downto 0) := "00";
constant data_char: 	std_logic_vector(1 downto 0) := "01";
constant data_memory: 	std_logic_vector(1 downto 0) := "10";
constant data_space: 	std_logic_vector(1 downto 0) := "11";

--
-- L0029.mem: 2 valuesnop,read,write,-default nop
--
alias uc_mem: 	std_logic_vector(1 downto 0) is ucode(7 downto 6);
constant mem_nop: 	std_logic_vector(1 downto 0) := "00";
constant mem_read: 	std_logic_vector(1 downto 0) := "01";
constant mem_write: 	std_logic_vector(1 downto 0) := "10";
-- Value "11" not allowed (name '-' is not assignable)

--
-- L0036.xsel: 1 values cursorx, altx default cursorx
--
alias uc_xsel: 	std_logic is ucode(5);
constant xsel_cursorx: 	std_logic := '0';
constant xsel_altx: 	std_logic := '1';

--
-- L0038.ysel: 1 values cursory, alty default cursory
--
alias uc_ysel: 	std_logic is ucode(4);
constant ysel_cursory: 	std_logic := '0';
constant ysel_alty: 	std_logic := '1';

--
-- L0040.altx: 1 values same, cursorx default same
--
alias uc_altx: 	std_logic is ucode(3);
constant altx_same: 	std_logic := '0';
constant altx_cursorx: 	std_logic := '1';

--
-- L0042.alty: 1 values same, cursory default same
--
alias uc_alty: 	std_logic is ucode(2);
constant alty_same: 	std_logic := '0';
constant alty_cursory: 	std_logic := '1';

--
-- L0044.reserved: 2 values -, -, -, - default 0
--
alias uc_reserved: 	std_logic_vector(1 downto 0) is ucode(1 downto 0);
-- Value "00" not allowed (name '-' is not assignable)
-- Value "01" not allowed (name '-' is not assignable)
-- Value "10" not allowed (name '-' is not assignable)
-- Value "11" not allowed (name '-' is not assignable)



constant microcode: code_memory := (

-- L0055@0000._reset: cursorx <= zero, cursory <= zero
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 001, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
0 => '0' & O"0" & O"00" & O"00" & O"1" & O"1" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0057@0001._reset1: cursorx <= zero, cursory <= zero
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 001, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
1 => '0' & O"0" & O"00" & O"00" & O"1" & O"1" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0059@0002._reset2: cursorx <= zero, cursory <= zero
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 001, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
2 => '0' & O"0" & O"00" & O"00" & O"1" & O"1" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0061@0003._reset3: cursorx <= zero, cursory <= zero
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 001, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
3 => '0' & O"0" & O"00" & O"00" & O"1" & O"1" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0063@0004.waitChar: ready = yes, data <= char,if char_is_zero then repeat else next
--  ready = 1, if (001) then 000001 else 000000, cursorx <= 000, cursory <= 000, data <= 01, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
4 => '1' & O"1" & O"01" & O"00" & O"0" & O"0" & "01" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0067@0005.main: if false then next else printChar
--  ready = 0, if (111) then 000000 else 010110, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
5 => '0' & O"7" & O"00" & O"26" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0069@0006. cursorx <= inc
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 010, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
6 => '0' & O"0" & O"00" & O"00" & O"2" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0071@0007. if cursorx_ge_maxcol then next else waitChar
--  ready = 0, if (010) then 000000 else 000100, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
7 => '0' & O"2" & O"00" & O"04" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0073@0008. cursorx <= zero,if false then next else LF
--  ready = 0, if (111) then 000000 else 010010, cursorx <= 001, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
8 => '0' & O"7" & O"00" & O"22" & O"1" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0077@0009. if false then next else waitChar
--  ready = 0, if (111) then 000000 else 000100, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
9 => '0' & O"7" & O"00" & O"04" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0080@000A.CLS: data <= space, cursory <= zero
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 000, cursory <= 001, data <= 11, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
10 => '0' & O"0" & O"00" & O"00" & O"0" & O"1" & "11" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0082@000B.nextRow: cursorx <= zero
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
11 => '0' & O"0" & O"00" & O"00" & O"1" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0084@000C.nextCol: if false then next else printChar
--  ready = 0, if (111) then 000000 else 010110, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
12 => '0' & O"7" & O"00" & O"26" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0086@000D. cursorx <= inc
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 010, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
13 => '0' & O"0" & O"00" & O"00" & O"2" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0088@000E. if cursorx_ge_maxcol then next else nextCol
--  ready = 0, if (010) then 000000 else 001100, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
14 => '0' & O"2" & O"00" & O"14" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0090@000F. cursory <= inc
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 000, cursory <= 010, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
15 => '0' & O"0" & O"00" & O"00" & O"0" & O"2" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0092@0010. if cursory_ge_maxrow then HOME else nextRow
--  ready = 0, if (011) then 010001 else 001011, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
16 => '0' & O"3" & O"21" & O"13" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0095@0011.HOME: cursorx <= zero, cursory <= zero,if false then next else waitChar
--  ready = 0, if (111) then 000000 else 000100, cursorx <= 001, cursory <= 001, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
17 => '0' & O"7" & O"00" & O"04" & O"1" & O"1" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0099@0012.LF: cursory <= inc
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 000, cursory <= 010, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
18 => '0' & O"0" & O"00" & O"00" & O"0" & O"2" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0101@0013. if cursory_ge_maxrow then next else waitChar
--  ready = 0, if (011) then 000000 else 000100, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
19 => '0' & O"3" & O"00" & O"04" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0103@0014.scrollUp: if true then next else next
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
20 => '0' & O"0" & O"00" & O"00" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0106@0015. cursorx <= zero,if false then next else waitChar
--  ready = 0, if (111) then 000000 else 000100, cursorx <= 001, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
21 => '0' & O"7" & O"00" & O"04" & O"1" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0109@0016.printChar: if memory_ready then next else repeat
--  ready = 0, if (110) then 000000 else 000001, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
22 => '0' & O"6" & O"00" & O"01" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00",

-- L0111@0017. mem = write, xsel = cursorx, ysel = cursory
--  ready = 0, if (000) then 000000 else 000000, cursorx <= 000, cursory <= 000, data <= 00, mem = 10, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
23 => '0' & O"0" & O"00" & O"00" & O"0" & O"0" & "00" & "10" & '0' & '0' & '0' & '0' & "00",

-- L0113@0018. mem = write, xsel = cursorx, ysel = cursory,if false then next else return
--  ready = 0, if (111) then 000000 else 000010, cursorx <= 000, cursory <= 000, data <= 00, mem = 10, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 00;
24 => '0' & O"7" & O"00" & O"02" & O"0" & O"0" & "00" & "10" & '0' & '0' & '0' & '0' & "00",

-- 39 location(s) in following ranges will be filled with default value
-- 0019 .. 003F

others => '0' & O"0" & O"00" & O"00" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & "00"
);

end tty_screen_code;

