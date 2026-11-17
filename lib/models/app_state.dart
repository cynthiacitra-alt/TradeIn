import 'package:flutter/material.dart';

class Item {
  final String name, kondisi, status, cat, user;
  const Item(this.name, this.kondisi, this.status, this.cat, this.user);
}

class Account {
  String username;
  final String email, password;
  final Set<String> interests = {}; // minat yang sudah disimpan
  Account(this.username, this.email, this.password);
}

class AppState extends ChangeNotifier {
  String user = '';
  Account? current; // akun yang sedang login
  final Set<String> interests = {};
  final Set<String> likes = {};

  final List<Account> accounts = [
    Account('demo', 'demo@mail.com', '123456'), // akun contoh untuk tes
  ];

  final List<Item> items = [
    // Fashion
    const Item(
      'Jaket Denim Bekas',
      'Baru, Ukuran L, kondisi 90%, warna biru tua. Mau ditukar dengan sepatu.',
      'tersedia',
      'Fashion',
      'rina',
    ),
    const Item(
      'Kemeja Flanel',
      'Bekas Layak, Ukuran M, motif kotak merah, bahan tebal dan nyaman.',
      'tersedia',
      'Fashion',
      'sari',
    ),
    const Item(
      'Sepatu Sneakers Putih',
      'Baru, Ukuran 42, dipakai 3 bulan, sol masih tebal.',
      'tersedia',
      'Fashion',
      'doni',
    ),
    const Item(
      'Tas Ransel Kanvas',
      'Bekas Layak, Muat laptop 14 inci, ada 3 resleting, warna hitam.',
      'tidak tersedia',
      'Fashion',
      'lia',
    ),
    const Item(
      'Hoodie Oversize',
      'Bekas Layak, Ukuran XL, bahan fleece, warna abu-abu. Mau ditukar dengan jaket.',
      'tersedia',
      'Fashion',
      'bayu',
    ),

    // Furniture
    const Item(
      'Kursi Kayu Minimalis',
      'Bekas Layak, Kayu jati, kokoh, tinggi 85 cm. Pemakaian 1 tahun.',
      'tersedia',
      'Furniture',
      'dani',
    ),
    const Item(
      'Meja Belajar Lipat',
      'Baru, Ukuran 80x50 cm, ringan, mudah disimpan.',
      'tidak tersedia',
      'Furniture',
      'tika',
    ),
    const Item(
      'Rak Buku 4 Susun',
      'Baru, Bahan kayu MDF, tinggi 120 cm, kondisi mulus.',
      'tersedia',
      'Furniture',
      'hadi',
    ),
    const Item(
      'Lampu Tidur Rotan',
      'Bekas Layak, Cahaya hangat, kabel 2 meter, cocok untuk kamar.',
      'tersedia',
      'Furniture',
      'mira',
    ),

    // Kebersihan
    const Item(
      'Sapu Listrik',
      'Bekaas Layak, Baterai awet, lengkap dengan charger. Mau ditukar dengan vacuum.',
      'tersedia',
      'Kebersihan',
      'wati',
    ),
    const Item(
      'Vacuum Cleaner Mini',
      'Baru, Daya hisap kuat, cocok untuk mobil dan kasur.',
      'tidak tersedia',
      'Kebersihan',
      'reza',
    ),
    const Item(
      'Set Pel Putar',
      'Baru, Ember dan tongkat pel putar, 2 kain pel cadangan.',
      'tersedia',
      'Kebersihan',
      'yuni',
    ),

    // Beauty
    const Item(
      'Set Skincare Baru',
      'Baru, Isi 4 produk, masih segel, cocok untuk kulit normal.',
      'tersedia',
      'Beauty',
      'nina',
    ),
    const Item(
      'Palet Eyeshadow',
      'Baru, 12 warna natural, baru dipakai 2 kali.',
      'tersedia',
      'Beauty',
      'dewi',
    ),
    const Item(
      'Hair Dryer Lipat',
      'Bekas Layak, Daya 1200 watt, 3 level panas, praktis dibawa.',
      'tidak tersedia',
      'Beauty',
      'sinta',
    ),

    // ATK
    const Item(
      'Buku Tulis Premium',
      'bekas Layak, Isi 100 lembar, kertas tebal, cover hardcase.',
      'tersedia',
      'ATK',
      'ari',
    ),
    const Item(
      'Set Spidol Warna',
      'Baru, 24 warna, tinta tidak tembus, masih baru.',
      'tersedia',
      'ATK',
      'fitri',
    ),
    const Item(
      'Kalkulator Scientific',
      'Baru, Cocok untuk kuliah teknik, layar jelas, baterai baru.',
      'tersedia',
      'ATK',
      'andi',
    ),

    // Elektronik
    const Item(
      'Laptop Core i5',
      'Bekas Layak, RAM 8 GB, SSD 256 GB, baterai masih tahan 4 jam. Mau ditukar dengan tablet.',
      'tersedia',
      'Elektronik',
      'budi',
    ),
    const Item(
      'Headphone Bluetooth',
      'Bekas Layak, Baterai 20 jam, suara jernih, lengkap dengan kabel.',
      'tidak tersedia',
      'Elektronik',
      'kevin',
    ),
    const Item(
      'Power Bank 20.000 mAh',
      'Bekas Layak, Dua port USB, fast charging, kondisi sehat.',
      'tersedia',
      'Elektronik',
      'lisa',
    ),

    // // Olahraga
    // const Item(
    //   'Dumbbell 5 Kg',
    //   'Sepasang, bahan karet anti slip, jarang dipakai.',
    //   'tersedia',
    //   'Olahraga',
    //   'fajar',
    // ),
    // const Item(
    //   'Matras Yoga',
    //   'Tebal 8 mm, anti slip, warna ungu. Mau ditukar dengan skipping rope.',
    //   'tersedia'
    //       'Olahraga',
    //   'rani',
    // ),
    // const Item(
    //   'Raket Badminton',
    //   'Satu raket ringan, senar baru diganti, plus tas.',
    //   'tersedia',
    //   'Olahraga',
    //   'agus',
    // ),
  ];

  // cari akun berdasarkan username atau email
  Account? find(String id) {
    final k = id.toLowerCase();
    for (final a in accounts) {
      if (a.username.toLowerCase() == k || a.email.toLowerCase() == k) return a;
    }
    return null;
  }

  // daftar akun baru, false kalau username/email sudah dipakai
  bool register(String username, String email, String password) {
    if (find(username) != null || find(email) != null) return false;
    accounts.add(Account(username, email, password));
    return true;
  }

  void login(Account a) {
    current = a;
    user = a.username;
    interests
      ..clear()
      ..addAll(a.interests);
    notifyListeners();
  }

  // UPDATE: ubah username saja. Mengembalikan pesan error, atau null kalau berhasil
  String? updateUsername(String username) {
    final me = current;
    if (me == null) return 'Belum login';
    final u = find(username);
    if (u != null && u != me) return 'Username sudah dipakai';
    me.username = username;
    user = username;
    notifyListeners();
    return null;
  }

  // DELETE: hapus akun yang sedang login
  void deleteAccount() {
    accounts.remove(current);
    logout();
  }

  void logout() {
    current = null;
    user = '';
    interests.clear();
    notifyListeners();
  }

  void toggleInterest(String n) {
    interests.contains(n) ? interests.remove(n) : interests.add(n);
    notifyListeners();
  }

  // CREATE: tambah barang baru ke daftar (tampil paling atas di Home)
  void addItem(Item item) {
    items.insert(0, item);
    notifyListeners();
  }

  void saveInterests() {
    current?.interests
      ?..clear()
      ..addAll(interests);
    notifyListeners();
  }

  void toggleLike(String name) {
    likes.contains(name) ? likes.remove(name) : likes.add(name);
    notifyListeners();
  }
}

final app = AppState();
