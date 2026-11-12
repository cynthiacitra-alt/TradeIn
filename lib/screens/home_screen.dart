import 'package:flutter/material.dart';

import '../core/constants.dart';
import '../models/app_state.dart';
import '../widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cat = 'Semua';

  @override
  Widget build(BuildContext context) {
    final cats = ['Semua', ...categories.keys];
    return ListenableBuilder(
      listenable: app,
      builder: (context, _) {
        final list = app.items
            .where((i) => cat == 'Semua' || i.cat == cat)
            .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(14, 10, 14, 4),
              child: Text(
                'Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),

            LayoutBuilder(
              builder: (context, box) {
                final fs = (box.maxWidth / 390 * 14).clamp(13.0, 17.0); 
                final pad = (box.maxWidth * 0.04).clamp(12.0, 32.0);
                const gap = 8.0;
                final avail = box.maxWidth - pad * 2;

                Widget chip(String c, {bool expand = false}) {
                  final on = c == cat;
                  return GestureDetector(
                    onTap: () => setState(() => cat = c),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      alignment: expand ? Alignment.center : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: fs,
                        vertical: fs * .55,
                      ),
                      decoration: BoxDecoration(
                        color: on ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: on ? kGold : Colors.black26),
                      ),
                      child: Text(
                        c,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: fs,
                          fontWeight: on ? FontWeight.w800 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }

                // ukur chip terpanjang untuk menentukan apakah semuanya muat satu baris
                double longest = 0;
                for (final c in cats) {
                  final tp = TextPainter(
                    text: TextSpan(
                      text: c,
                      style: TextStyle(
                        fontSize: fs,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    textDirection: TextDirection.ltr,
                  )..layout();
                  if (tp.width > longest) longest = tp.width;
                }
                final chipW = longest + fs * 2 + 4;
                final fits =
                    chipW * cats.length + gap * (cats.length - 1) <= avail;

                return Container(
                  width: double.infinity,
                  color: kBeige,
                  padding: EdgeInsets.symmetric(horizontal: pad, vertical: 10),
                  child: fits
                      // muat satu baris -> dibagi rata memenuhi lebar layar
                      ? Row(
                          children: [
                            for (var i = 0; i < cats.length; i++) ...[
                              if (i > 0) const SizedBox(width: gap),
                              Expanded(child: chip(cats[i], expand: true)),
                            ],
                          ],
                        )
                      // tidak muat -> turun ke baris berikutnya
                      : Wrap(
                          spacing: gap,
                          runSpacing: gap,
                          children: cats.map((c) => chip(c)).toList(),
                        ),
                );
              },
            ),
            Expanded(
              child: list.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada barang di kategori ini.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : itemGrid(list),
            ),
          ],
        );
      },
    );
  }
}
