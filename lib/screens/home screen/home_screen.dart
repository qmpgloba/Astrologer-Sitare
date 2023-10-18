import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/screens/chat%20list/chat_list.dart';
import 'package:sitare_astrologer_partner/screens/notification/notification_screen.dart';
import 'package:sitare_astrologer_partner/screens/profile%20screen/profile_screen.dart';
import 'package:sitare_astrologer_partner/screens/welcome%20screen/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        iconTheme: const IconThemeData(color: whiteColor),
        title: const Text(
          'Home Screen',
          style: TextStyle(color: whiteColor),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                    (route) => false);
              });
            },
            icon: const Icon(Icons.logout)),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
                  },
                  icon: const Icon(Icons.person)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ));
                  },
                  icon: const Icon(Icons.notifications))
            ],
          )
        ],
      ),
      body:  SafeArea(
          child: Center(
        child: Column(
          children: [
            const Text('Registered Succesfully'),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatList(),));
            }, child: const Text('chat'))
          ],
        ),
      )),
    );
  }
}
