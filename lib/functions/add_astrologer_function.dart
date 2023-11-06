import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sitare_astrologer_partner/constants/app_constants.dart';
import 'package:sitare_astrologer_partner/model/astrologer_model.dart';
import 'package:sitare_astrologer_partner/model/availability_slots_model.dart';

createAstrologer(AstrologerModel astrologer) async {
  final db = FirebaseFirestore.instance;

  try {
    await db.collection('Astrologerdetails').add(
          astrologer.toJson(),
        );
    // ignore: empty_catches
  } catch (e) {}
}

// Future<String?> uploadFile(PlatformFile? selectedFile) async {
//   if (selectedFile == null) {
//     return null; // No file selected
//   }

//   Reference storageReference = FirebaseStorage.instance.ref();
//   Reference referenceDirFiles = storageReference.child('Portfolios');
//   Reference fileToUpload = referenceDirFiles.child(selectedFile.name);
//   try {
//     UploadTask uploadTask = fileToUpload.putFile(
//       File(selectedFile.path!),
//       SettableMetadata(contentType: selectedFile.identifier),
//     );
//     TaskSnapshot taskSnapshot = await uploadTask;
//     String downloadURL = await taskSnapshot.ref.getDownloadURL();
//     return downloadURL;
//   // ignore: empty_catches
//   } catch (e) {}
//   return null;

// }

Future<String> addProfileImge(XFile imagePicked) async {
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referenceDirImages = referenceRoot.child('images');

  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

  Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

  try {
    await referenceImageToUpload.putFile(File(imagePicked.path));
    String imageUrl = await referenceImageToUpload.getDownloadURL();
    return imageUrl;
  } catch (e) {
    return profileImage;
  }
}

// Future<void> updateAstrologerInformation(
//     AstrologerModel astrologer, String docID) async {
//   final CollectionReference astrologersCollection =
//       FirebaseFirestore.instance.collection('Astrologerdetails');
//   String documentID = docID;

//   try {
//     astrologersCollection.doc(documentID).update({
//       'name': astrologer.fullName,
//       'email': astrologer.emailAddress,
//       'phone number': astrologer.phoneNumber,
//       'office address': astrologer.officeAddress,
//       'personal description': astrologer.description,
//       'experience(in years)': astrologer.experienceYears,
//     });
//     // ignore: empty_catches
//   } catch (e) {}
// }

Future<void> updateAstrologer(AstrologerModel astrologer, String uid) async {
  final db = FirebaseFirestore.instance;

  try {
    QuerySnapshot querySnapshot = await db
        .collection('Astrologerdetails')
        .where('uid', isEqualTo: uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      await documentSnapshot.reference.update(astrologer.toJson());
      // return true;
    } else {
      // return false;
    }
  } catch (e) {
    // return false;
  }
}

String? getFileNameFromUrl(String url) {
  Uri uri = Uri.parse(url);
  List<String> pathSegments = uri.pathSegments;
  if (pathSegments.isNotEmpty) {
    return pathSegments.last;
  }
  return null; // No filename found
}

Future<void> addAvailableSlotsToFireBase(
    String uid, AvailabilityModel availableSlots) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Astrologerdetails')
        .where('uid', isEqualTo: uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Phone number exists in Firestore, store the subcollection
      final userDoc = querySnapshot.docs.first;
      final userUid = userDoc.id;
      final subcollectionRef = FirebaseFirestore.instance
          .collection('Astrologerdetails')
          .doc(userUid)
          .collection('available slots');
      await subcollectionRef.add(availableSlots.toJson());
    } else {
      // Phone number does not exist in Firestore
      throw Exception('uid does not exist');
    }
    // ignore: unused_catch_clause
  } on FirebaseException catch (e) {
    throw Exception('Error accessing Firestore: $e');
  }
}
