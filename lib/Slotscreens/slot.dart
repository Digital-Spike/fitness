import 'dart:convert';

import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class SlotBook extends StatefulWidget {
  final String trainer;
  final bool isBranch;

  const SlotBook({required this.trainer, required this.isBranch, super.key});

  @override
  State<SlotBook> createState() => _SlotBookState();
}

class _SlotBookState extends State<SlotBook>
    with SingleTickerProviderStateMixin {
  bool _showCircle = false;
  Map<String, dynamic> slots = {};
  final CalendarFormat _calenderFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Future<bool>? futureData;

  Future<dynamic> loadData() async {
    setState(() {
      _showCircle = true;
    });
  }

  @override
  void initState() {
    futureData = slotList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xffF1F1F2),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
             // backgroundColor: Colors.black,
              centerTitle: true,
              title: Text(
                'Slot Booking',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              expandedHeight: 50,
              pinned: true,
              snap: true,
              floating: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 350,
                child: TableCalendar(
                  rowHeight: 50,
                  focusedDay: _focusedDay,
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2030),
                  calendarFormat: _calenderFormat,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      leftChevronIcon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      rightChevronIcon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red)),
                  calendarStyle: const CalendarStyle(
                      weekendTextStyle: TextStyle(color: Colors.red),
                      todayDecoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                      defaultTextStyle: TextStyle(color: Colors.white),
                      selectedDecoration: BoxDecoration(
                          color: Colors.orange, shape: BoxShape.circle)),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                    });
                  },
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: FutureBuilder<bool>(
                      future: futureData,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                            itemCount: slots.length,
                            itemBuilder: (context, index) {
                              List branchTimeStamp = [
                                "9:00 am - 10:30 am",
                                "10:30 am - 12:00 pm",
                                "12:00 pm - 1:30 pm",
                                "2:00 pm - 3:30 pm",
                                "3:30 pm - 5:00 pm",
                                "5:00 pm - 6:30 pm",
                                "6:30 pm - 8:00 pm"
                              ];

                              List trainerTimeStamp = [
                                "9:00 am - 9:45 am",
                                "9:45 am - 10:30 am",
                                "10:30 am - 11:15 am",
                                "11:15 am - 12:00 pm",
                                "12:00 pm - 12:45 pm",
                                "2:00 pm - 2:45 pm",
                                "2:45 pm - 3:30 pm",
                                "3:30 pm - 4:15 pm",
                                "4:15 pm - 5:00 pm",
                                "5:00 pm -5:45 pm",
                                "5:45 pm - 6:30 pm",
                                "6:30 pm - 7:15 pm",
                                "7:15 pm - 8:00 pm"
                              ];

                              bool isBooked = slots[(index + 1).toString()]
                                      .toString()
                                      .toLowerCase() ==
                                  "booked";

                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                padding: const EdgeInsets.all(16),
                              
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  title: Text(trainerTimeStamp[index],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(
                                    slots[(index + 1).toString()].toUpperCase(),
                                    style: TextStyle(
                                        color: isBooked
                                            ? Colors.grey
                                            : Colors.green),
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: isBooked
                                            ? Colors.grey
                                            : Colors.green,
                                        side: BorderSide(
                                            width: 1,
                                            color: isBooked
                                                ? Colors.grey
                                                : Colors.green),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                          20,
                                        ))),
                                    child: const Text(
                                      'Book Now',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              );
                            },
                          );
                        }

                        if (snapshot.hasError) {
                          const Text("Something wrong");
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> slotList() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}slotavailability.php";

      var response = await http.post(Uri.parse(trainerUrl),
          body: {'trainerId': widget.trainer, 'bookingDate': '2023/06/19'});
      slots = json.decode(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }
}
