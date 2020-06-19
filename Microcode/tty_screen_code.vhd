--------------------------------------------------------
-- mcc V0.9.0530 - Custom microcode compiler (c)2020-... 
--    https://github.com/zpekic/MicroCodeCompiler
--------------------------------------------------------
-- Auto-generated file, do not modify. To customize, create 'code_template.vhd' file in mcc.exe folder
-- Supported placeholders:  [NAME], [SIZES], [TYPE], [FIELDS], [SIGNAL], [MEMORY].
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.numeric_std.all;

package tty_screen_code is

-- memory block size
constant CODE_DATA_WIDTH: 	positive := 32;
constant CODE_ADDRESS_WIDTH: 	positive := 6;
constant CODE_ADDRESS_LAST: 	positive := 63;
constant CODE_IF_WIDTH: 	positive := 3;


type tty_code_memory is array(0 to 63) of std_logic_vector(31 downto 0);

signal tty_uinstruction: std_logic_vector(31 downto 0);

--
-- L0008.ready: 2 valuesno,char_is_zero,yes,- default no
--
alias tty_ready: 	std_logic_vector(1 downto 0) is tty_uinstruction(31 downto 30);
constant ready_no: 	std_logic_vector(1 downto 0) := "00";
constant ready_char_is_zero: 	std_logic_vector(1 downto 0) := "01";
constant ready_yes: 	std_logic_vector(1 downto 0) := "10";
-- Value "11" not allowed (name '-' is not assignable)

--
-- L0014.seq_cond: 3 valuestrue,char_is_zero,cursorx_ge_maxcol,cursory_ge_maxrow,cursorx_is_zero,cursory_is_zero,memory_ready,falsedefault true
--
alias tty_seq_cond: 	std_logic_vector(2 downto 0) is tty_uinstruction(29 downto 27);
constant seq_cond_true: 	integer := 0;
constant seq_cond_char_is_zero: 	integer := 1;
constant seq_cond_cursorx_ge_maxcol: 	integer := 2;
constant seq_cond_cursory_ge_maxrow: 	integer := 3;
constant seq_cond_cursorx_is_zero: 	integer := 4;
constant seq_cond_cursory_is_zero: 	integer := 5;
constant seq_cond_memory_ready: 	integer := 6;
constant seq_cond_false: 	integer := 7;

--
-- L0024.seq_then: 6 values next, repeat, return, fork, @ default next
--
alias tty_seq_then: 	std_logic_vector(5 downto 0) is tty_uinstruction(26 downto 21);
constant seq_then_next: 	std_logic_vector(5 downto 0) := "000000";
constant seq_then_repeat: 	std_logic_vector(5 downto 0) := "000001";
constant seq_then_return: 	std_logic_vector(5 downto 0) := "000010";
constant seq_then_fork: 	std_logic_vector(5 downto 0) := "000011";
-- Jump targets allowed!

--
-- L0025.seq_else: 6 values next, repeat, return, fork, 0x00..0x3F, @ default next
--
alias tty_seq_else: 	std_logic_vector(5 downto 0) is tty_uinstruction(20 downto 15);
constant seq_else_next: 	std_logic_vector(5 downto 0) := "000000";
constant seq_else_repeat: 	std_logic_vector(5 downto 0) := "000001";
constant seq_else_return: 	std_logic_vector(5 downto 0) := "000010";
constant seq_else_fork: 	std_logic_vector(5 downto 0) := "000011";
-- Values from "000000" to "111111" allowed
-- Jump targets allowed!

--
-- L0027.cursorx: 3 values same, zero, inc, dec, maxcol default same
--
alias tty_cursorx: 	std_logic_vector(2 downto 0) is tty_uinstruction(14 downto 12);
constant cursorx_same: 	std_logic_vector(2 downto 0) := "000";
constant cursorx_zero: 	std_logic_vector(2 downto 0) := "001";
constant cursorx_inc: 	std_logic_vector(2 downto 0) := "010";
constant cursorx_dec: 	std_logic_vector(2 downto 0) := "011";
constant cursorx_maxcol: 	std_logic_vector(2 downto 0) := "100";

--
-- L0029.cursory: 3 values same, zero, inc, dec, maxrow default same
--
alias tty_cursory: 	std_logic_vector(2 downto 0) is tty_uinstruction(11 downto 9);
constant cursory_same: 	std_logic_vector(2 downto 0) := "000";
constant cursory_zero: 	std_logic_vector(2 downto 0) := "001";
constant cursory_inc: 	std_logic_vector(2 downto 0) := "010";
constant cursory_dec: 	std_logic_vector(2 downto 0) := "011";
constant cursory_maxrow: 	std_logic_vector(2 downto 0) := "100";

--
-- L0031.data: 2 values same, char, memory, space default same
--
alias tty_data: 	std_logic_vector(1 downto 0) is tty_uinstruction(8 downto 7);
constant data_same: 	std_logic_vector(1 downto 0) := "00";
constant data_char: 	std_logic_vector(1 downto 0) := "01";
constant data_memory: 	std_logic_vector(1 downto 0) := "10";
constant data_space: 	std_logic_vector(1 downto 0) := "11";

--
-- L0033.mem: 2 valuesnop,read,write,-default nop
--
alias tty_mem: 	std_logic_vector(1 downto 0) is tty_uinstruction(6 downto 5);
constant mem_nop: 	std_logic_vector(1 downto 0) := "00";
constant mem_read: 	std_logic_vector(1 downto 0) := "01";
constant mem_write: 	std_logic_vector(1 downto 0) := "10";
-- Value "11" not allowed (name '-' is not assignable)

--
-- L0040.xsel: 1 values cursorx, altx default cursorx
--
alias tty_xsel: 	std_logic is tty_uinstruction(4);
constant xsel_cursorx: 	std_logic := '0';
constant xsel_altx: 	std_logic := '1';

--
-- L0042.ysel: 1 values cursory, alty default cursory
--
alias tty_ysel: 	std_logic is tty_uinstruction(3);
constant ysel_cursory: 	std_logic := '0';
constant ysel_alty: 	std_logic := '1';

--
-- L0044.altx: 1 values same, cursorx default same
--
alias tty_altx: 	std_logic is tty_uinstruction(2);
constant altx_same: 	std_logic := '0';
constant altx_cursorx: 	std_logic := '1';

--
-- L0046.alty: 1 values same, cursory default same
--
alias tty_alty: 	std_logic is tty_uinstruction(1);
constant alty_same: 	std_logic := '0';
constant alty_cursory: 	std_logic := '1';

--
-- L0048.reserved: 1 values -, - default 0
--
alias tty_reserved: 	std_logic is tty_uinstruction(0);
-- Value '0' not allowed (name '-' is not assignable)
-- Value '1' not allowed (name '-' is not assignable)



constant tty_microcode: tty_code_memory := (

-- L0059@0000._reset: cursorx <= zero, cursory <= zero
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 001, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
0 => "00" & O"0" & O"00" & O"00" & O"1" & O"1" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0061@0001._reset1: cursorx <= zero, cursory <= zero
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 001, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
1 => "00" & O"0" & O"00" & O"00" & O"1" & O"1" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0063@0002._reset2: cursorx <= zero, cursory <= zero
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 001, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
2 => "00" & O"0" & O"00" & O"00" & O"1" & O"1" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0065@0003._reset3: cursorx <= zero, cursory <= zero
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 001, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
3 => "00" & O"0" & O"00" & O"00" & O"1" & O"1" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0067@0004.waitChar: ready = char_is_zero, data <= char,if char_is_zero then repeat else next
--  ready = 01, if (001) then 000001 else 000000, cursorx <= 000, cursory <= 000, data <= 01, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
4 => "01" & O"1" & O"01" & O"00" & O"0" & O"0" & "01" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0070@0005. if true then fork else fork
--  ready = 00, if (000) then 000011 else 000011, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
5 => "00" & O"0" & O"03" & O"03" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0074@0006.main: if false then next else printChar
--  ready = 00, if (111) then 000000 else 100010, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
6 => "00" & O"7" & O"00" & O"42" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0076@0007. cursorx <= inc
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 010, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
7 => "00" & O"0" & O"00" & O"00" & O"2" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0078@0008. if cursorx_ge_maxcol then next else nextChar
--  ready = 00, if (010) then 000000 else 001010, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
8 => "00" & O"2" & O"00" & O"12" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0080@0009. cursorx <= zero,if false then next else LF
--  ready = 00, if (111) then 000000 else 010011, cursorx <= 001, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
9 => "00" & O"7" & O"00" & O"23" & O"1" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0084@000A.nextChar: ready = yes,if char_is_zero then waitChar else repeat
--  ready = 10, if (001) then 000100 else 000001, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
10 => "10" & O"1" & O"04" & O"01" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0088@000B.CLS: data <= space, cursory <= zero
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 000, cursory <= 001, data <= 11, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
11 => "00" & O"0" & O"00" & O"00" & O"0" & O"1" & "11" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0090@000C.nextRow: cursorx <= zero
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
12 => "00" & O"0" & O"00" & O"00" & O"1" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0092@000D.nextCol: if false then next else printChar
--  ready = 00, if (111) then 000000 else 100010, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
13 => "00" & O"7" & O"00" & O"42" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0094@000E. cursorx <= inc
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 010, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
14 => "00" & O"0" & O"00" & O"00" & O"2" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0096@000F. if cursorx_ge_maxcol then next else nextCol
--  ready = 00, if (010) then 000000 else 001101, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
15 => "00" & O"2" & O"00" & O"15" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0098@0010. cursory <= inc
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 000, cursory <= 010, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
16 => "00" & O"0" & O"00" & O"00" & O"0" & O"2" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0100@0011. if cursory_ge_maxrow then HOME else nextRow
--  ready = 00, if (011) then 010010 else 001100, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
17 => "00" & O"3" & O"22" & O"14" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0103@0012.HOME: cursorx <= zero, cursory <= zero,if false then next else nextChar
--  ready = 00, if (111) then 000000 else 001010, cursorx <= 001, cursory <= 001, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
18 => "00" & O"7" & O"00" & O"12" & O"1" & O"1" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0107@0013.LF: cursory <= inc
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 000, cursory <= 010, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
19 => "00" & O"0" & O"00" & O"00" & O"0" & O"2" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0109@0014. if cursory_ge_maxrow then next else nextChar
--  ready = 00, if (011) then 000000 else 001010, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
20 => "00" & O"3" & O"00" & O"12" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0111@0015.scrollUp: cursory <= zero
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 000, cursory <= 001, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
21 => "00" & O"0" & O"00" & O"00" & O"0" & O"1" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0113@0016.copyRow: if cursory_ge_maxrow then lastLine else next
--  ready = 00, if (011) then 011101 else 000000, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
22 => "00" & O"3" & O"35" & O"00" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0115@0017. cursorx <= zero
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
23 => "00" & O"0" & O"00" & O"00" & O"1" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0117@0018.copyCol: if cursorx_ge_maxcol then nextY else next
--  ready = 00, if (010) then 011100 else 000000, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
24 => "00" & O"2" & O"34" & O"00" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0119@0019. cursory <= inc,if false then next else readMem
--  ready = 00, if (111) then 000000 else 100100, cursorx <= 000, cursory <= 010, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
25 => "00" & O"7" & O"00" & O"44" & O"0" & O"2" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0122@001A. cursory <= dec,if false then next else printChar
--  ready = 00, if (111) then 000000 else 100010, cursorx <= 000, cursory <= 011, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
26 => "00" & O"7" & O"00" & O"42" & O"0" & O"3" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0125@001B. cursorx <= inc,if false then next else copyCol
--  ready = 00, if (111) then 000000 else 011000, cursorx <= 010, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
27 => "00" & O"7" & O"00" & O"30" & O"2" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0128@001C.nextY: cursory <= inc,if false then next else copyRow
--  ready = 00, if (111) then 000000 else 010110, cursorx <= 000, cursory <= 010, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
28 => "00" & O"7" & O"00" & O"26" & O"0" & O"2" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0131@001D.lastLine: data <= space, cursory <= dec, cursorx <= zero
--  ready = 00, if (000) then 000000 else 000000, cursorx <= 001, cursory <= 011, data <= 11, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
29 => "00" & O"0" & O"00" & O"00" & O"1" & O"3" & "11" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0133@001E.clearCol: if cursorx_ge_maxcol then CR else next
--  ready = 00, if (010) then 100001 else 000000, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
30 => "00" & O"2" & O"41" & O"00" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0135@001F. if false then next else printChar
--  ready = 00, if (111) then 000000 else 100010, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
31 => "00" & O"7" & O"00" & O"42" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0137@0020. cursorx <= inc,if false then next else clearCol
--  ready = 00, if (111) then 000000 else 011110, cursorx <= 010, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
32 => "00" & O"7" & O"00" & O"36" & O"2" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0141@0021.CR: cursorx <= zero,if false then next else nextChar
--  ready = 00, if (111) then 000000 else 001010, cursorx <= 001, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
33 => "00" & O"7" & O"00" & O"12" & O"1" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0144@0022.printChar: if memory_ready then next else repeat
--  ready = 00, if (110) then 000000 else 000001, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
34 => "00" & O"6" & O"00" & O"01" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0146@0023. mem = write, xsel = cursorx, ysel = cursory,if false then next else return
--  ready = 00, if (111) then 000000 else 000010, cursorx <= 000, cursory <= 000, data <= 00, mem = 10, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
35 => "00" & O"7" & O"00" & O"02" & O"0" & O"0" & "00" & "10" & '0' & '0' & '0' & '0' & '0',

-- L0149@0024.readMem: if memory_ready then next else repeat
--  ready = 00, if (110) then 000000 else 000001, cursorx <= 000, cursory <= 000, data <= 00, mem = 00, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
36 => "00" & O"6" & O"00" & O"01" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0',

-- L0151@0025. mem = read, xsel = cursorx, ysel = cursory, data <= memory,if false then next else return
--  ready = 00, if (111) then 000000 else 000010, cursorx <= 000, cursory <= 000, data <= 10, mem = 01, xsel = 0, ysel = 0, altx <= 0, alty <= 0, reserved = 0;
37 => "00" & O"7" & O"00" & O"02" & O"0" & O"0" & "10" & "01" & '0' & '0' & '0' & '0' & '0',

-- 26 location(s) in following ranges will be filled with default value
-- 0026 .. 003F

others => "00" & O"0" & O"00" & O"00" & O"0" & O"0" & "00" & "00" & '0' & '0' & '0' & '0' & '0'
);

end tty_screen_code;

