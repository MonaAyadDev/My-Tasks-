import 'package:flutter/material.dart';

class MainFormField extends StatelessWidget {
  const MainFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.label,
    this.hint,
    this.prefixIcon,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
