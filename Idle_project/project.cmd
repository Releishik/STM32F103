:: ���� ���������� � ������ �������� GNU AS

echo off
cls

:: ������ ����� ������� ������� ������ ������� ------------------------------
del /Q compile\*.* 
del /Q compile\temp\*.* 

:: ��������� ���������� (������� ������� � �����������) ---------------------
set pth=%~dp0
set path=%~dp0bin\
set incl=%~dp0inc\
echo Current start directory: %path%
echo.

echo File compiling:
:: ������� ��� �������� ������� � ����������� asm ����� � .o ----------------
Setlocal EnableDelayedExpansion
for /r /d %%i in (*) do (
   cd %%i
   for %%b in (*.asm) do (
      set a=%%~fb
      set o=%%~db%%~pb%%~nb.o
      set l=compile/temp/%%~nb.lst
      echo !a!
      cd !pth!
%path%as.exe -I !incl! -o !o! !a!
%path%objdump.exe -j .vectors -j .asmcode -j .bss -j .rodata -d -t -w !o! > !l!
      cd %%i
   )
)

:: ������� ��� �������� ������� � ������ ������ .o ������ -------------------
cd %pth%
set ofiles=
Setlocal EnableDelayedExpansion
for /r /d %%i in (*) do (
   cd %%i
   for %%b in (*.o) do set ofiles=!ofiles! %%~fb
   )
)
echo.

echo File linking: 
echo %ofiles%
echo.
:: ��������� ���������� .o ����� � �������� ---------------------------------
cd %pth%
%path%ld.exe -T src\stm_map.ld -o compile\sys.elf %ofiles%
%path%objdump.exe -d compile\sys.elf
PAUSE

:: ���� ��� ���������� ���� ������ � ��������� ����� ��� - ������� !
set ou=compile\sys.elf
IF NOT exist %ou% (
   echo Compile error !
   PAUSE
   goto exit
)

:: �� .elf ����� ������ ����� �������� .bin � .hex --------------------------
cd %pth%
%path%objcopy.exe -O binary compile\sys.elf compile\output.bin
%path%objcopy.exe -O ihex   compile\sys.elf compile\output.hex
:: ������ ����� � �������� ����������, ����� � ����
%path%nm.exe -A -p compile\sys.elf > compile\labels.lst
echo.
echo Binary files stored in derictory: \compile\

:exit
:: ������� .o ����� ����� �� ��������----------------------------------------
cd %pth%
Setlocal EnableDelayedExpansion
for /r /d %%i in (*) do (
   cd %%i
   for %%b in (*.o) do (del /Q %%~fb)
)