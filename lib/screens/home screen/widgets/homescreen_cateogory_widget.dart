
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/screens/home%20screen/widgets/contacts_icon_homescreen_widget.dart';

class HomeScreenCategoryWidget extends StatelessWidget {
  const HomeScreenCategoryWidget({
    super.key,
    required this.size, required this.text, required this.icon,
  });

  final Size size;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 2 - size.width / 12,
      height: size.width / 4,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 1, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset:
                          const Offset(0, 2), // Offset in the x, y direction
                    ),
                  ],),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ContactIconHomeScreen(
                  icon: icon),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AutoSizeText(
            text,
            maxFontSize: 16,
            maxLines: 1,
            minFontSize: 8,
            style: const TextStyle(color: blackColor),
          )
        ],
      ),
    );
  }
}
