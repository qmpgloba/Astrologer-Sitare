import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String chatId;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  MessageModel(
      {required this.senderId,
      required this.chatId,
      required this.receiverId,
      required this.message,
      required this.timestamp});

  toJson() {
    return {
      'senderId': senderId,
      'chat_id': chatId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
