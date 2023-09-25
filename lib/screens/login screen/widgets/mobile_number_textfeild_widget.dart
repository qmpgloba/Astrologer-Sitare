
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';

class MobileNumberTextFeildWidget extends StatelessWidget {
  const MobileNumberTextFeildWidget({
    super.key,
    required this.mobileNumberController,
    this.validator,
    this.onCountryChanged,
  });
  final TextEditingController mobileNumberController;
  final String? Function(String?)? validator;
  final void Function(Country)? onCountryChanged;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      style: const TextStyle(color: blackColor),
      controller: mobileNumberController,
      initialCountryCode: 'IN',
      showDropdownIcon: false,
      onCountryChanged: onCountryChanged,
      cursorColor: FONT_COLOR,
      // keyboardType: textin,
      dropdownTextStyle: const TextStyle(color: FONT_COLOR),
      decoration: const InputDecoration(
        hintText: 'Mobile Number',
        hintStyle: TextStyle(color: FONT_COLOR),
        counterText: '',
      ),
    );
  }
}
