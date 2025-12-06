Nama : Audi Makrufianto Afetama
NIM : H1D023037
Shift lama/bru : c

[Responsi+Praktikum+Pemob.webm](https://github.com/user-attachments/assets/4ead827b-95bc-45ae-957a-8deaf25e562a)

--Spesifikasi API--
1. Login (login.php) API ini berfungsi sebagai gerbang masuk autentikasi pengguna.
   Endpoint ini menerima data username dan password melalui metode POST. Sistem akan mencocokkan data tersebut dengan tabel users di database.
   Jika data ditemukan, API akan mengembalikan respons JSON dengan status sukses yang mengizinkan pengguna masuk ke aplikasi.

2. Registrasi (registrasi.php) API ini digunakan untuk mendaftarkan pengguna baru ke dalam sistem.
   Endpoint ini menerima input username dan password melalui metode POST. Sebelum disimpan ke tabel users, password akan dienkripsi menggunakan algoritma MD5 untuk keamanan dasar.
   Respons sukses akan dikirimkan jika proses penyimpanan data berhasil.

3. Read Data (read.php) Endpoint ini bertugas untuk mengambil seluruh data inventaris buku yang tersimpan di database.
   Menggunakan metode GET, API ini menjalankan query SELECT * FROM buku dan mengonversi hasil baris data MySQL menjadi format JSON array.
   Data inilah yang nantinya akan ditampilkan pada halaman utama aplikasi Flutter.

4. Create Data (create.php) API ini berfungsi untuk menambahkan data buku baru ke dalam database.
   Endpoint ini menerima kiriman data lengkap melalui metode POST, meliputi judul, harga, jumlah, tanggal masuk, volume, penulis, dan penerbit.
   Data yang diterima kemudian dimasukkan ke tabel buku menggunakan perintah SQL INSERT.

5. Update Data (update.php) Endpoint ini digunakan untuk memperbarui informasi buku yang sudah ada.
   Menggunakan metode POST, API ini memerlukan parameter id buku sebagai kunci utama, beserta data-data baru yang ingin diubah.
   Sistem akan mencari baris data berdasarkan id tersebut dan melakukan perintah SQL UPDATE untuk menyimpan perubahan.

6. Delete Data (delete.php) API ini bertugas untuk menghapus data inventaris dari database.
   Endpoint ini menerima parameter id buku melalui metode POST. Berdasarkan id tersebut, sistem akan menjalankan perintah SQL DELETE untuk menghapus baris data yang bersangkutan secara permanen dari tabel buku.

   --Penjelasan Kode--
1. Konfigurasi Utama (main.dart) File ini merupakan titik awal (entry point) dari aplikasi Audimart.
   Di dalamnya terdapat kelas MyApp yang mengatur konfigurasi dasar seperti judul aplikasi dan tema visual.
   Sesuai instruksi, primarySwatch diatur ke warna coklat (Colors.brown). File ini juga menentukan bahwa halaman pertama yang akan dimuat saat aplikasi dijalankan adalah halaman Login.

2. Halaman Login (login_screen.dart) File ini menangani antarmuka dan logika untuk autentikasi pengguna.
   Terdapat dua fungsi utama: _login() yang mengirim permintaan ke API login untuk memverifikasi akun, dan _register() yang mengirim permintaan ke API registrasi untuk membuat akun baru.
   Jika login berhasil, navigasi akan diarahkan ke halaman utama (HomeScreen) menggunakan Navigator.pushReplacement.

3. Halaman Utama (home_screen.dart) Halaman ini berfungsi menampilkan daftar seluruh buku yang diambil dari API read.php.
   Menggunakan FutureBuilder atau inisialisasi pada initState, aplikasi mengambil data JSON dan menampilkannya dalam bentuk daftar gulir (ListView).
   Pada bagian Action Bar, terdapat judul aplikasi "Inventaris Buku Audimart". Halaman ini juga menyediakan tombol navigasi untuk menambah buku baru serta ikon hapus dan edit pada setiap item buku.

4. Halaman Formulir (form_buku_screen.dart) File ini adalah halaman dinamis yang digunakan untuk dua keperluan sekaligus: menambah buku baru dan mengedit buku lama.
   Logikanya terletak pada pengecekan data awal (widget.dataAwal). Jika data awal kosong, form berfungsi sebagai "Tambah" dan akan menembak API create.php.
   Jika data awal terisi, form berfungsi sebagai "Edit", mengisi kolom input secara otomatis, dan akan menembak API update.php dengan menyertakan ID buku tersebut.
