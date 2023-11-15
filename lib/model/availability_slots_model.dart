import 'package:cloud_firestore/cloud_firestore.dart';

class AvailabilityModel {
  final DateTime date;
  final List availableSlots;
  final List bookedSlots;

  AvailabilityModel({
    required this.date,
    required this.availableSlots,
    required this.bookedSlots,
  });

  toJson() {
    return {
      "date": date,
      "available slots": availableSlots,
      "booked slots": bookedSlots
    };
  }

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityModel(
       date: (json['date'] as Timestamp).toDate(),
      availableSlots: List<dynamic>.from(json['available slots']),
      bookedSlots: List<dynamic>.from(json['booked slots']),);
  }
}
