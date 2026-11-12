import 'package:flutter/material.dart';
import 'package:tradein/core/constants.dart';
import '../core/constants.dart';

class AppField extends StatefulWidget {
  final String hint;
  final TextEditingController ctrl;
  final bool password;
  final TextInputType? type;
  const AppField(this.hint, this.ctrl, {super.key, this.password = false, this.type});
  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  bool hide = true;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: widget.ctrl,
          obscureText: widget.password && hide,
          keyboardType: widget.type,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: widget.hint,
            filled: true,
            fillColor: kField,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            suffixIcon: widget.password
                ? IconButton(
                    icon: Icon(hide ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20),
                    onPressed: () => setState(() => hide = !hide))
                : null,
          ),
        ),
      );
}