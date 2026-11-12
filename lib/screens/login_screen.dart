import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/app_state.dart';
import '../widgets/app_field.dart';
import '../widgets/app_button.dart';
import '../widgets/social_row.dart';

class LoginScreen extends StatefulWidget {
  final void Function(int) go;
  const LoginScreen({super.key, required this.go});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final u = TextEditingController(), p = TextEditingController();

   void submit() {
    final id = u.text.trim();
    if (id.isEmpty || p.text.isEmpty) {
      return toast(context, 'Isi email/username dan password');
    }
    final acc = app.find(id);
    if (acc == null) {
      return toast(context, 'Akun tidak ditemukan. Silakan Sign up dulu');
    }
    if (acc.password != p.text) {
      return toast(context, 'Password salah');
    }
    app.login(acc);
    widget.go(3); 
    // belum pernah pilih minat -> Tipe, sudah pernah -> langsung Home
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(children: [
              const SizedBox(height: 70),
              const Text('WELCOME', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
              const SizedBox(height: 40),
              AppField('Email or username', u),
              AppField('Password', p, password: true),
              const SizedBox(height: 20),
              AppButton('Login', submit),
              const SizedBox(height: 18),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Don’t have any account ? ', style: TextStyle(fontSize: 13)),
                GestureDetector(
                  onTap: () => widget.go(1),
                  child: const Text('Sign up', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                ),
              ]),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () => toast(context, 'Link reset password dikirim ke email (demo)'),
                child: const Text('Forgot password ?', style: TextStyle(fontSize: 13)),
              ),
              const SizedBox(height: 36),
              const SocialRow(),
            ]),
          ),
        ),
      );
}