
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';


class CustomTextField extends StatelessWidget {
   CustomTextField({
    Key? key,
    required this.size,
    required this.controller,
    required this.hintname,
    this.obscureText = false,
    this.validator, required this.feildName,
    this.password
  }) : super(key: key);

  final Size size;
  final TextEditingController controller;
  final String feildName;
  final String hintname;
  final bool obscureText;
  final String? Function(String?)? validator;
  TextEditingController? password;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(feildName,style: TextStyle(fontSize: 18),),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(
            color: blackColor,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintname,
            hintStyle: const TextStyle(
              color: FONT_COLOR,
            ),
          ),
          validator:(value) {
            if(hintname == 'Email'){
              return validateEmail(value);
            }else if(hintname == 'Password'){
              return validatePassword(value);
            }else if(hintname == 'Confirm Password'){
              return validateConfirmPassword(value,password!.text.trim());
            }else{
             return value!.isEmpty ? 'Please fill the feild' : null;
            }
          },
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

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6 && value.isNotEmpty) {
      return 'Minimum 6 characters requiered';
    } else {
      return null;
    }
  }

  

  String? validateConfirmPassword(String? value,String? password) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6 && value.isNotEmpty) {
      return 'Minimum 6 characters requiered';
    } else if(value != password){
      return 'Please enter same password';
    }else{
      return null;
    }
  }