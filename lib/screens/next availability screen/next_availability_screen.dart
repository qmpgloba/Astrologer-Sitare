import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/screens/next%20availability%20screen/widgets/time_slots_widget.dart';

import 'widgets/tab_widget.dart';

class NextAvailabilityScreen extends StatefulWidget {
  const NextAvailabilityScreen({
    super.key,
  });

  @override
  State<NextAvailabilityScreen> createState() => _NextAvailabilityScreenState();
}

class _NextAvailabilityScreenState extends State<NextAvailabilityScreen> {
  List selected = [];
  List selectedIndex = [];
  List<DateTime> dateList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDateList();
  }

  void updateDateList() {
    dateList.clear();
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      dateList.add(now.add(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: blackColor,
          title: const Text(
            'Next Availability',
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            // ProfileWidgetNextAvailabilityScreen(size: size, astrologer: widget.astrologer),
            Container(
              height: size.width / 5,
              color: const Color.fromARGB(255, 3, 11, 59),
              width: size.width,
              child: Padding(
                padding: EdgeInsets.all(size.width * .03),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  isScrollable: true,
                  physics: const BouncingScrollPhysics(),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.cyan,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor),
                  tabs:  dateList.map((date) => TabWidget(dateTime: date)).toList(),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children:  dateList.map((date) => TimeSlotsWidget(dateTime: date, selectedIndex: selectedIndex, selected: selected)).toList(),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.maxFinite,
                  // height: 30,
                  decoration: BoxDecoration(
                      color: redColor, borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Center(
                      child: AutoSizeText(
                        'Update Slots',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16,
                            color: whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }
}
