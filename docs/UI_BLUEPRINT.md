Nama Aplikasi:
TradeIn

Tema Aplikasi:
Barter & Swap Barang Bekas Mahasiswa (Thrifting & Sustainable Lifestyle)

Target Pengguna:
Mahasiswa dan anak kos yang ingin bertukar barang bekas layak pakai (seperti pakaian, perlengkapan kos, ATK, buku, dan elektronik) tanpa uang tunai.

Tujuan Aplikasi:
Memfasilitasi mahasiswa dalam bertukar barang bekas secara praktis melalui fitur swipe & match, katalog pencarian, serta sistem komunikasi interaktif.

Daftar Screen:

Login
Fungsi: Halaman autentikasi untuk masuk ke dalam akun pengguna.   Komponen: Header teks "WELCOME", TextField email/username, TextField password, tombol Login, link daftar/lupa password, dan tombol Login via Google & Apple.   

Create Account (Registrasi)
Fungsi: Halaman pendaftaran untuk pengguna baru.   
Komponen: Header teks "Create Account", TextField username, TextField email, TextField password, tombol Sign Up, link Login, dan tombol pendaftaran via Google & Apple.   

Pilih Minat / Kategori (Tipe)
Fungsi: Halaman preferensi awal untuk memilih kategori minat barang.   Komponen: Progress bar navigasi, instruksi "Pilih minat anda", grid kartu kategori (Fashion, Furnitur, Perabot, Beauty, ATK, Digital, Olahraga, Lainnya), dan tombol Continue.   

Home (Jelajah / Swipe)
Fungsi: Menampilkan katalog barang milik pengguna lain berbasis kategori dan mekanisme swipe/match.   
Komponen: Chip kategori (Semua, Fashion, Furnitur, ATK, dll.), grid kartu barang (foto, nama barang, ikon suka/simpan), dan Bottom Navigation Bar.   

Search (Pencarian)
Fungsi: Mencari barang spesifik atau melihat rekomendasi item.   
Komponen: Kolom pencarian (Search Bar) dengan tombol filter, teks "yang mungkin anda sukai", kartu rekomendasi barang, dan Bottom Navigation Bar.   

Posting (Buat Postingan / Tambah Barang)
Fungsi: Mengunggah foto atau video barang milik sendiri yang ingin dibarterkan.   
Komponen: Header "Buat Postingan", dropdown pilihan galeri/sumber media, tab filter media (Semua, Foto, Video), grid pemilih media galeri, dan Bottom Navigation Bar.   

Notification / Kotak Masuk
Fungsi: Menampilkan pemberitahuan aktivitas kecocokan (match) dan daftar percakapan barter.   
Komponen: Header "Kotak Masuk", menu "Suka dan Match", menu "Pesan" (Chat), dan Bottom Navigation Bar.   

Profil (Account)
Fungsi: Menampilkan identitas pengguna, pengaturan akun, dan daftar barang milik sendiri.   
Komponen: Foto profil, nama pengguna, tombol Edit Profil, ikon pengaturan/share, grid katalog barang pribadi, dan Bottom Navigation Bar.   

Alur Maju:Login → Create Account (Jika belum punya akun)   
Login → Home (Setelah berhasil login)   
Create Account → Pilih Minat (Tipe) → Home (Proses pendaftaran awal)   
Home → Search (Lewat ikon pencarian di Bottom Nav Bar)   
Home → Posting (Tambah Barang) (Lewat ikon tambah di Bottom Nav Bar)   
Home → Kotak Masuk (Notification) (Lewat ikon kotak masuk di Bottom Nav Bar)   
Home → Profil (Account) (Lewat ikon profil di Bottom Nav Bar)   
Posting → Simpan / Upload → Profil (Melihat barang yang baru ditambahkan)   
Kotak Masuk → Suka & Match / Pesan (Chat) (Membuka percakapan setelah mutual match)   
Alur Kembali:Create Account → Login   Pilih Minat → Create Account   Search → Home   Posting → Home   Kotak Masuk → Home   Profil → Home   Pesan (Chat) → Kotak Masuk