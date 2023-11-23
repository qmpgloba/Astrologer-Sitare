import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/screens/next%20availability%20screen/widgets/shimmer/date_shimmer.dart';
import 'package:sitare_astrologer_partner/screens/next%20availability%20screen/widgets/shimmer/date_widget.dart';

class AvailabilityShimmer extends StatefulWidget {
  const AvailabilityShimmer({super.key});

  @override
  State<AvailabilityShimmer> createState() => _AvailabilityShimmerState();
}

class _AvailabilityShimmerState extends State<AvailabilityShimmer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DateShimmerWidget(size: size),
          ],
        ),
      ),
    );
  }
}
