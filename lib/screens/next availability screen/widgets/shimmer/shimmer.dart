import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/screens/next%20availability%20screen/widgets/shimmer/date_widget.dart';
import 'package:sitare_astrologer_partner/screens/next%20availability%20screen/widgets/shimmer/time_slot_shimmer.dart';

class AvailabilityShimmer extends StatefulWidget {
  const AvailabilityShimmer({super.key});

  @override
  State<AvailabilityShimmer> createState() => _AvailabilityShimmerState();
}

class _AvailabilityShimmerState extends State<AvailabilityShimmer> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Availability'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            DateShimmerWidget(size: size),
            TimeSlotShimmer(scrollController: _scrollController),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      color: backGroundColor,
                      height: 30,
                      width: size.width * 0.8,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
