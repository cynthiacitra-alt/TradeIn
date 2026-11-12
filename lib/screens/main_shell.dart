import 'package:flutter/material.dart';
import '../core/constants.dart';
import 'home_screen.dart';

/// Kerangka utama: isi layar + navigasi bawah (5 tab).
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int idx = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomeScreen(),
      const _Soon('Search'),
      const _Soon('Posting'),
      const _Soon('Notifikasi'),
      const _Soon('Account'),
    ];
    const icons = [Icons.home_outlined, Icons.search, Icons.add_circle_outline, Icons.sync, Icons.account_circle_outlined];
    const active = [Icons.home, Icons.search, Icons.add_circle, Icons.sync, Icons.account_circle];

    return Scaffold(
      body: SafeArea(bottom: false, child: IndexedStack(index: idx, children: pages)),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: kBeige,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (i) => IconButton(
                    onPressed: () => setState(() => idx = i),
                    icon: Icon(idx == i ? active[i] : icons[i], size: 26),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

/// Placeholder untuk tab yang belum dibuat.
class _Soon extends StatelessWidget {
  final String name;
  const _Soon(this.name);
  @override
  Widget build(BuildContext context) => Center(
        child: Text('$name (segera dibuat)', style: const TextStyle(color: Colors.grey)),
      );
}