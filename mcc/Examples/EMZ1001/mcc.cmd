@echo off
@echo -- Compile code for internal and external ROMs
@echo See https://github.com/zpekic/MicroCodeCompiler
..\..\..\Sys9900\mcc\mcc\bin\Debug\mcc.exe /a:emz Fibonacci.emz
..\..\..\Sys9900\mcc\mcc\bin\Debug\mcc.exe /a:emz HelloWorld.emz
@echo -- Convert image into 8*8 pixel character generator ROM
@echo See https://github.com/zpekic/Sys_TIM-011/tree/master/Img2Tim
..\..\..\Sys_TIM-011\Sys_TIM-011\Img2Tim\Img2Tim\bin\Debug\img2tim.exe ..\doc\iskra-logo.bmp -x -c

