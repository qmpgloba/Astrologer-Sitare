// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/widgets/flutter_toast.dart';

class RatePerMinuteScreen extends StatefulWidget {
  const RatePerMinuteScreen({super.key});

  @override
  State<RatePerMinuteScreen> createState() => _RatePerMinuteScreenState();
}

class _RatePerMinuteScreenState extends State<RatePerMinuteScreen> {
  final TextEditingController rateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Per Minute'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: rateController,
                decoration: InputDecoration(
                  labelText: 'Enter the rate per minute(between 0-10)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => onTapConfirm(rateController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: blackColor,
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapConfirm(
    String rate,
  ) async {
    var astrologerId = FirebaseAuth.instance.currentUser!.uid;
    final db = FirebaseFirestore.instance;

    var rpm = double.parse(rate);
    if (0 < rpm && rpm < 10) {
      try {
        QuerySnapshot snapshot = await db
            .collection('Astrologerdetails')
            .where('uid', isEqualTo: astrologerId)
            .get();
        if (snapshot.docs.isNotEmpty) {
          DocumentSnapshot documentSnapshot = snapshot.docs.first;
          await documentSnapshot.reference.update({'rpm': rpm.toString()});
          print('rpm added');
        } else {
          print('Astrologer document does not exist');
        }
      } catch (e) {
        print('Error updating rpm');
      }
    } else {
      showToast('Please enter an amount between 0-10', Colors.red);
    }
  }
}
