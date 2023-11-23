import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';

class ChatListShimmer extends StatefulWidget {
  const ChatListShimmer({super.key});

  @override
  State<ChatListShimmer> createState() => _ChatListShimmerState();
}

class _ChatListShimmerState extends State<ChatListShimmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: backGroundColor,
              ),
              title: Container(
                color: backGroundColor,
                height: 10,
                width: 10,
              ),
              trailing: const SizedBox(
                width: 150,
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
