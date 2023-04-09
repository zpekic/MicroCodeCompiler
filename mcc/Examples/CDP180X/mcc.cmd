@echo off
@echo See https://github.com/zpekic/MicroCodeCompiler
copy ..\..\sys9900\mcc\microcode\cdp180X.mcc
..\..\Sys9900\mcc\mcc\bin\Debug\mcc.exe cdp180X.mcc
