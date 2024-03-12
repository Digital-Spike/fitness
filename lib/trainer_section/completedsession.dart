import 'dart:convert';

import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CompletedSession extends StatefulWidget {
  final String trainerId;
  const CompletedSession({super.key, required this.trainerId});

  @override
  State<CompletedSession> createState() => _CompletedSessionState();
}

class _CompletedSessionState extends State<CompletedSession> {
  Future<bool>? futureData;
  List slots = [];

  @override
  void initState() {
    futureData = getTrainerSlots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<bool>(
            future: futureData,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: slots.length,
                    itemBuilder: (context, index) {
                      final dates =
                          slots[index]['bookingDate'].toString().split('/');
                      const String pattern = 'dd-MMM-yyyy';
                      final String formatted = DateFormat(pattern).format(
                          DateTime.parse(
                              "${dates[0]}-${dates[1]}-${dates[2]}"));
                      final times =
                          slots[index]['bookingTime'].toString().split('-');
                      String startTime = times[0];
                      String endtime = times[1];
                      return Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff142129)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '#${slots[index]['bookingId']}',
                                  style: const TextStyle(
                                      fontFamily: 'WorkSans',
                                      fontSize: 16,
                                      color: Color(0xffB3BAC3)),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      formatted
                                          .replaceAll('-', ' ')
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'WorkSans',
                                          color: Color(0xffB3BAC3)),
                                    ),
                                    Row(
                                      children: [
                                        Text(startTime.toUpperCase()),
                                        SvgPicture.asset(
                                            'assets/svg/two-arrow.svg'),
                                        Text(endtime.toUpperCase())
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              slots[index]['customerName'],
                              style: const TextStyle(
                                  fontFamily: 'SpaceGrotesk',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/svg/marker.svg'),
                                Text(
                                    ' ${slots[index]['branchName'] == "Home" ? slots[index]['branchName'] : slots[index]['branchId']}')
                              ],
                            ),
                          ],
                        ),
                      );
                    });
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

  Future<bool>? getTrainerSlots() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}getTrainerBookings.php";
      http.Response? response = await http
          .post(Uri.parse(trainerUrl), body: {'trainerId': widget.trainerId});
      slots = json.decode(response.body);
      slots.retainWhere((element) {
        return element['status'] == "COMPLETED";
      });

      Set<String> seenIds = {};
      List<Map<String, dynamic>> uniqueList = [];

      for (var item in slots) {
        String id = item['bookingId'];
        if (!seenIds.contains(id)) {
          seenIds.add(id);
          uniqueList.add(item);
        }
      }
      slots = uniqueList;
      return true;
    } catch (e) {
      return false;
    }
  }
}
