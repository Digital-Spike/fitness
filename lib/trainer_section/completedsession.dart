import 'dart:convert';

import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        appBar: AppBar(
          title: const Text('Completed Sessions'),
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
                                    const Text('Name :'),
                                    Text(
                                      ' ${slots[index]['customerName']}',
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
                                    Text(
                                        'Date : ${slots[index]['bookingDate']}')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        'Time : ${slots[index]['bookingTime']}')
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        'Branch : ${slots[index]['branchName'] == "Home" ? slots[index]['branchName'] : slots[index]['branchId']}')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        'Booking Id : ${'${slots[index]['bookingId']}'}'),
                                  ],
                                )
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

              return const Center(child: CircularProgressIndicator());
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

      return true;
    } catch (e) {
      return false;
    }
  }
}
