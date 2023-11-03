
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/app_constants.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';

class TimeSlotsWidget extends StatefulWidget {
  const TimeSlotsWidget({
    super.key,
  
    required this.selectedIndex,
    required this.selected, required this.dateTime,
  });

  final List selectedIndex;
  final List selected;
  final DateTime dateTime;

  @override
  State<TimeSlotsWidget> createState() => _TimeSlotsWidgetState();
}

class _TimeSlotsWidgetState extends State<TimeSlotsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
        itemCount: timeSlots.length,
        itemBuilder: (context, index) { 
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
                      : whiteColor,
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
