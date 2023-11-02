import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';


class ContactIconHomeScreen extends StatelessWidget {
  const ContactIconHomeScreen({
    super.key,
    required this.icon,
  });
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: blackColor,
      radius: 17,
      child: Icon(
        icon,
        size: 20,
        color: whiteColor,
      ),
    );
  }
}
