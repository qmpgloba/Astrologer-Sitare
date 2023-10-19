
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/model/user_model.dart';
import 'package:sitare_astrologer_partner/screens/chat%20screen/service/chat_service.dart';

void sendMessage(TextEditingController controller,ChatService chatService,UserModel user) async {
    if (controller.text.isNotEmpty) {
      await chatService.sendMessage(
          user.uid, controller.text);

      controller.clear();
    }
  }

// FirebaseFirestore firestore = FirebaseFirestore.instance;
//   Future<List<UserModel>> fetchuserdetailsDromfirestore() async {
//   // List<UserModel> astrologersList = [];

//    try {
//       QuerySnapshot querySnapshot =
//           await FirebaseFirestore.instance.collection('users').get();

//       List<UserModel> users = [];
//       querySnapshot.docs.forEach((DocumentSnapshot doc) {
//         Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
//         users.add(UserModel.fromMap(userData));
//       });
// print(users);
//       return users;
//     } catch (e) {
//       print('Error fetching users: $e');
//       return [];
//     }
//   }
// // print("hei ${astrologersList}");
// //   return astrologersList;
// // }

  
