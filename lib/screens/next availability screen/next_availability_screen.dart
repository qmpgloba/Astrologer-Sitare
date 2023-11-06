import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/add_astrologer_function.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/model/availability_slots_model.dart';
import 'package:sitare_astrologer_partner/screens/next%20availability%20screen/widgets/time_slots_widget.dart';

import 'widgets/tab_widget.dart';

class NextAvailabilityScreen extends StatefulWidget {
  const NextAvailabilityScreen({
    super.key,
  });

  @override
  State<NextAvailabilityScreen> createState() => _NextAvailabilityScreenState();
}

class _NextAvailabilityScreenState extends State<NextAvailabilityScreen>
    with TickerProviderStateMixin {
  late List<List> selected;
  late List<List> selectedIndex;
  late List<DateTime> dateList;
  late TabController _tabController;
  @override
  void initState() {
    
    super.initState();
    updateDateList();
    _tabController = TabController(length: dateList.length, vsync: this);
    initializeLists();
  }

  void initializeLists() {
    selected = List.generate(dateList.length, (index) => []);
    selectedIndex = List.generate(dateList.length, (index) => []);
  }

  void updateDateList() {
    dateList = [];
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
                  controller: _tabController,
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
                  // onTap: (value) {
                  //   print(value);
                  // },
                  tabs: dateList
                      .map((date) => TabWidget(dateTime: date))
                      .toList(),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: dateList
                    .map((date) => TimeSlotsWidget(
                        dateTime: date,
                        selectedIndex: selectedIndex[dateList.indexOf(date)],
                        selected: selected[dateList.indexOf(date)]))
                    .toList(),
              ),
            ),
            GestureDetector(
              onTap: () async{
                AvailabilityModel slots = AvailabilityModel(
                    date: dateList[_tabController.index],
                    availableSlots: selected[_tabController.index],
                    bookedSlots: []);
                    await addAvailableSlotsToFireBase(currentUser!.uid, slots);

              },
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
