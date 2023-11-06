
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key, required this.dateTime,
  });
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return  Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              DateFormat('EEEE').format(dateTime), // Weekday
            ),
          Text(
           DateFormat('dd/MM/yyyy').format(dateTime),
            style: const TextStyle(color: redColor),
          )
        ],
      ),
      // text: 'Tomorrow, 05 Aug',
    );
  }
}
