@echo off
title Kalkulator Sederhana
:menu
cls

echo ================================
echo      KALKULATOR SEDERHANA
echo ================================
echo.
echo [1] +  Penjumlahan
echo [2] -  Pengurangan
echo [3] *  Perkalian
echo [4] /  Pembagian
echo [5]    Keluar
echo.
set /p p=Pilih operasi (1-5): 

if "%p%"=="5" exit

rem Tentukan operator berdasarkan pilihan
if "%p%"=="1" set op=+
if "%p%"=="2" set op=-
if "%p%"=="3" set op=*
if "%p%"=="4" set op=/
if not defined op (
    echo Pilihan tidak valid!
    pause
    goto menu
)

cls
echo === %op% ===
set /p a=Masukkan angka pertama: 
set /p b=Masukkan angka kedua: 

rem Gunakan PowerShell untuk validasi dan perhitungan
powershell -Command ^
    "$a='%a%'; $b='%b%'; $op='%op%';" ^
    "if (-not ([double]::TryParse($a,[ref]0)) -or -not ([double]::TryParse($b,[ref]0))) {" ^
    "   Write-Host 'Error: Input harus berupa angka valid!'; exit 1}" ^
    "if ($op -eq '/' -and [double]$b -eq 0) {" ^
    "   Write-Host 'Error: Tidak bisa dibagi dengan nol!'; exit 1}" ^
    "$expr = \"$a $op $b\";" ^
    "$result = Invoke-Expression $expr;" ^
    "Write-Host 'Hasil: ' $a $op $b '=' $result"

if errorlevel 1 (
    pause
    goto menu
)

echo.
pause
goto menu
