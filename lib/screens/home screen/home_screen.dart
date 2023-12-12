import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/add_astrologer_function.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/functions/user%20profile/get_user_profile.dart';
import 'package:sitare_astrologer_partner/model/astrologer_model.dart';
import 'package:sitare_astrologer_partner/screens/bookings%20screen/bookings_screen.dart';
import 'package:sitare_astrologer_partner/screens/chat%20list/chat_list.dart';
import 'package:sitare_astrologer_partner/screens/home%20screen/widgets/homescreen_cateogory_widget.dart';
import 'package:sitare_astrologer_partner/screens/next%20availability%20screen/next_availability_screen.dart';
import 'package:sitare_astrologer_partner/screens/notification/notification_screen.dart';
import 'package:sitare_astrologer_partner/screens/profile%20screen/profile_screen.dart';
import 'package:sitare_astrologer_partner/screens/rate%20per%20minute/rate_per_minute.dart';

Map<String, dynamic>? userData;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isToggleOn;

  @override
  Widget build(BuildContext context) {
    // isToggleOn =userData!['isOnline'];
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder(
      future:
          getUserDataByNumber(FirebaseAuth.instance.currentUser!.phoneNumber!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          userData = snapshot.data!.data() as Map<String, dynamic>;
          documentID = snapshot.data!.id;
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
              leading: Switch(
                activeColor: greenColor,
                inactiveTrackColor: blackColor,
                inactiveThumbColor: redColor,
                activeTrackColor: blackColor,
                value: userData!['isOnline'] ?? false,
                onChanged: (value) async {
                  AstrologerModel astrologer = AstrologerModel(
                    isOnline: value,
                    uid: currentUser!.uid,
                    fullName: userData!['name'],
                    emailAddress: userData!['email'],
                    phoneNumber: userData!['phone number'],
                    profilePic: userData!['profile image'],
                    officeAddress: userData!['office address'],
                    description: userData!['personal description'],
                    experienceYears: userData!['experience(in years)'],
                    contributeHours: userData!['hours of contribution'],
                    heardAboutSitare:
                        userData!['Where did you hear about sitare'],
                    gender: userData!['gender'],
                    martialStatus: userData!['martial status'],
                    dateOfBirth: userData!['date of birth'],
                    languages: userData!['languages'],
                    skills: userData!['skills'],
                    workingOnlinePLatform:
                        userData!['working on any other online platform'],
                    instagramLink: userData!['instagram profile link'],
                    linkedInLink: userData!['linkedin profile link'],
                    websiteLink: userData!['website profile link'],
                    facebookLink: userData!['facebook profile link'],
                    youtubeLink: userData!['youtube profile link'],
                    business: userData!['main source of business'],
                    anyoneReferSitare: userData!['did anyone refer sitare'],
                    onBorad: userData!['onboard you'],
                    qualification: userData!['highest qualification'],
                    earningExpectation:
                        userData!['minimum earning expectation'],
                    learnAboutAstrology:
                        userData!['form where did you learn astrology'],
                    foreignCountries: userData!['Number of foreign countries'],
                    biggestChallenge: userData!['biggest challenge'],
                    currentWorkingStatus: userData!['current working status'],
                    fcmToken: userData!['fcmToken']!,
                    rpm: userData!['rpm'],
                  );
                  await updateAstrologer(astrologer, currentUser!.uid);
                  setState(() {});

                  

                  print(userData!['isOnline']);
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
                  },
                  icon: const Icon(Icons.person),
                )
              ],
            ),
            body: SafeArea(
                child: Center(
              child: Padding(
                padding: EdgeInsets.all(size.width / 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            icon: Icons.notifications,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ChatList(),
                            ));
                          },
                          child: HomeScreenCategoryWidget(
                            size: size,
                            text: 'Chats',
                            icon: Icons.chat,
                          ),
                        )
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
                              builder: (context) => const BoookingsScreen(),
                            ));
                          },
                          child: HomeScreenCategoryWidget(
                            size: size,
                            text: 'Bookings',
                            icon: Icons.list,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const NextAvailabilityScreen(),
                            ));
                          },
                          child: HomeScreenCategoryWidget(
                            size: size,
                            text: 'Next Availability',
                            icon: Icons.calendar_month_outlined,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RatePerMinuteScreen(),
                        ));
                      },
                      child: HomeScreenCategoryWidget(
                        size: size,
                        text: 'Rate Per Minute',
                        icon: Icons.currency_rupee,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          );
        } else {
          return Center(
            child: Text('Something went wrong!!'),
          );
        }
      },
    );
  }
}
