import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/screens/details%20screen/widgets/textfeild_widget.dart';

import '../../../constants/ui_constants.dart';
import 'update_button_widget.dart';

class ProfileTabWidget extends StatelessWidget {
  const ProfileTabWidget({
    super.key,
    required TextEditingController nameTextController,
    required TextEditingController emailTextController,
    required TextEditingController phoneNumberTextController,
  })  : _nameTextController = nameTextController,
        _emailTextController = emailTextController,
        _phoneNumberTextController = phoneNumberTextController;

  final TextEditingController _nameTextController;
  final TextEditingController _emailTextController;
  final TextEditingController _phoneNumberTextController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFeildWidgets(
            controller: _nameTextController,
            hintText: 'Full Name',
            fieldName: 'Name',
            keyboardType: TextInputType.name,
            maxLines: 1,
            readOnly: false),
        TextFeildWidgets(
            controller: _emailTextController,
            hintText: 'Email',
            fieldName: 'Email Address',
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            readOnly: false),
        TextFeildWidgets(
            controller: _phoneNumberTextController,
            hintText: 'Phone Number',
            fieldName: 'Phone Number',
            keyboardType: TextInputType.phone,
            maxLines: 1,
            readOnly: false),
      ],
    );
  }
}
