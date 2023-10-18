import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/model/chat_model.dart';
import 'package:sitare_astrologer_partner/model/user_model.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _auth.currentUser!.uid;
    // final String currentUserPhoneNumber = _auth.currentUser!.phoneNumber!;
    final Timestamp timestamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
        userId: receiverId,
        // senderPhoneNumber: currentUserPhoneNumber,
        astrologerId: currentUserId,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toJson());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
// Future<List<UserModel>> fetchUserDetails() async {
//   List<String> userIds = extractUserIds(querySnapshot, currentUserId);
// }


  // List<String> extractUserIds(
  //     QuerySnapshot querySnapshot, String currentUserId) {
  //   List<String> userIds = [];
  //   for (var doc in querySnapshot.docs) {
  //     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //     String senderId = data['senderId'];
  //     if (senderId != currentUserId) {
  //       userIds.add(senderId);
  //     }
  //   }
  //   return userIds;
  // }

  // Future<List<UserModel>> fetchUsers(List<String> userIds) async {
  //   List<UserModel> users = [];
    
  //   CollectionReference usersCollection =
  //       FirebaseFirestore.instance.collection('users');
  //   for (String userId in userIds) {
  //     DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();
  //     if (userSnapshot.exists) {
  //       Map<String, dynamic> userData =
  //           userSnapshot.data() as Map<String, dynamic>;
  //       UserModel user = UserModel.fromMap(userData);
  //       users.add(user);
  //     }
  //   }
  //   return users;
  // }
}
