import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sitare_astrologer_partner/model/availability_slots_model.dart';
import 'package:sitare_astrologer_partner/model/booking_model.dart';
Future<List<BookingDetailsModel>> getBookingDetails(
    String currentUserId, DateTime selectedDate) async {
  List<BookingDetailsModel> availableSlots = [];

  try {
    final userCollection = await FirebaseFirestore.instance
        .collection('Astrologerdetails')
        .where('uid', isEqualTo: currentUserId)
        .get();

    if (userCollection.docs.isNotEmpty) {
      final userDoc = userCollection.docs.first;
      final docid = userDoc.id;
      final subcollectionRef = await FirebaseFirestore.instance
          .collection('Astrologerdetails')
          .doc(docid)
          .collection('available slots')
          .get();
      
      final currentTime = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');

      for (var slot in subcollectionRef.docs) {
        Map<String, dynamic> data = slot.data();
        AvailabilityModel date = AvailabilityModel.fromJson(data);
        DateTime dateFromFirestore = date.date;

        if (dateFromFirestore.isAfter(currentTime) ||
            formatter.format(dateFromFirestore) == formatter.format(currentTime)) {
          final bookedSlotsSnapshot =
              await slot.reference.collection('booked details').get();

          for (var bookedSlot in bookedSlotsSnapshot.docs) {
            Map<String, dynamic> bookedSlotData = bookedSlot.data();
            BookingDetailsModel booking =
                BookingDetailsModel.fromJson(bookedSlotData);
            availableSlots.add(booking);
          }
        }
      }
    } else {
      throw Exception('UID does not exist');
    }
  } catch (e) {
    // Handle the error appropriately
  }

  availableSlots.sort((a, b) => a.slotBooked.compareTo(b.slotBooked));
  availableSlots.sort((a, b) => a.date.compareTo(b.date));

  return availableSlots;
}
