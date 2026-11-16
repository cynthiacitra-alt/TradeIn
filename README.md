# TradeIn

## Deskripsi
TradeIn adalah platform untuk saling menukar barang bekas yang masih layak pakai tanpa transaksi uang tunai. Aplikasi ini ditujukan untuk mahasiswa dan anak kos usia 18–24 tahun yang membutuhkan barang layak pakai dengan bujet terbatas, serta punya barang bekas yang masih bernilai guna.

## Struktur Proyek
```
lib/
├── main.dart
├── core/
│   └── constants.dart
├── models/
│   └── app_state.dart
├── widgets/
│   ├── app_field.dart
│   ├── app_button.dart
│   ├── social_row.dart
│   └── item_card.dart
└── screens/
    ├── login_screen.dart
    ├── signup_screen.dart
    ├── tipe_screen.dart
    ├── main_shell.dart
    ├── home_screen.dart
    ├── detail_screen.dart
    └── account_screen.dart
```

## Daftar Screen
- Login
- Sign up
- Pilih minat (hanya tampil sekali setelah Sign up)
- Home (daftar barang)
- Detail barang
- Account (profil dan daftar barang yang disukai)

## Model Data
Item:
- nama
- kategori
- penjual
- deskripsi
- foto (placeholder)

Account:
- username
- email
- password

## Sumber Data
Data sementara di memori aplikasi menggunakan List dan mock data. Data kembali ke kondisi awal setiap aplikasi dijalankan ulang.

## Fitur
- Login dengan email atau username dan password, lengkap dengan validasi dan pesan error.
- Sign up dengan validasi username, email, dan password (Create).
- Pilih minat kategori untuk pengguna baru.
- Home menampilkan daftar barang dalam grid 3 kolom dengan filter kategori (Read).
- Halaman Detail barang berisi foto, nama, kategori, penjual, dan deskripsi lengkap (Read).
- Fitur suka (love) yang tersinkron di Home, Detail, dan Account.
- Account untuk melihat profil (Read), edit username (Update), hapus akun (Delete), dan keluar.
- Empty state saat kategori kosong atau belum ada barang yang disukai.
- Toast sebagai user feedback.

## Cara Menjalankan
Prasyarat: Flutter SDK 3.x dan Google Chrome.
```
flutter pub get
flutter run -d chrome
```

Akun contoh untuk mencoba tanpa mendaftar:
- Username: `demo` (atau email `demo@mail.com`)
- Password: `123456`

Akun `demo` langsung masuk ke Home. Untuk melihat layar Pilih minat, buat akun baru lewat Sign up.

## Skenario Uji
- Login dengan akun demo berhasil dan validasi error tampil saat input salah.
- Sign up akun baru lalu tampil layar Pilih minat.
- Daftar barang tampil di Home dan filter kategori berjalan.
- Buka halaman Detail barang.
- Tombol love tersinkron di Home, Detail, dan Account.
- Edit username di Account.
- Hapus akun di Account.
- Empty state saat kategori kosong atau belum ada barang yang disukai.

## Kendala
untuk kendala sendiri saya sering lupa menambahkan import pada main_shell.dart ketika saya sedang menambahkan file baru, lalu pada bagian create, login saya sempat bingung untuk bagian pesan error itu kok tidak muncul ketika saya salah memasukkan password dan sempet salah alur juga harusnya sehabis login itu langsung ke screen home nah itu kemarin sebelum di perbaiki malah ke tipe jadi yang seharusnya tipe ini ada waktu sebelum kita punya akun atau setelah kita sign up baru muncul screen tipe, ini malah setiap login selalu ke screen tipe.

## Bukti Running


## Catatan Penggunaan AI
saya menggunakan AI untuk membantu saya terkait kendala kendala yang sempat saya alami di atas dan membantu saya dalam membuat struktur proyek juga.

## Catatan Keamanan Data
Data yang digunakan merupakan data simulasi dan tidak memuat data pribadi nyata, API key, token, password, credential, atau data sensitif.