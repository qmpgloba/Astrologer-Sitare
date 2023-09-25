import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/user%20profile/get_user_profile.dart';
import 'package:sitare_astrologer_partner/screens/edit%20profile/edit_profile.dart';
import 'package:sitare_astrologer_partner/screens/login%20screen/login_screen.dart';
Map<String, dynamic>? userData;
String? documentID;
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0.5,
          title: const Text('Profile'),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false);
                  });
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
        body: FutureBuilder<DocumentSnapshot?>(
            future:
                getUserDataByEmail(FirebaseAuth.instance.currentUser!.email!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data != null) {
                 userData = snapshot.data!.data() as Map<String, dynamic>;
                 documentID = snapshot.data!.id;
                return SafeArea(
                    child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(size.width / 16),
                    child: Column(
                      children: [
                        AutoSizeText(
                          userData!['name'],
                          minFontSize: 18,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 35,
                              backgroundColor: redColor,
                            ),
                            Positioned(
                                // height: 25,
                                // width: 20,
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: whiteColor.withOpacity(0.4)),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 30,
                                      )),
                                )),
                          ],
                        ),
                        AstrologerProfileDetailsWidget(
                            size: size,
                            feildName: 'Mobile number',
                            astrologerDetail: userData!['phone number']),
                        AstrologerProfileDetailsWidget(
                            size: size,
                            feildName: 'Personal description',
                            astrologerDetail: userData!['personal description']),
                        AstrologerProfileDetailsWidget(
                            size: size,
                            feildName: 'Address',
                            astrologerDetail:
                                userData!['office address']),
                        AstrologerProfileDetailsWidget(
                            size: size,
                            feildName: 'Experience',
                            astrologerDetail: "${userData!['experience(in years)']} Years"),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: ()  {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditProfileScreen(),));
                          },
                          child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: blackColor,
                                borderRadius: BorderRadius.circular(3)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Center(
                                child: Text(
                                  'Edit Profile',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.5),
                                // color: PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(3)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Center(
                                child: Text(
                                  'Delete',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: blackColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
              } else {
                return const Text('Please add deatials');
              }
            }));
  }
}

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
