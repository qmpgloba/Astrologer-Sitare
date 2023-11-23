import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/screens/next%20availability%20screen/widgets/shimmer/date_shimmer.dart';

class DateShimmerWidget extends StatelessWidget {
  const DateShimmerWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width / 5,
      color: const Color.fromARGB(255, 3, 11, 59),
      width: size.width,
      child: Padding(
        padding: EdgeInsets.all(size.width * .03),
        child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: highlightColor,
          child: Row(
            children: [
              Container(
                width: size.width * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: backGroundColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              DateShimmer(size: size),
              const SizedBox(
                width: 20,
              ),
              DateShimmer(size: size)
            ],
          ),
        ),
      ),
    );
  }
}
