import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecretField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;

  const SecretField({
    super.key,
    required this.label,
    required this.controller,
    required this.obscure,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
              onPressed: onToggle,
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: controller.text));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$label copied')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
