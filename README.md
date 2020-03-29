"mcc" is a compiler written in C# that takes symbolic descriptions of microcode instructions and generates mapper and microcode ROM initialization files, typically used in FPGA syntesis of CPU control units.

The basic idea behind it is a standardized microcontrol unit, which is simple yet powerful and can easily drive devices such as various processors and controllers. It allows for example relatively easy recreation of 8- and 16-bit historic CPUs in VHDL. Key elements:

- Mapper memory. Address is the instruction register (or any sub/superset of it), and output the entry point where the microinstruction sequence implementing it starts

- Microcode memory. Address is output from microinstruction program counter, and output is the microinstruction word driving the machine

- Control unit. It is driven by 3 fields of microinstruction word:
1. "if" -- this is simply a select of a n to 1 mux which decides if the condition is true or false
2. "then" -- target to execute or jump to if the condition is true
3. "else" -- target to execute of jump to if the condition is false

The control unit is made simple by 2 innovations:

a) The jump target and instructions are overlapped. Typically the first 4 codes are reserved for:
next ... upc <= upc + 1;
repeat ... upc <= upc;
fork ... upc <= mapper(instruction_register);
return ... upc <= stack pop;

All the other targets presented on "then" or "else" are interpreted as upc <= target

b) a limited depth stack (typically 4 levels) is built in. That means each upc <= target also pushes the previous address on the stack in one machine cycle, and return is also executed in 1 machine cycle. This means that at each jump the bottom of the stack is lost, in other words programmer must take care to never nest more than 3 levels if stack is 4 levels deep. 

You can find a bit more info about the ideas behind this here: https://hackaday.io/project/167457-tms0800-fpga-implementation-in-vhdl/log/168280-patterns-for-creating-microcode-driven-core-in-vhdl
