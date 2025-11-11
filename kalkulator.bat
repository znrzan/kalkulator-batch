@echo off
title Kalkulator Sederhana
setlocal enabledelayedexpansion

set max=2147483647

:menu
cls
echo ==============================
echo     KALKULATOR SEDERHANA
echo ==============================
echo.

REM Meminta input
set /p num1="Masukkan angka pertama: "
set /p op="Masukkan operator (+, -, *, /): "
set /p num2="Masukkan angka kedua: "

REM Normalisasi desimal: ganti koma dengan titik
set num1=%num1:,=.%
set num2=%num2:,=.%

REM Cek jika mengandung titik (desimal)
echo %num1% | findstr "\." >nul
set is_decimal1=%errorlevel%
echo %num2% | findstr "\." >nul
set is_decimal2=%errorlevel%

REM Cek batas angka pertama (hanya untuk integer)
if !is_decimal1! neq 0 (
  set /a test1=num1+0 2>nul
  if !test1! gtr !max! (
    echo ERROR: Angka melebihi batas 32-bit.
    pause
    goto menu
  )
)

REM Cek batas angka kedua (hanya untuk integer)
if !is_decimal2! neq 0 (
  set /a test2=num2+0 2>nul
  if !test2! gtr !max! (
    echo ERROR: Angka melebihi batas 32-bit.
    pause
    goto menu
  )
)

REM Ubah operator x dan :
if /I "%op%"=="x" set op=*
if /I "%op%"==":" set op=/

REM Cek operator valid
if not "%op%"=="+" if not "%op%"=="-" if not "%op%"=="*" if not "%op%"=="/" (
  echo ERROR: Operator tidak valid. Gunakan +, -, *, /.
  pause
  goto menu
)

REM Cek pembagian dengan nol
if "%op%"=="/" if %num2%==0 (
  echo ERROR: Tidak bisa membagi dengan nol.
  pause
  goto menu
)

REM Jika ada desimal, gunakan PowerShell
if %is_decimal1%==0 (
  for /f %%i in ('powershell -command "$n1='%num1%'; $n2='%num2%'; $o='%op%'; try { $r = Invoke-Expression \"[double]$n1 $o [double]$n2\"; Write-Host $r } catch { Write-Host 'Error' }"') do set hasil=%%i
  if "%hasil%"=="Error" (
    echo ERROR: Kesalahan perhitungan desimal.
    pause
    goto menu
  )
  goto tampilkan
)
if %is_decimal2%==0 (
  for /f %%i in ('powershell -command "$n1='%num1%'; $n2='%num2%'; $o='%op%'; try { $r = Invoke-Expression \"[double]$n1 $o [double]$n2\"; Write-Host $r } catch { Write-Host 'Error' }"') do set hasil=%%i
  if "%hasil%"=="Error" (
    echo ERROR: Kesalahan perhitungan desimal.
    pause
    goto menu
  )
  goto tampilkan
)

REM Cek potensi overflow untuk penjumlahan
if "%op%"=="+" (
  set /a test_sum=num1 + num2 2>nul
  if errorlevel 1 (
    echo ERROR: Hasil penjumlahan melebihi batas 32-bit.
    pause
    goto menu
  )
  set hasil=%test_sum%
  goto tampilkan
)

REM Cek potensi overflow untuk perkalian
if "%op%"=="*" (
  if %num2% neq 0 (
    set /a test_mul=num1 * num2 2>nul
    if errorlevel 1 (
      echo ERROR: Hasil perkalian melebihi batas 32-bit.
      pause
      goto menu
    )
    set hasil=%test_mul%
  ) else (
    set hasil=0
  )
  goto tampilkan
)

REM Untuk pengurangan dan pembagian, lakukan operasi (overflow jarang ke atas)
set /a hasil=%num1% %op% %num2% 2>nul
if errorlevel 1 (
  echo ERROR: Input tidak valid atau hasil melebihi batas.
  pause
  goto menu
)

:tampilkan

REM Tampilkan hasil
echo.
echo ==============================
echo    Hasil: %num1% %op% %num2% = %hasil%
echo ==============================
echo.
pause
goto menu