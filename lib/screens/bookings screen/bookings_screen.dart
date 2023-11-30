import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/available_slots_function/booking_function.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/model/booking_model.dart';


class BoookingsScreen extends StatelessWidget {
  const BoookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: const Text(
          'My Bookings',
          style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<BookingDetailsModel>>(
        future: getBookingDetails(currentUser!.uid, DateTime.now()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('You dont have any bookings'));
          } else {
            List<BookingDetailsModel>? list = snapshot.data;

            return ListView.builder(
              itemCount: list!.length,
              itemBuilder: (context, index) {
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('uid', isEqualTo: list[index].userUid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: SizedBox());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('No Data Available'));
                      } else {
                        var docs = snapshot.data!.docs.first;
                        // return Text('${docs['name']}');
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.width / 25),
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: size.width * .07,
                                      backgroundImage:
                                          NetworkImage(docs['profile image']),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            docs['full name'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            maxFontSize: 16,
                                            maxLines: 1,
                                          ),
                                          // AutoSizeText(
                                          //   docs['skills'].take(2).join(', '),
                                          //   // maxLines: 1,
                                          //   maxFontSize: 12,
                                          //   style: const TextStyle(
                                          //       fontSize: 10,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          // AutoSizeText(
                                          //     docs['languages']
                                          //         .take(2)
                                          //         .join(', '),
                                          //     // maxLines: 1,
                                          //     maxFontSize: 12,
                                          //     style: const TextStyle(
                                          //         fontSize: 10,
                                          //         fontWeight: FontWeight.bold)),
                                          Text(
                                            '${DateFormat('dd MMM yyyy').format(list[index].date)} Time: ${list[index].slotBooked}',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: greenColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Text('Time: ${list[index].slotBooked}',style: TextStyle(fontSize: 12),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      }
                    });
              },
            );
          }
        },
      ),
    );
  }
}
