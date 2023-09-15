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
          validator: (value) {
            if (hintText == 'Email') {
              return validateEmail(value);
            } else if (hintText == 'Phone Number') {
              return validatePhoneNumber(value);
            } else {
              return value!.isEmpty ? 'Please fill the feild' : null;
            }
            // return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

String? validateEmail(String? value) {
  if (value!.isEmpty) {
    return 'Please enter your Email';
  } else if (value.isEmpty ||
      !RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$')
          .hasMatch(value)) {
    return 'Enter valid Email';
  } else {
    return null;
  }
}

String? validatePhoneNumber(String? value) {
  if (value!.isEmpty) {
    return 'Please enter your phone number';
  } else if (value.isEmpty || value.length < 10) {
    return 'Enter valid phone number';
  } else {
    return null;
  }
}
