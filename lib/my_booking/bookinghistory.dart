import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
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
          leading: const BackButton(
            color: Colors.white,
          ),
          title: const Text(
            'Bookings History',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'SpaceGrotesk',
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              color: const Color(0xff142129),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: FutureBuilder<bool>(
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
                                "Not Yet Booked",
                                style: TextStyle(
                                    fontFamily: 'SpaceGrotesk',
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffB3BAC3)),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: bookingData.length,
                          itemBuilder: (context, index) {
                            final dates = bookingData[index]['bookingDate']
                                .toString()
                                .split('/');
                            const String pattern = 'dd-MMM-yyyy';
                            final String formatted = DateFormat(pattern).format(
                                DateTime.parse(
                                    "${dates[0]}-${dates[1]}-${dates[2]}"));
                            final times = bookingData[index]['bookingTime']
                                .toString()
                                .split('-');
                            String startTime = times[0];
                            String emdTime = times[1];
                            var booking = bookingData[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
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
                                        '#${booking['bookingId']}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xffB3BAC3),
                                            fontFamily: 'WorkSans'),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              formatted
                                                  .replaceAll('-', ' ')
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'WorkSans')),
                                          const SizedBox(width: 10),
                                          Text(startTime.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'WorkSans'))
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
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
                                            booking['trainerName'],
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
                                                  booking['branchName']
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
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                }
                return const Center(
                    child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ));
              }),
        ));
  }

  Future<bool> fetchData() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}getUserBookings.php";
      var response =
          await http.post(Uri.parse(trainerUrl), body: {'userId': user?.uid});
      bookingData = json.decode(response.body);

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
      return false;
    }
  }
}
