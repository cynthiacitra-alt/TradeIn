import 'package:flutter/material.dart';
import 'package:tradein/core/constants.dart';
import '../core/constants.dart'; // ../ ini untuk mengakses file constants.dart yang berada di folder core, karena file ini berada di folder widgets

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color fg;
  const AppButton(this.text, this.onTap, {super.key, this.color = kBtn, this.fg = Colors.white});
  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 46,
        child: FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: color, foregroundColor: fg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          onPressed: onTap,
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      );
}