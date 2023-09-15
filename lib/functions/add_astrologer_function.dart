import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sitare_astrologer_partner/model/astrologer_model.dart';

createAstrologer(AstrologerModel astrologer) async {
  final db = FirebaseFirestore.instance;

  try {
    await db.collection('Astrologerdetails').add(
          astrologer.toJson(),
        );
  // ignore: empty_catches
  } catch (e) {
  }

}

Future<String?> uploadFile(PlatformFile? selectedFile) async {
  if (selectedFile == null) {
    return null; // No file selected
  }

  Reference storageReference = FirebaseStorage.instance.ref();
  Reference referenceDirFiles = storageReference.child('Portfolios');
  Reference fileToUpload = referenceDirFiles.child(selectedFile.name);
  try {
    UploadTask uploadTask = fileToUpload.putFile(
      File(selectedFile.path!),
      SettableMetadata(contentType: selectedFile.identifier),
    );
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  // ignore: empty_catches
  } catch (e) {}
  return null;

  // TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

  // The downloadURL now contains the URL of the uploaded file in Firebase Storage
  // print('File uploaded to: $downloadURL');
}
