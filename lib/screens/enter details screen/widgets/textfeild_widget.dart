import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';

class TextFeildWidgets extends StatelessWidget {
  const TextFeildWidgets({
    super.key,
    required this.controller,
    required this.hintText,
    required this.fieldName,
    required this.keyboardType,
    required this.maxLines,
    required this.readOnly,
  });
  final TextEditingController controller;
  final String hintText;
  final String fieldName;
  final TextInputType keyboardType;
  final int maxLines;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          style: const TextStyle(color: Colors.black),
          maxLines: maxLines,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
            hintStyle: const TextStyle(color: FONT_COLOR),
          ),
          readOnly: readOnly,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
