

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

User? get currentUser => _auth.currentUser;
Stream<User?> get authState => _auth.authStateChanges();
// Future<String?> signUpWithEmail({
//   required String email,
//   required String password,
// }) async {
//   try {
//     await _auth
//         .createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         return null;
//   } on FirebaseAuthException catch (e) {
//     return e.message.toString();
//   }
// }

// Future<String?> loginWithEmail({
//   required String email,required String password
// }) async{
//   try {
//     await _auth.signInWithEmailAndPassword(email: email, password: password);
//     return null;
//   }on FirebaseAuthException catch (e) {
//     return e.message.toString();
    
//   }
// }


String verifyId = '';

Future<String?> phoneAuthentication(String number) async {
  try {
    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (error) {
        // showSnackBar(context, Colors.red, error.message.toString());
      },
      codeSent: (verificationId, forceResendingToken) {
        verifyId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
    return null;
  } on FirebaseAuthException catch (e) {
    return e.message.toString();
    // showSnackBar(context, themeColor, e.message.toString());
  }
}
//  Future<String?> verifyOTP(String otp) async {
//     try {
//       // Create a PhoneAuthCredential using the verification ID and OTP code.
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verifyId,
//         smsCode: otp,
//       );

//       // Sign in with the PhoneAuthCredential.
//       await _auth.signInWithCredential(credential);

//       // Get the user's authentication token.
//       User? user = _auth.currentUser;
//       if (user != null) {
//         String? token = await user.getIdToken();
//         // Use the token as needed.
//         return null; // Return null to indicate success.
//       } else {
//         return 'User not found'; // Handle the case where the user is not found.
//       }
//     } on FirebaseAuthException catch (e) {
//       // Handle FirebaseAuthException, e.g., show an error message.
//       return e.message.toString();
//     }
//   }

Future<bool> verifyOTP(String otp) async {
  var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp));

  return credentials.user != null ? true : false;
}

Future<bool> checkPhoneNumberExistence(String mobileNumber) async {
  final phoneNumber = mobileNumber;

  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Astrologerdetails')
        .where('phone number', isEqualTo: phoneNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Phone number exists in Firestore
      return true;
    } else {
      // Phone number does not exist in Firestore
      return false;
    }
    // ignore: unused_catch_clause
  } on FirebaseException catch (e) {
    return false;
  }
}
