import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';

class DateShimmer extends StatelessWidget {
  const DateShimmer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width * 0.2,
          height: 10,
          color: backGroundColor,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: size.width * 0.25,
          height: 10,
          color: backGroundColor,
        )
      ],
    );
  }
}
