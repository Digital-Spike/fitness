import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SlotBooking extends StatefulWidget {
  final bool isBranch;
  final Map<String, dynamic> trainer;

  const SlotBooking({required this.isBranch, required this.trainer, super.key});

  @override
  State<SlotBooking> createState() => _SlotBookingState();
}

class _SlotBookingState extends State<SlotBooking> {
  Map<String, dynamic> slots = {};
  final CalendarFormat _calenderFormat = CalendarFormat.month;
  User? user = FirebaseAuth.instance.currentUser;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Future<bool>? futureData;

  List homeTimeStamp = [
    "9:00 am - 10:30 am",
    "10:30 am - 12:00 pm",
    "12:00 pm - 1:30 pm",
    "2:00 pm - 3:30 pm",
    "3:30 pm - 5:00 pm",
    "5:00 pm - 6:30 pm",
    "6:30 pm - 8:00 pm"
  ];

  List branchTimeStamp = [
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

  @override
  void initState() {
    futureData = slotList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.white,
          ),
        ),
        title: const Text('Choose a date and slot',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
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
                  todayDecoration:
                      BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  defaultTextStyle: TextStyle(color: Colors.white),
                  selectedDecoration: BoxDecoration(
                      color: Colors.orange, shape: BoxShape.circle)),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  futureData = slotList();
                });
              },
            ),
            const Divider(
              color: Colors.white,
              height: 1.0,
              thickness: 1.0,
            ),
            const SizedBox(height: 15),
            const Text('Available Slots',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: FutureBuilder<bool>(
                future: futureData,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: slots.length,
                      itemBuilder: (context, index) {
                        List timeStamp =
                            widget.isBranch ? branchTimeStamp : homeTimeStamp;

                        bool isBooked = slots[(index + 1).toString()]
                                .toString()
                                .toLowerCase() ==
                            "booked";

                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.all(16),
                          height: 100,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(timeStamp[index],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              slots[(index + 1).toString()].toUpperCase(),
                              style: TextStyle(
                                  color: isBooked ? Colors.grey : Colors.green),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () async {
                                if (!isBooked) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              CircularProgressIndicator(),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 4.0),
                                                child: Text("Processing..."),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  await bookSession(
                                      bookingTime: timeStamp[index],
                                      slotNumber: (index + 1).toString());
                                  if (mounted) {
                                    Navigator.of(context).pop();
                                  }
                                  setState(() {
                                    futureData = slotList();
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      isBooked ? Colors.grey : Colors.green,
                                  side: BorderSide(
                                      width: 1,
                                      color: isBooked
                                          ? Colors.grey
                                          : Colors.green),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                    20,
                                  ))),
                              child: Text(
                                isBooked ? 'Booked' : 'Book Now',
                                style: const TextStyle(color: Colors.white),
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
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<bool> slotList() async {
    try {
      http.Response? response;
      if (widget.isBranch) {
        String trainerUrl = "${ApiList.apiUrl}slotavailability.php";
        response = await http.post(Uri.parse(trainerUrl), body: {
          'trainerId': widget.trainer['trainerId'],
          'bookingDate':
              DateFormat('yyyy/MM/dd').format(_selectedDay ?? _focusedDay)
        });
      } else {
        String trainerUrl = "${ApiList.apiUrl}webslothome.php";
        response = await http.post(Uri.parse(trainerUrl), body: {
          'trainerId': widget.trainer['trainerId'],
          'bookingDate': DateFormat('yyyy/MM/dd')
              .format(_selectedDay ?? _focusedDay) /*'2023/06/24'*/
        });
      }

      slots = json.decode(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> bookSession({
    required String slotNumber,
    required String bookingTime,
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        'trainerId': widget.trainer['trainerId'],
        widget.isBranch ? 'bookingDate' : 'bDate':
            DateFormat('yyyy/MM/dd').format(_selectedDay ?? _focusedDay),
        'branchId': widget.trainer['branchId1'],
        'bookingId': StringUtil().generateRandomNumber(length: 10),
        'customerId': user?.uid,
        'customerName': 'Shashi',
        'trainerName': widget.trainer['name'],
        'bookingTime': bookingTime,
        'slot': slotNumber,
        'amount': '500'
      };

      String trainerUrl = widget.isBranch
          ? "${ApiList.apiUrl}addBooking.php"
          : "${ApiList.apiUrl}homeaddBooking.php";
      await http.post(Uri.parse(trainerUrl), body: requestBody);
      return true;
    } catch (e) {
      return false;
    }
  }
}
