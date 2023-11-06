class AvailabilityModel {
  final DateTime date;
  final List availableSlots;
  final List bookedSlots;

  AvailabilityModel({
    required this.date,
    required this.availableSlots,
    required this.bookedSlots,
  });

  toJson() {
    return {
      "date": date,
      "available slots": availableSlots,
      "booked slots": bookedSlots
    };
  }
}
