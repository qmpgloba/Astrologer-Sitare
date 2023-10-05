
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AstrologerProfileDetailsWidget extends StatelessWidget {
  const AstrologerProfileDetailsWidget({
    super.key,
    required this.feildName,
    required this.astrologerDetail,
    required this.size,
  });
  final String feildName;
  final String astrologerDetail;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Text(
              feildName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
              width: size.width * .4,
              child: AutoSizeText(
                astrologerDetail,
                style: const TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.end,
                maxLines: 3,
                maxFontSize: 16,
              ))
        ],
      ),
    );
  }
}
