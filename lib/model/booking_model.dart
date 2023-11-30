import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDetailsModel {
  final String userUid;
  final String slotBooked;
  final String astrologerId;
  final DateTime date;

  BookingDetailsModel({
    required this.userUid,
    required this.slotBooked,
    required this.astrologerId,
    required this.date,
  });

  toJson() {
    return {
      'astrologer id': astrologerId,
      'user uid': userUid,
      'slot booked': slotBooked,
      'date': date
    };
  }

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookingDetailsModel(
        userUid: json['user uid'],
        slotBooked: json['slot booked'],
        astrologerId: json['astrologer id'],
        date: (json['date'] as Timestamp).toDate());
  }
}
