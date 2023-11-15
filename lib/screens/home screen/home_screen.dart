import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/screens/calculator%20webview/calculator_webview.dart';
import 'package:sitare_astrologer_partner/screens/chat%20list/chat_list.dart';
import 'package:sitare_astrologer_partner/screens/home%20screen/widgets/homescreen_cateogory_widget.dart';
import 'package:sitare_astrologer_partner/screens/next%20availability%20screen/next_availability_screen.dart';
import 'package:sitare_astrologer_partner/screens/notification/notification_screen.dart';
import 'package:sitare_astrologer_partner/screens/profile%20screen/profile_screen.dart';
import 'package:sitare_astrologer_partner/screens/welcome%20screen/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ));
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.all(size.width / 16),
          child: Column(
            children: [
              // const Text('Registered Succesfully'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ));
                      },
                      child: HomeScreenCategoryWidget(
                          size: size,
                          text: 'Notifications',
                          icon: Icons.notifications)),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ChatList(),
                        ));
                      },
                      child: HomeScreenCategoryWidget(
                          size: size, text: 'Chats', icon: Icons.chat))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WebView(),
                        ));
                      },
                      child: HomeScreenCategoryWidget(
                          size: size,
                          text: 'Multi-Method Calculator',
                          icon: Icons.calculate)),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NextAvailabilityScreen(),
                        ));
                      },
                      child: HomeScreenCategoryWidget(
                          size: size,
                          text: 'Next Availability',
                          icon: Icons.calendar_month_outlined))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => const WebView(),
                        // ));
                      },
                      child: HomeScreenCategoryWidget(
                          size: size,
                          text: 'Bookings',
                          icon: Icons.pending_actions_sharp)),
                  GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => const NextAvailabilityScreen(),
                        // ));
                      },
                      child: HomeScreenCategoryWidget(
                          size: size,
                          text: 'Next Availability',
                          icon: Icons.calendar_month_outlined))
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
