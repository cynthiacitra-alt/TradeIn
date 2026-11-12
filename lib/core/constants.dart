import 'package:flutter/material.dart';

// ===================== WARNA =====================
const kField = Color(0xFFCFDAC8);
const kCard = Color(0xFFCCD8C4);
const kBtn = Color(0xFF8FA38A);
const kGold = Color(0xFFC9A96A);
const kBeige = Color(0xFFEEEAE2);
const kPh = Color(0xFFEEEEEE);

const categories = <String, IconData>{
  'Fashion': Icons.checkroom,
  'Furniture': Icons.chair_outlined,
  'Kebersihan': Icons.cleaning_services_outlined,
  'Beauty': Icons.brush_outlined,
  'ATK': Icons.edit_outlined,
  'Elektronik': Icons.laptop_mac,
  'Olahraga': Icons.fitness_center,
  'Lainnya': Icons.more_horiz,
};

void toast(BuildContext c, String m) {
  ScaffoldMessenger.of(c)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(m), duration: const Duration(seconds: 2)));
}