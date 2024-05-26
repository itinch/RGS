import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) onSaved;
  final Function(String) onChanged;
  final String hintText;
  final String labelText;
  final Widget? icon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.onChanged,
    required this.hintText,
    required this.labelText,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        icon: icon,
        hintText: hintText,
        labelText: labelText,
      ),
      onChanged: onChanged,
      onSaved: onSaved,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }
}
