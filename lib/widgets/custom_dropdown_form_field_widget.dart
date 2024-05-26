// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:rankgroupassignment/app/formatting.dart';
import 'package:rankgroupassignment/app/palette.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;
  final Function(String?) onSaved;
  final List<DropdownMenuItem<String>> items;
  final String labelText;
  final String? Function(String?)? validator;

  const CustomDropdownButtonFormField({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.onSaved,
    required this.items,
    required this.labelText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kSpacing8),
            ),
            filled: true,
            labelText: labelText,
            contentPadding:
                const EdgeInsets.fromLTRB(kSpacing8, 16.0, kSpacing8, 16.0),
          ),
          value: value,
          onChanged: (String? newValue) {
            onChanged(newValue);
          },
          onSaved: (String? newValue) {
            onSaved(newValue);
          },
          items: items,
          validator: validator,
        ),
        const Positioned(
          right: 8.0,
          top: 12.0,
          child: Icon(
            Icons.arrow_drop_down,
            size: kSpacing42,
            color: colourRankBluePrimary,
          ),
        ),
      ],
    );
  }
}
