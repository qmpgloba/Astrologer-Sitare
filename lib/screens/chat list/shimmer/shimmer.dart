import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade200,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade100,
              ),
              title: Container(
                color: Colors.grey.shade100,
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
