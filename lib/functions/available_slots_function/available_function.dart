
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sitare_astrologer_partner/model/availability_slots_model.dart';

Future<List<AvailabilityModel>> getAvailableSlots(String astrologerId) async {
  List<AvailabilityModel> availableSlots = [];

  try {
    final userColection = await FirebaseFirestore.instance
        .collection('Astrologerdetails')
        .where('uid', isEqualTo: astrologerId)
        .get();

    if (userColection.docs.isNotEmpty) {
      final userDoc = userColection.docs.first;
      final userUid = userDoc.id;
      final subcollectionRef = await FirebaseFirestore.instance
          .collection('Astrologerdetails')
          .doc(userUid)
          .collection('available slots')
          .get();

      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      for (var slot in subcollectionRef.docs) {
        Map<String, dynamic> data = slot.data();
        AvailabilityModel date = AvailabilityModel.fromJson(data);
        DateTime dateFromFirestore = date.date;
        String formattedDate = formatter.format(dateFromFirestore);
        String todayDate = formatter.format(now);

        if (dateFromFirestore.isAfter(now) || formattedDate == todayDate) {
          availableSlots.add(date);
        }
      }
    } else {
      throw Exception('uid does not exist');
    }
    // ignore: empty_catches
  } catch (e) {}
  availableSlots.sort((a, b) => a.date.compareTo(b.date));
  return availableSlots;
}