import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String userId;
  // final String senderPhoneNumber;
  final String astrologerId;
  final String message;
  final Timestamp timestamp;

  MessageModel(
      {required this.userId,
      // required this.senderPhoneNumber,
      required this.astrologerId,
      required this.message,
      required this.timestamp});

  toJson() {
    return {
      'userId': userId,
      // 'sender phone number': senderPhoneNumber,
      'astrologerId': astrologerId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
