import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'models/app_state.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/tipe.dart';
import 'screens/main_shell.dart';

void main() => runApp(const TradeInApp());

class TradeInApp extends StatelessWidget {
  const TradeInApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'TradeIn',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: kBtn,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const Root(),
      );
}

class Root extends StatefulWidget {
  const Root({super.key});
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int stage = 0; // 0 login, 1 signup, 2 tipe, 3 home sementara
  void go(int s) => setState(() => stage = s);

  @override
  Widget build(BuildContext context) {
    switch (stage) {
      case 1:
        return SignupScreen(go: go);
      case 2:
        return Tipe(go: go);
      case 3:
          return const MainShell();
      default:
        return LoginScreen(go: go);
    }
  }
}