@echo off
title Kalkulator Sederhana

set max=2147483647
set min=-2147483648

:menu
cls
echo ==============================
echo      KALKULTOR SEDERHANA
echo ==============================
echo.

REM Meminta input
set /p num1="Masukkan angka pertama: "
set /p op="Masukkan operator (+, -, *, /): "
set /p num2="Masukkan angka kedua: "

REM Cek batas angka pertama
set /a test1=num1+0 2>nul
if %test1% gtr %max% (
  echo ERROR: Angka pertama melebihi batas 32-bit.
  pause
  goto menu
)

IF /I "%op%"=="x" SET op=*
IF /I "%op%"==":" SET op=/

REM Proses Perhitungan
set /a hasil=%num1% %op% %num2%

REM Tampilkan hasil
echo.
echo ==============================
echo    Hasil: %num1% %op% %num2% = %hasil%
echo ==============================
echo.
pause
goto menu