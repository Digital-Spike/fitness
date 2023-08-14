import 'dart:convert';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/my_booking/booking.dart';
import 'package:fitness/my_booking/mybookings.dart';
import 'package:fitness/screens/packages_.dart';
import 'package:fitness/util/string_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SlotBookingPage extends StatefulWidget {
  final bool isBranch;

  final Map<String, dynamic> trainer;
  final Map<String, dynamic>? bookingData;
  final bool? isChangeSlot;
  final ChangeSlotEnum? changeSlotEnum;
  const SlotBookingPage(
      {required this.isBranch,
      required this.trainer,
      this.bookingData,
      this.isChangeSlot,
      this.changeSlotEnum,
      super.key});

  @override
  State<SlotBookingPage> createState() => _SlotBookingPageState();
}

class _SlotBookingPageState extends State<SlotBookingPage> {
  Future<bool>? futureData;
  Map<String, dynamic> slots = {};
  DateTime _selectedDay = DateTime.now();
  User? user = FirebaseAuth.instance.currentUser;

  final items = [
    'Free Trail Session',
    'Pay Per Session',
    'Single Plan Subscription',
    'Buddy Plan Subscription'
  ];
  String? value;
  final items1 = [
    'EMS Fitness Training',
    'Personal Training',
    'Injury Rehab',
    'Body Building'
  ];

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
      appBar: AppBar(
        elevation: 0,
        title: const Text('Book Your Session',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
        centerTitle: true,
        // leading: const BackButton(color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              '   Preferred Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.white10,
              height: 100,
              width: double.infinity,
              child: DatePicker(
                DateTime.now(),
                dayTextStyle: TextStyle(color: Colors.orangeAccent),
                monthTextStyle: TextStyle(color: Colors.orange),
                dateTextStyle: TextStyle(color: Colors.amber, fontSize: 16),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black54,
                selectedTextColor: Colors.white,
                deactivatedColor: Colors.white,
                onDateChange: (date) {
                  setState(() {
                    _selectedDay = date;
                    futureData = slotList();
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '  Preferred Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.60,
              child: FutureBuilder<bool>(
                future: futureData,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: slots.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          mainAxisExtent: 100,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          List timeStamp =
                              widget.isBranch ? branchTimeStamp : homeTimeStamp;

                          bool isBooked = slots[(index + 1).toString()]
                                  .toString()
                                  .toLowerCase() ==
                              "booked";

                          return InkWell(
                            onTap: () {
                              if (!isBooked) {
                                if (ApiList.user?['subscriptionId'] == null ||
                                    ApiList.user?['available'] == "0") {
                                  showSubscriptionPopup();
                                  return;
                                }

                                showBookingPopup(
                                    timeStamp: timeStamp[index],
                                    index: index,
                                    isBooked: isBooked);
                              }
                            },
                            child: Container(
                              height: 100,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    timeStamp[index],
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    isBooked ? "Not available" : "Available",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isBooked
                                            ? Colors.grey
                                            : Colors.green),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }

                  if (snapshot.hasError) {
                    const Text("Something wrong");
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
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
          'bookingDate': DateFormat('yyyy/MM/dd').format(_selectedDay)
        });
      } else {
        String trainerUrl = "${ApiList.apiUrl}webslothome.php";
        response = await http.post(Uri.parse(trainerUrl), body: {
          'trainerId': widget.trainer['trainerId'],
          'bdate': DateFormat('yyyy/MM/dd').format(_selectedDay)
        });
      }
      slots = json.decode(response.body);
      if (DateFormat('yyyy/MM/dd').format(_selectedDay) ==
          DateFormat("yyyy/MM/dd").format(DateTime.now())) {
        List branchTimeStamp1 = [
          '8:45AM',
          '9:30AM',
          '10:15AM',
          '11:00AM',
          '11:45AM',
          '1:45PM',
          '2:30PM',
          '3:15PM',
          '4:00PM',
          '4:45PM',
          '5:30PM',
          '6:15PM',
          '7:00PM'
        ];
        List homeTimeStamp1 = [
          "8:30AM",
          "10:00AM",
          "11:30AM",
          "1:30PM",
          "3:00PM",
          "4:30PM",
          "6:00PM"
        ];
        List timeStamp1 = widget.isBranch ? branchTimeStamp1 : homeTimeStamp1;
        for (int i = 0; i < timeStamp1.length; i++) {
          var df = DateFormat("h:mma");
          var dt = df.parse(timeStamp1[i]);

          String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

          final dt3 =
              DateTime.parse("$currentDate ${DateFormat('HH:mm').format(dt)}");

          var datetime = DateTime.now();

          if (dt3.isAfter(datetime)) {
          } else {
            slots[(i + 1).toString()] = "booked";
          }
        }
      } else {
        slots = json.decode(response.body);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      );
  DropdownMenuItem<String> buildMenuItem1(String item1) => DropdownMenuItem(
        value: item1,
        child: Text(
          item1,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      );

  Future<void> showBookingPopup(
      {required String timeStamp,
      required int index,
      required bool isBooked}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Book Slot?',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Are you sure?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text(
                'YES',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () async {
                if (!(widget.isChangeSlot ?? false) && isBooked) {
                  return;
                }
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text("Processing..."),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                if (widget.isChangeSlot ?? false) {
                  await changeSlotFuture(
                      bookingTime: timeStamp,
                      slotNumber: (index + 1).toString());
                } else if (!isBooked) {
                  await bookSession(
                      bookingTime: timeStamp,
                      slotNumber: (index + 1).toString());
                }
                if (mounted) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyBookingPage()));
                }
                setState(() {
                  futureData = slotList();
                });
              },
            ),
            MaterialButton(
              child: const Text(
                'NO',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showSubscriptionPopup() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'No active subscription plan?',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Choose subscription plan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text(
                'YES',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () async {
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OurPackages()));*/

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Packages()));
              },
            ),
            MaterialButton(
              child: const Text(
                'NO',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> bookSession({
    required String slotNumber,
    required String bookingTime,
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        'trainerId': widget.trainer['trainerId'],
        'bookingDate': DateFormat('yyyy/MM/dd').format(_selectedDay),
        'branchName': widget.trainer['name'],
        'bookingId': StringUtil().generateRandomNumber(length: 10),
        'customerId': user?.uid,
        'customerName': /*ApiList.user?['name']*/
            user?.displayName ?? ApiList.user?['name'],
        'trainerName': widget.trainer['name'],
        'bookingTime': bookingTime,
        'slot': slotNumber,
        'amount': '500'
      };

      String trainerUrl = widget.isBranch
          ? "${ApiList.apiUrl}addBooking.php"
          : "${ApiList.apiUrl}homeaddBooking.php";
      jsonEncode(requestBody);
      await http.post(Uri.parse(trainerUrl), body: requestBody);
      return true;
    } catch (e) {
      return false;
    }
  }

  changeSlotFuture(
      {required String bookingTime, required String slotNumber}) async {
    try {
      Map<String, dynamic> requestBody = {
        'bookingDate': DateFormat('yyyy/MM/dd').format(_selectedDay),
        'bookingId': widget.bookingData?["bookingId"],
        'bookingTime': bookingTime,
        'slot': slotNumber,
      };

      String changeSlot = "${ApiList.apiUrl}updateBooking.php";
      await http.post(Uri.parse(changeSlot), body: requestBody);
      return true;
    } catch (e) {
      return false;
    }
  }
}
