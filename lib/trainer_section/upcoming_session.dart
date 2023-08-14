import 'dart:convert';

import 'package:fitness/constants/api_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        appBar: AppBar(
          title: const Text("Upcoming Sessions"),
          centerTitle: true,
        ),
        body: FutureBuilder<bool>(
            future: futureData,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: slots.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text('Name : '),
                                    Text(
                                      '${slots[index]['customerName']}',
                                      style: const TextStyle(
                                          color: Colors.deepOrange),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text('Date'),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1.0, color: Colors.black)),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${slots[index]['bookingDate']}',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: Colors.grey[700],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Time'),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1.0, color: Colors.black)),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${slots[index]['bookingTime']}',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Icon(
                                            Icons.access_time_outlined,
                                            color: Colors.grey[700],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Branch : ${slots[index]['branchName'] == "Home" ? slots[index]['branchName'] : slots[index]['branchId']}'),
                                Text(
                                    'Booking Id : ${'${slots[index]['bookingId']}'}')
                              ],
                            ),
                            MaterialButton(
                              onPressed: () {
                                _showDialog(slots[index]['bookingId']);
                              },
                              color: Colors.black,
                              child: const Text('Session Done'),
                            )
                          ],
                        ),
                      );
                    });
              }

              if (snapshot.hasError) {
                const Text("Something wrong");
              }

              return const Center(child: CircularProgressIndicator());
            }));
  }

  Future<bool>? getTrainerSlots() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}getTrainerBookings.php";
      http.Response? response = await http
          .post(Uri.parse(trainerUrl), body: {'trainerId': widget.trainerId});
      slots = json.decode(response.body);
      slots.retainWhere((element) => element['status'] == "PENDING");

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
