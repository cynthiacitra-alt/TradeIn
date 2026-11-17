import 'package:flutter/material.dart';

import '../core/constants.dart';
import '../models/app_state.dart';

/// Layar Account: profil (Read), edit username (Update), hapus akun (Delete),
/// tambah barang (Create), daftar barang saya, dan barang yang disukai.
class AccountScreen extends StatelessWidget {
  final VoidCallback onLogout; // kembali ke layar Login
  const AccountScreen({super.key, required this.onLogout});

  // ===================== TAMBAH BARANG (Create) =====================
  void _add(BuildContext context) {
    final name = TextEditingController();
    final desc = TextEditingController();
    String cat = categories.keys.first;
    String? nErr, dErr;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Tambah Barang',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: 'Nama barang',
                    errorText: nErr,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: desc,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText:
                        'Deskripsi (kondisi, ukuran, mau ditukar dengan apa)',
                    alignLabelWithHint: true,
                    errorText: dErr,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: cat,
                      isExpanded: true,
                      isDense: true,
                      items: categories.keys
                          .map(
                            (c) => DropdownMenuItem(value: c, child: Text(c)),
                          )
                          .toList(),
                      onChanged: (v) => setS(() => cat = v!),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: kGold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      final n = name.text.trim(), d = desc.text.trim();
                      // validasi: pesan error muncul tepat di bawah kolom
                      setS(() {
                        nErr = n.length < 3
                            ? 'Nama barang minimal 3 huruf'
                            : null;
                        dErr = d.length < 10
                            ? 'Deskripsi minimal 10 huruf'
                            : null;
                      });
                      if (nErr != null || dErr != null) return;

                      app.addItem(Item(n, d, 'tersedia', cat, app.user));
                      Navigator.pop(ctx);
                      toast(context, 'Barang berhasil ditambahkan');
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===================== UPDATE (username) =====================
  void _edit(BuildContext context) {
    final me = app.current;
    if (me == null) return;
    final u = TextEditingController(text: me.username);
    String? uErr;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: const Text('Edit profil'),
          content: TextField(
            controller: u,
            decoration: InputDecoration(labelText: 'Username', errorText: uErr),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: kBtn),
              onPressed: () {
                final nu = u.text.trim();
                if (nu.isEmpty)
                  return setS(() => uErr = 'Username wajib diisi');
                final err = app.updateUsername(nu);
                if (err != null) return setS(() => uErr = err);
                Navigator.pop(ctx);
                toast(context, 'Profil berhasil diperbarui');
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  // ===================== DELETE =====================
  void _delete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus akun?'),
        content: const Text(
          'Akun Anda akan dihapus permanen dan Anda tidak bisa login lagi dengan akun ini.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              Navigator.pop(ctx);
              app.deleteAccount();
              toast(context, 'Akun berhasil dihapus');
              onLogout();
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final pad = (w * 0.05).clamp(16.0, 32.0);

    return ListenableBuilder(
      listenable: app,
      builder: (context, _) {
        final me = app.current;
        final mine = app.items.where((i) => i.user == app.user).toList();
        final liked = app.items
            .where((i) => app.likes.contains(i.name))
            .toList();

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView(
              padding: EdgeInsets.all(pad),
              children: [
                const SizedBox(height: 12),
                // ===== READ: data profil =====
                const Center(
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: kBeige,
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: 70,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    me?.username ?? '-',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    me?.email ?? '-',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 20),

                // ===== tombol-tombol =====
                _Btn(
                  Icons.add_circle_outline,
                  'Tambah barang',
                  kGold,
                  Colors.white,
                  () => _add(context),
                ),
                const SizedBox(height: 10),
                _Btn(
                  Icons.edit_outlined,
                  'Edit profil',
                  kBtn,
                  Colors.white,
                  () => _edit(context),
                ),
                const SizedBox(height: 10),
                _Btn(Icons.logout, 'Keluar', kBeige, Colors.black87, () {
                  app.logout();
                  toast(context, 'Anda sudah keluar');
                  onLogout();
                }),
                const SizedBox(height: 10),
                _Btn(
                  Icons.delete_outline,
                  'Hapus akun',
                  const Color(0xFFFDE3E3),
                  Colors.redAccent,
                  () => _delete(context),
                ),

                // ===== barang saya =====
                const SizedBox(height: 24),
                Text(
                  'Barang saya (${mine.length})',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                if (mine.isEmpty)
                  const _Empty(
                    'Belum ada barang.\nTekan "Tambah barang" untuk mengunggah.',
                  )
                else
                  ...mine.map(
                    (i) => _Row(
                      i,
                      trailing: const Icon(
                        Icons.inventory_2_outlined,
                        size: 20,
                      ),
                    ),
                  ),

                // ===== barang yang disukai =====
                const SizedBox(height: 24),
                Text(
                  'Barang yang Anda sukai (${liked.length})',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                if (liked.isEmpty)
                  const _Empty(
                    'Belum ada barang yang disukai.\nKetuk ikon love di Home untuk menambah.',
                  )
                else
                  ...liked.map(
                    (i) => _Row(
                      i,
                      trailing: const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color bg, fg;
  final VoidCallback onTap;
  const _Btn(this.icon, this.text, this.bg, this.fg, this.onTap);

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 46,
    child: FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    ),
  );
}

class _Row extends StatelessWidget {
  final Item item;
  final Widget trailing;
  const _Row(this.item, {required this.trailing});

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: kPh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.image_outlined, color: Colors.grey),
    ),
    title: Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
    subtitle: Text(item.cat),
    trailing: trailing,
  );
}

class _Empty extends StatelessWidget {
  final String text;
  const _Empty(this.text);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.grey),
      ),
    ),
  );
}
