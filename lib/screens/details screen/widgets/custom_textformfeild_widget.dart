import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.text,
    required this.hintText,
  });
  final String? text;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text ?? "",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 25),
      ],
    );
  }
}