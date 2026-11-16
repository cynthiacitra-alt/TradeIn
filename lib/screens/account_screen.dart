import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/app_state.dart';

/// Layar Account: lihat profil (Read), edit profil (Update),
/// hapus akun (Delete), dan keluar.
class AccountScreen extends StatelessWidget {
  final VoidCallback onLogout; // kembali ke layar Login
  const AccountScreen({super.key, required this.onLogout});

  // ===================== UPDATE =====================
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
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: kBtn),
              onPressed: () {
                final nu = u.text.trim();
                if (nu.isEmpty) {
                  return setS(() => uErr = 'Username wajib diisi');
                }
                final err = app.updateUsername(nu);
                if (err != null) {
                  return setS(() => uErr = err);
                }
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
        content: const Text('Akun Anda akan dihapus permanen dan Anda tidak bisa login lagi dengan akun ini.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
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
        final liked = app.items.where((i) => app.likes.contains(i.name)).toList();

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView(
              padding: EdgeInsets.all(pad),
              children: [
                const SizedBox(height: 12),
                // ===== READ: tampilkan data profil =====
                const Center(
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: kBeige,
                    child: Icon(Icons.account_circle_outlined, size: 70, color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(me?.username ?? '-',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                ),
                Center(
                  child: Text(me?.email ?? '-', style: const TextStyle(color: Colors.black54)),
                ),
                const SizedBox(height: 20),

                _Btn(Icons.edit_outlined, 'Edit profil', kBtn, Colors.white, () => _edit(context)),
                const SizedBox(height: 10),
                _Btn(Icons.logout, 'Keluar', kBeige, Colors.black87, () {
                  app.logout();
                  toast(context, 'Anda sudah keluar');
                  onLogout();
                }),
                const SizedBox(height: 10),
                _Btn(Icons.delete_outline, 'Hapus akun', const Color(0xFFFDE3E3), Colors.redAccent, () => _delete(context)),

                const SizedBox(height: 24),
                Text('Barang yang Anda sukai (${liked.length})',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),

                // ===== empty state =====
                if (liked.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text('Belum ada barang yang disukai.\nKetuk ikon love di Home untuk menambah.',
                          textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                    ),
                  )
                else
                  ...liked.map((i) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(color: kPh, borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.image_outlined, color: Colors.grey),
                        ),
                        title: Text(i.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                        subtitle: Text('@${i.user}'),
                        trailing: const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                      )),
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