// ignore_for_file: unused_element

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/my_booking/slotBookingPage.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/my_booking/bookinghistory.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({super.key});

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  Future<bool>? futureData;
  List bookingData = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    futureData = fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            },
          ),
          title: const Text(
            'Bookings',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'SpaceGrotesk',
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BookingHistory()));
                },
                child: SvgPicture.asset('assets/svg/history.svg')),
            const SizedBox(
              width: 20,
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              color: const Color(0xff142129),
            ),
          ),
        ),
        body: FutureBuilder<bool>(
            future: futureData,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return (bookingData.isEmpty)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/fjsearch.svg'),
                            const SizedBox(height: 25),
                            const Text(
                              "No Bookings found!",
                              style: TextStyle(
                                  fontFamily: 'SpaceGrotesk',
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffB3BAC3)),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ListView.builder(
                            itemCount: bookingData.length,
                            itemBuilder: ((context, index) {
                              final dates = bookingData[index]['bookingDate']
                                  .toString()
                                  .split('/');
                              const String pattern = 'dd-MMM-yyyy';
                              final String formatted = DateFormat(pattern)
                                  .format(DateTime.parse(
                                      "${dates[0]}-${dates[1]}-${dates[2]}"));
                              final times = bookingData[index]['bookingTime']
                                  .toString()
                                  .split('-');
                              String startTime = times[0];
                              String emdTime = times[1];
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff142129)),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '#${bookingData[index]['bookingId']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'WorkSans',
                                              color: Color(0xffB3BAC3)),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              formatted
                                                  .replaceAll('-', ' ')
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  fontFamily: 'WorkSans',
                                                  fontSize: 16,
                                                  color: Color(0xffB3BAC3)),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  startTime.toUpperCase(),
                                                  style: const TextStyle(
                                                      fontFamily: 'WorkSans',
                                                      fontSize: 16),
                                                ),
                                                SvgPicture.asset(
                                                    'assets/svg/two-arrow.svg'),
                                                Text(emdTime.toUpperCase(),
                                                    style: const TextStyle(
                                                        fontFamily: 'WorkSans',
                                                        fontSize: 16))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Container(
                                            height: 42,
                                            width: 42,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: const Color(0xff142129)),
                                            child: Image.network(
                                                '${ApiList.imageUrl}/${bookingData[index]['image']}')),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ' ${bookingData[index]['trainerName']}',
                                              style: const TextStyle(
                                                  fontFamily: 'SpaceGrotesk',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/svg/marker.svg'),
                                                const SizedBox(width: 3),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.5,
                                                  child: Text(
                                                    bookingData[index]
                                                            ['branchName']
                                                        .toString()
                                                        .replaceAll('\n', ''),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'WorkSans'),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        OutlinedButton(
                                            onPressed: () {
                                              cancelBooking(
                                                  bookingId: bookingData[index]
                                                      ['bookingId']);
                                            },
                                            child: const Text(
                                              'CANCEL',
                                              style: TextStyle(
                                                  fontFamily: 'SpaceGrotesk',
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            )),
                                        const SizedBox(width: 15),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white),
                                            onPressed: () {
                                              changeSlot(
                                                  changeSlotEnum:
                                                      ChangeSlotEnum.postpone,
                                                  booking: bookingData[index]);
                                            },
                                            child: const Text('RE-SCHEDULE',
                                                style: TextStyle(
                                                    fontFamily: 'SpaceGrotesk',
                                                    fontSize: 16,
                                                    color: Colors.black))),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            })),
                      );
              }

              if (snapshot.hasError) {
                const Text("Something wrong");
              }

              return const Center(
                  child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ));
            }));
  }

  Future<bool> fetchData() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}getUserBookings.php";
      var response =
          await http.post(Uri.parse(trainerUrl), body: {'userId': user?.uid});
      bookingData = json.decode(response.body);
      print(response.body);
      bookingData.retainWhere((element) => element['status'] == "PENDING");

      Set<String> seenIds = {};
      List<Map<String, dynamic>> uniqueList = [];

      for (var item in bookingData) {
        String id = item['bookingId'];
        if (!seenIds.contains(id)) {
          seenIds.add(id);
          uniqueList.add(item);
        }
      }
      bookingData = uniqueList;

      return true;
    } catch (e) {
      setState(() {
        bookingData.clear();
      });
      return false;
    }
  }

  void changeSlot(
      {required ChangeSlotEnum changeSlotEnum, required var booking}) async {
    Map<String, dynamic> trainer = {};

    try {
      String trainerUrl = "${ApiList.apiUrl}admin/viewTrainer.php";
      var response = await http.post(Uri.parse(trainerUrl), body: {
        'trainerId': booking['trainerId'].toString(),
      });
      trainer = json.decode(response.body);

      print(response.body);
    } catch (e) {}
    if (!mounted) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SlotBookingPage(
          isBranch: booking?['branchName'].toString().toLowerCase() != 'home',
          bookingData: booking,
          trainer: trainer,
          changeSlotEnum: changeSlotEnum,
          isChangeSlot: true,
          trainerName: booking['trainerName'],
          branchAddress: booking['branchName'],
          trainerImage: booking['image'],
          trainerRating: booking['rating'],
          experience: booking['description'],
          branchName: booking['branchName'],
        ),
      ),
    );
  }

  void cancelBooking({required String bookingId}) async {
    try {
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
                  CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
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
      String trainerUrl = "${ApiList.apiUrl}cancelBooking.php";
      await http.post(Uri.parse(trainerUrl),
          body: {'bookingId': bookingId, 'userId': user?.uid});
    } catch (e) {}
    Navigator.of(context).pop();
    futureData = fetchData();
  }
}

enum ChangeSlotEnum { postpone, prepone, cancel }
