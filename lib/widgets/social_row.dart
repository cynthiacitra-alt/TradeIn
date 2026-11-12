import 'package:flutter/material.dart';
import 'package:tradein/core/constants.dart';
import '../core/constants.dart';

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});
  @override
  Widget build(BuildContext context) {
    Widget b(Widget child) => InkWell(
          onTap: () => toast(context, 'Login sosial belum tersambung (demo)'),
          child: Container(
            width: 46, height: 46, alignment: Alignment.center,
            decoration: BoxDecoration(color: kBeige, borderRadius: BorderRadius.circular(12)),
            child: child,
          ),
        );
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      b(const Text('G', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800))),
      const SizedBox(width: 16),
      b(const Icon(Icons.apple, size: 26)),
    ]);
  }
}