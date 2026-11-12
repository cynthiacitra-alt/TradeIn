import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/app_state.dart';
import '../widgets/app_button.dart';

class Tipe extends StatelessWidget {
  final void Function(int) go;
  const Tipe({super.key, required this.go});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListenableBuilder(
            listenable: app,
            builder: (context, _) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Row(children: [
                    IconButton(onPressed: () => go(1), icon: const Icon(Icons.arrow_back)),
                    Expanded(
                      child: Row(
                        children: List.generate(3, (i) {
                          final filled = app.interests.length > i; // garis ke-i terisi?
                          return Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              height: 4,
                              margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
                              decoration: BoxDecoration(
                                color: filled ? Colors.black : const Color(0xFFE5E5E5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ]),
                const SizedBox(height: 14),
                const Text('Pilih minat anda', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 14),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: 1.35,
                    children: categories.entries.map((e) {
                      final sel = app.interests.contains(e.key);
                      return InkWell(
                        onTap: () => app.toggleInterest(e.key),
                        child: Container(
                          decoration: BoxDecoration(
                            color: sel ? const Color(0xFFE6D8B8) : kBeige,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: sel ? kGold : const Color(0xFFD9D9D9), width: 2),
                          ),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Icon(e.value, size: 38),
                            const SizedBox(height: 6),
                            Text(e.key, style: const TextStyle(fontSize: 12)),
                          ]),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                AppButton('Continue', () {
                  if (app.interests.isEmpty) return toast(context, 'Pilih minimal satu minat');
                  app.saveInterests(); // simpan minat ke akun
                  go(3);
                }, color: kGold),
              ]),
            ),
          ),
        ),
      );
}