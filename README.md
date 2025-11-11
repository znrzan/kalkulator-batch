Berikut penjelasan singkat untuk setiap sintaks yang digunakan dalam kode batch script kalkulator:

***

### Penjelasan Sintaks

- `@echo off`  
  Menonaktifkan tampilan perintah yang dijalankan di jendela command prompt agar output lebih bersih.

- `title Kalkulator Sederhana`  
  Mengatur judul jendela command prompt menjadi "Kalkulator Sederhana".

- `:menu`  
  Label untuk menandai titik awal menu; bisa digunakan dengan `goto menu` untuk lompat ke bagian ini.

- `cls`  
  Membersihkan tampilan layar command prompt.

- `echo ================================`  
  Menampilkan teks garis pemisah sebagai dekorasi pada layar.

- `echo` dengan berbagai teks  
  Menampilkan teks pada layar, termasuk judul, pilihan operasi, dan instruksi.

- `set /p p=Pilih operasi (1-5):`  
  Menyimpan input pengguna ke variabel `p` setelah menampilkan prompt "Pilih operasi (1-5):".

- `if "%p%"=="5" exit`  
  Jika input `p` adalah "5", maka program keluar.

- `rem ...`  
  Baris komentar yang tidak dieksekusi, berisi catatan programmer.

- `if "%p%"=="1" set op=+`  
  Jika `p` bernilai "1", set variabel `op` menjadi `+`. (Serupa untuk pilihan "2", "3", "4").

- `if not defined op ( ... )`  
  Jika variabel `op` tidak terisi (pilihan invalid), tampilkan pesan error dan kembali ke menu.

- `set /p a=Masukkan angka pertama:`  
  Meminta input angka pertama dan simpan di variabel `a`.

- `set /p b=Masukkan angka kedua:`  
  Meminta input angka kedua dan simpan di variabel `b`.

- `powershell -Command ^ ...`  
  Memanggil PowerShell untuk mengeksekusi perintah lanjut berikutnya (gunakan `^` untuk melanjutkan baris).

  - `$a='%a%'; $b='%b%'; $op='%op%';`  
    Menginisialisasi variabel PowerShell dengan nilai input batch.

  - `if (-not ([double]::TryParse($a,[ref]0)) -or -not ([double]::TryParse($b,[ref]0))) { Write-Host 'Error...' ; exit 1}`  
    Validasi apakah input `a` dan `b` adalah angka valid, jika tidak tampilkan pesan error dan keluar dengan kode error 1.

  - `if ($op -eq '/' -and [double]$b -eq 0) { Write-Host 'Error: Tidak bisa dibagi dengan nol!'; exit 1}`  
    Cek pembagian dengan nol, jika ya tampilkan error dan keluar dengan kode 1.

  - `$expr = \"$a $op $b\";`  
    Buat string ekspresi matematika dari input dan operator.

  - `$result = Invoke-Expression $expr;`  
    Hitung hasil ekspresi menggunakan PowerShell.

  - `Write-Host 'Hasil: ' $a $op $b '=' $result`  
    Tampilkan hasil perhitungan.

- `if errorlevel 1 ( pause & goto menu )`  
  Jika kode error PowerShell >= 1 (ada error), berhenti sejenak lalu kembali ke menu.

- `pause`  
  Menghentikan eksekusi agar pengguna dapat melihat hasil sebelum kembali ke menu.

- `goto menu`  
  Kembali ke label `:menu` untuk mengulangi program.

***