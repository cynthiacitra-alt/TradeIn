import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/app_state.dart';
import '../widgets/app_field.dart';
import '../widgets/app_button.dart';
import '../widgets/social_row.dart';

class SignupScreen extends StatefulWidget {
  final void Function(int) go;
  const SignupScreen({super.key, required this.go});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final u = TextEditingController(), m = TextEditingController(), p = TextEditingController();

    void submit() {
    if (u.text.trim().isEmpty || m.text.trim().isEmpty || p.text.isEmpty) {
      return toast(context, 'Lengkapi semua kolom');
    }
    if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(m.text.trim())) { 
      return toast(context, 'Format email tidak valid');
    }
    if (p.text.length < 6) return toast(context, 'Password minimal 6 karakter');
    if (!app.register(u.text.trim(), m.text.trim(), p.text)) {
      return toast(context, 'Username atau email sudah terdaftar');
    }
    app.login(app.find(u.text.trim())!);
    widget.go(2); // akun baru -> ke Tipe
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(children: [
              const SizedBox(height: 80),
              const Text('Create Account', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
              const SizedBox(height: 36),
              AppField('Username', u),
              AppField('Email', m, type: TextInputType.emailAddress),
              AppField('Password', p, password: true),
              const SizedBox(height: 20),
              AppButton('Sign Up', submit),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Already have an account? ', style: TextStyle(fontSize: 13)),
                GestureDetector(
                  onTap: () => widget.go(0),
                  child: const Text('Log In', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                ),
              ]),
              const SizedBox(height: 30),
              const SocialRow(),
            ]),
          ),
        ),
      );
}