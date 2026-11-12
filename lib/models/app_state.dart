import 'package:flutter/material.dart';

class Item {
  final String name, desc, cat, user;
  const Item(this.name, this.desc, this.cat, this.user);
}

class Account {
  final String username, email, password;
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
    const Item('Jaket Denim Bekas', 'Ukuran L, kondisi 90%, warna biru tua. Mau ditukar dengan sepatu.', 'Fashion', 'rina'),
    const Item('Kemeja Flanel', 'Ukuran M, motif kotak merah, bahan tebal dan nyaman.', 'Fashion', 'sari'),
    const Item('Sepatu Sneakers Putih', 'Ukuran 42, dipakai 3 bulan, sol masih tebal.', 'Fashion', 'doni'),
    const Item('Tas Ransel Kanvas', 'Muat laptop 14 inci, ada 3 resleting, warna hitam.', 'Fashion', 'lia'),
    const Item('Hoodie Oversize', 'Ukuran XL, bahan fleece, warna abu-abu. Mau ditukar dengan jaket.', 'Fashion', 'bayu'),

    // Furniture
    const Item('Kursi Kayu Minimalis', 'Kayu jati, kokoh, tinggi 85 cm. Pemakaian 1 tahun.', 'Furniture', 'dani'),
    const Item('Meja Belajar Lipat', 'Ukuran 80x50 cm, ringan, mudah disimpan.', 'Furniture', 'tika'),
    const Item('Rak Buku 4 Susun', 'Bahan kayu MDF, tinggi 120 cm, kondisi mulus.', 'Furniture', 'hadi'),
    const Item('Lampu Tidur Rotan', 'Cahaya hangat, kabel 2 meter, cocok untuk kamar.', 'Furniture', 'mira'),

    // Kebersihan
    const Item('Sapu Listrik', 'Baterai awet, lengkap dengan charger. Mau ditukar dengan vacuum.', 'Kebersihan', 'wati'),
    const Item('Vacuum Cleaner Mini', 'Daya hisap kuat, cocok untuk mobil dan kasur.', 'Kebersihan', 'reza'),
    const Item('Set Pel Putar', 'Ember dan tongkat pel putar, 2 kain pel cadangan.', 'Kebersihan', 'yuni'),

    // Beauty
    const Item('Set Skincare Baru', 'Isi 4 produk, masih segel, cocok untuk kulit normal.', 'Beauty', 'nina'),
    const Item('Palet Eyeshadow', '12 warna natural, baru dipakai 2 kali.', 'Beauty', 'dewi'),
    const Item('Hair Dryer Lipat', 'Daya 1200 watt, 3 level panas, praktis dibawa.', 'Beauty', 'sinta'),

    // ATK
    const Item('Buku Tulis Premium', 'Isi 100 lembar, kertas tebal, cover hardcase.', 'ATK', 'ari'),
    const Item('Set Spidol Warna', '24 warna, tinta tidak tembus, masih baru.', 'ATK', 'fitri'),
    const Item('Kalkulator Scientific', 'Cocok untuk kuliah teknik, layar jelas, baterai baru.', 'ATK', 'andi'),

    // Elektronik
    const Item('Laptop Core i5', 'RAM 8 GB, SSD 256 GB, baterai masih tahan 4 jam. Mau ditukar dengan tablet.', 'Elektronik', 'budi'),
    const Item('Headphone Bluetooth', 'Baterai 20 jam, suara jernih, lengkap dengan kabel.', 'Elektronik', 'kevin'),
    const Item('Power Bank 20.000 mAh', 'Dua port USB, fast charging, kondisi sehat.', 'Elektronik', 'lisa'),

    // Olahraga
    const Item('Dumbbell 5 Kg', 'Sepasang, bahan karet anti slip, jarang dipakai.', 'Olahraga', 'fajar'),
    const Item('Matras Yoga', 'Tebal 8 mm, anti slip, warna ungu. Mau ditukar dengan skipping rope.', 'Olahraga', 'rani'),
    const Item('Raket Badminton', 'Satu raket ringan, senar baru diganti, plus tas.', 'Olahraga', 'agus'),
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

  void toggleInterest(String n) {
    interests.contains(n) ? interests.remove(n) : interests.add(n);
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