:: Файл компиляции и сборки проектов GNU AS

echo off
cls

:: Удалим файлы прежних попыток сборки проекта ------------------------------
del /Q compile\*.* 
del /Q compile\temp\*.* 

:: Назначаем переменные (каталог запуска и компилятора) ---------------------
set pth=%~dp0
set path=%~dp0bin\
set incl=%~dp0inc\
echo Current start directory: %path%
echo.

echo File compiling:
:: обходим все каталоги проекта и компилируем asm файлы в .o ----------------
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

:: обходим все каталоги проекта и строим список .o файлов -------------------
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
:: компонуем полученные .o файлы в прошивку ---------------------------------
cd %pth%
%path%ld.exe -T src\stm_map.ld -o compile\sys.elf %ofiles%
%path%objdump.exe -d compile\sys.elf
PAUSE

:: Если при компиляции были ошибки и выходного файла нет - выходим !
set ou=compile\sys.elf
IF NOT exist %ou% (
   echo Compile error !
   PAUSE
   goto exit
)

:: из .elf файла делаем файлы прошивок .bin и .hex --------------------------
cd %pth%
%path%objcopy.exe -O binary compile\sys.elf compile\output.bin
%path%objcopy.exe -O ihex   compile\sys.elf compile\output.hex
:: Адреса меток и значения переменных, вывод в файл
%path%nm.exe -A -p compile\sys.elf > compile\labels.lst
echo.
echo Binary files stored in derictory: \compile\

:exit
:: удаляем .o файлы чтобы не мешались----------------------------------------
cd %pth%
Setlocal EnableDelayedExpansion
for /r /d %%i in (*) do (
   cd %%i
   for %%b in (*.o) do (del /Q %%~fb)
)