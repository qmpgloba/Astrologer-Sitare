import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/add_astrologer_function.dart';
import 'package:sitare_astrologer_partner/functions/available_slots_function/available_function.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/model/availability_slots_model.dart';
import 'package:sitare_astrologer_partner/screens/home%20screen/home_screen.dart';
import 'package:sitare_astrologer_partner/screens/next%20availability%20screen/widgets/shimmer/shimmer.dart';
import 'package:sitare_astrologer_partner/screens/next%20availability%20screen/widgets/time_slots_widget.dart';
import 'package:sitare_astrologer_partner/widgets/flutter_toast.dart';

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
  late List<List> bookedSlots;
  late List<DateTime> dateList;
  late TabController _tabController;
  List<AvailabilityModel> selectedSlots = [];

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
    bookedSlots = List.generate(dateList.length, (index) => []);
  }

  bool checkDates(DateTime date1, DateTime date2) {
    return date1.isAtSameMomentAs(date2);
  }

  void updateDateList() {
    dateList = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      dateList.add(now.add(Duration(days: i)));
    }
  }

  AvailabilityModel? day;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder<List<AvailabilityModel>>(
        future: getAvailableSlots(currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: AvailabilityShimmer());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            selectedSlots = snapshot.data!;
            return DefaultTabController(
              length: 7,
              child: Scaffold(
                backgroundColor: whiteColor,
                appBar: AppBar(
                  backgroundColor: blackColor,
                  title: const Text(
                    'Next Availability',
                    style: TextStyle(
                        color: whiteColor, fontWeight: FontWeight.bold),
                  ),
                ),
                body: Column(
                  children: [
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
                          indicatorPadding:
                              const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
                        children: dateList.map((date) {
                          return TimeSlotsWidget(
                            dateTime: date,
                            selectedIndex:
                                selectedIndex[dateList.indexOf(date)],
                            selected: selected[dateList.indexOf(date)],
                            selectedSlots: selectedSlots,
                          );
                        }).toList(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (selectedSlots.isNotEmpty) {
                          day = selectedSlots.firstWhere(
                            (element) {
                              var currDate =
                                  DateFormat('dd/MM/yyyy').format(element.date);
                              var date = DateFormat('dd/MM/yyyy')
                                  .format(dateList[_tabController.index]);
                              return currDate == date;
                            },
                            orElse: () => AvailabilityModel(
                              date: dateList[_tabController.index],
                              availableSlots: [],
                              bookedSlots: [],
                            ),
                          );
                        }
                        if (day != null) {
                          selected[_tabController.index]
                              .addAll(day!.availableSlots);

                          bookedSlots[_tabController.index]
                              .addAll(day!.bookedSlots);
                        }
                        AvailabilityModel slots = AvailabilityModel(
                            date: dateList[_tabController.index],
                            availableSlots: selected[_tabController.index],
                            bookedSlots: bookedSlots[_tabController.index]);

                        await addAvailableSlotsToFireBase(
                          currentUser!.uid,
                          slots,
                        ).then((value) {
                          showToast('Slot updated succesfully', greenColor);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                              (route) => false);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.maxFinite,
                          // height: 30,
                          decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
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
        });
  }
}
