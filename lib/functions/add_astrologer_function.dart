
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sitare_astrologer_partner/model/astrologer_model.dart';

createAstrologer(AstrologerModel astrologer) async {
  final db = FirebaseFirestore.instance;
  print('keri');
  try {
    await db.collection('Astrologerdetails').add(
          astrologer.toJson(),
        );
  } catch (e) {
    print('failed');
    print(e.toString());
  }
  print('kainj');
}
