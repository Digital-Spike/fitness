import 'dart:convert';

import 'package:fitness/constants/api_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UpcomingSession extends StatefulWidget {
  final String trainerId;
  const UpcomingSession({super.key, required this.trainerId});

  @override
  State<UpcomingSession> createState() => _UpcomingSessionState();
}

class _UpcomingSessionState extends State<UpcomingSession> {
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
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: FutureBuilder<bool>(
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
                        DateTime.parse("${dates[0]}-${dates[1]}-${dates[2]}"));
                    final times =
                        slots[index]['bookingTime'].toString().split('-');
                    String startTime = times[0];
                    String endtime = times[1];

                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff142129)),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '#${slots[index]['bookingId']}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffB3BAC3),
                                        fontFamily: 'WorkSans'),
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
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        slots[index]['customerName'],
                                        style: const TextStyle(
                                            fontFamily: 'SpaceGrotesk',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/svg/marker.svg'),
                                            Expanded(
                                              child: Text(
                                                ' ${slots[index]['branchName'].toString().replaceAll('\n', '')}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'SpaceGrotesk'),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      _showDialog(slots[index]['bookingId']);
                                    },
                                    child: const Text(
                                      'End Session',
                                      style: TextStyle(
                                          fontFamily: 'SpaceGrotesk',
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
          }),
    ));
  }

  Future<bool>? getTrainerSlots() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}getTrainerBookings.php";
      http.Response? response = await http
          .post(Uri.parse(trainerUrl), body: {'trainerId': widget.trainerId});
      slots = json.decode(response.body);
      slots.retainWhere((element) => element['status'] == "PENDING");
      print(response.body);
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

  _showDialog(String bookingId) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Session Done',
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Change session status?',
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
                                child: Text(
                                  'Loading...',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                );
                await changeSessionStatus(bookingId);
                if (!mounted) {
                  return;
                }
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                setState(() {
                  futureData = getTrainerSlots();
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

  Future<void> changeSessionStatus(String bookingId) async {
    try {
      String trainerUrl =
          "https://fitnessjourni.com/trainers/completeBooking.php";
      await http.post(Uri.parse(trainerUrl), body: {'bookingId': bookingId});
    } catch (e) {}
  }
}
