import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitare_astrologer_partner/constants/app_constants.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/model/availability_slots_model.dart';

class TimeSlotsWidget extends StatefulWidget {
  const TimeSlotsWidget({
    super.key,
    required this.selectedIndex,
    required this.selected,
    required this.dateTime,
    required this.selectedSlots,
  });

  final List selectedIndex;
  final List selected;
  final DateTime dateTime;
  final List<AvailabilityModel> selectedSlots;

  @override
  State<TimeSlotsWidget> createState() => _TimeSlotsWidgetState();
}

class _TimeSlotsWidgetState extends State<TimeSlotsWidget> {
  Color colorSlot = whiteColor;
  List timings = [];
  @override
  Widget build(BuildContext context) {
    var date = DateFormat('dd/MM/yyyy').format(widget.dateTime);
    if (widget.selectedSlots.isNotEmpty) {
      AvailabilityModel? day = widget.selectedSlots.firstWhere(
        (element) {
          var currDate = DateFormat('dd/MM/yyyy').format(element.date);
          return currDate ==
              date;
        },
        orElse: () => AvailabilityModel(date: widget.dateTime, availableSlots: [], bookedSlots: []),
      );
      timings = day.availableSlots;
    }
    return SizedBox(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          if (timings.contains(timeSlots[index])) {
            colorSlot = greyColor;
          } else {
            colorSlot = whiteColor;
          }
          return GestureDetector(
            onTap: () {
              if (widget.selectedIndex.contains(index)) {
                widget.selected.remove(timeSlots[index]);
                widget.selectedIndex.remove(index);
              } else {
                widget.selected.add(timeSlots[index]);
                widget.selectedIndex.add(index);
              }
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
              child: Container(
                // width: 30,
                height: 5,

                decoration: BoxDecoration(
                  color: widget.selectedIndex.contains(index)
                      ? blackColor
                      : colorSlot,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    timeSlots[index],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: widget.selectedIndex.contains(index)
                            ? whiteColor
                            : Colors.black),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
