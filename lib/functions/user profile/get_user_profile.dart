import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot<Map<String, dynamic>>?> getUserDataByNumber(
    String phoneNumber) async {
  final userColection =
      FirebaseFirestore.instance.collection('Astrologerdetails');
  final querySnapShot = await userColection
      .where('phone number', isEqualTo: phoneNumber)
      .limit(1)
      .get();
  if (querySnapShot.docs.isNotEmpty) {
    return querySnapShot.docs.first;
  } else {
    return null;
  }
}

Future<Map<String, dynamic>?> getAstroDetailsByUid(String uid) async {
  final userCollection = FirebaseFirestore.instance.collection('Astrologerdetails');
  final querySnapshot = await userCollection.where('uid', isEqualTo: uid).limit(1).get();
  
  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first.data();
  } else {
    return null;
  }
}

Future<String?> fetchUserMobileNumber(String userUid) async {
  try {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: userUid).get();
    if (userSnapshot.docs.isNotEmpty) {
      var userData = userSnapshot.docs.first;
     
      return userData['phone number'] as String?;
    } else {
      return null; // Return null if the user does not exist
    }
  } catch (e) {
    return null; // Return null in case of any errors
  }
}

Future<String?> fetchFcmToken(String userUid) async {
  try {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance.collection('Astrologerdetails').where('uid',isEqualTo: userUid).get();
    if (userSnapshot.docs.isNotEmpty) {
      var userData = userSnapshot.docs.first;
     
      return userData['fcmToken'] as String?;
    } else {
      return null; 
    }
  } catch (e) {
    return null;
  }
}







