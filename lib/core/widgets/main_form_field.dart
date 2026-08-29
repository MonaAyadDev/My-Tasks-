import 'package:flutter/material.dart';

class MainFormField extends StatelessWidget {
  const MainFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.label,
    this.hint,
    this.prefixIcon,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}