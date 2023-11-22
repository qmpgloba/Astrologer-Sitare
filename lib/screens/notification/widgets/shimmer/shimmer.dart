import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';

class NotificationShimmer extends StatefulWidget {
  const NotificationShimmer({super.key});

  @override
  State<NotificationShimmer> createState() => _NotificationShimmerState();
}

class _NotificationShimmerState extends State<NotificationShimmer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                width: size.width * 0.15,
                height: size.width * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backGroundColor,
                ),
              ),
              title: Row(
                children: [
                  Container(
                    color: backGroundColor,
                    height: 10,
                    width: 80,
                  ),
                  const SizedBox()
                ],
              ),
              subtitle: Row(
                children: [
                  Container(
                    color: backGroundColor,
                    height: 10,
                    width: 180,
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: backGroundColor,
                    height: 10,
                    width: 30,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: backGroundColor,
                    width: 50,
                    height: 10,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 10,
        ),
      )),
    );
  }
}
