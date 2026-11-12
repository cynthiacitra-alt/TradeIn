import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/app_state.dart';

/// Kartu satu barang. [fs] = ukuran huruf dasar, ikut lebar kartu.
class ItemCard extends StatelessWidget {
  final Item item;
  final double fs;
  const ItemCard(this.item, {super.key, this.fs = 13});

  @override
  Widget build(BuildContext context) {
    final liked = app.likes.contains(item.name);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // gambar: rasio 4:3 supaya tidak terlalu besar
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Stack(children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(color: kPh, borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.image_outlined, color: Colors.grey, size: fs * 2.4),
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: InkWell(
                onTap: () => app.toggleLike(item.name),
                child: Container(
                  padding: EdgeInsets.all(fs * .3),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(6)),
                  child: Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    size: fs * 1.1,
                    color: liked ? Colors.redAccent : Colors.white,
                  ),
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 6),
        // judul
        Text(item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: fs + 1, fontWeight: FontWeight.w700, height: 1.3)),
        const SizedBox(height: 2),
        // deskripsi (maksimal 2 baris)
        Text(item.desc,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: fs - 1, height: 1.3, color: Colors.black87)),
        const Spacer(),
        // penjual
        Row(children: [
          Icon(Icons.account_circle_outlined, size: fs + 1, color: Colors.black54),
          const SizedBox(width: 4),
          Expanded(
            child: Text('@${item.user}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: fs - 1, color: Colors.black54)),
          ),
        ]),
      ]),
    );
  }
}

/// Grid barang: jumlah kolom, ukuran huruf, dan tinggi kartu ikut lebar layar.
Widget itemGrid(List<Item> list) => LayoutBuilder(
      builder: (context, box) {
        final pad = (box.maxWidth * 0.04).clamp(12.0, 32.0);
        const gap = 12.0;
        const maxCard = 200.0; // lebar kartu maksimal

        final avail = box.maxWidth - pad * 2;
        final cols = ((avail + gap) / (maxCard + gap)).ceil().clamp(2, 8);
        final cardW = (avail - gap * (cols - 1)) / cols;

        // huruf ikut lebar kartu, dibatasi 12 sampai 15
        final fs = (cardW / 160 * 12).clamp(12.0, 15.0);

        // tinggi kartu = padding + gambar 4:3 + teks (judul, 2 baris deskripsi, penjual)
        final imageH = (cardW - 16) * 3 / 4;
        final textH = fs * 1.3 * 5 + 6 + 2 + 8; // 5 baris teks + jarak
        final cardH = 16 + imageH + textH;

        return GridView.builder(
          padding: EdgeInsets.all(pad),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            mainAxisSpacing: gap,
            crossAxisSpacing: gap,
            mainAxisExtent: cardH,
          ),
          itemCount: list.length,
          itemBuilder: (_, i) => ItemCard(list[i], fs: fs),
        );
      },
    );