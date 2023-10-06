import 'package:flutter/material.dart';

import '../../../constants/ui_constants.dart';

class UpdateButtonWidget extends StatelessWidget {
  const UpdateButtonWidget({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: blackColor, borderRadius: BorderRadius.circular(30)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
          child: Center(
            child: Text(
              'Update',
              maxLines: 1,
              style: TextStyle(
                  fontSize: 18, color: whiteColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
