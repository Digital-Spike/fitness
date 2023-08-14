import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        // backgroundColor: Color(0xffF5E6C2),
        body: FutureBuilder<bool>(
            future: futureData,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: bookingData.length,
                    itemBuilder: (context, index) {
                      var booking = bookingData[index];
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Trainer Name :',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  ' ${booking?['trainerName']}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.deepOrange),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  'Booking Id :',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text('${booking?['bookingId']}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black))
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  'Booking Date :',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text('${booking?['bookingDate']}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black))
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  'Booking Time :',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text('${booking?['bookingTime']}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black))
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  'Branch :',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text('${booking?['branchName']}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black))
                              ],
                            )
                          ],
                        ),
                      );
                    });
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  Future<bool> fetchData() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}getUserBookings.php";
      var response =
          await http.post(Uri.parse(trainerUrl), body: {'userId': user?.uid});
      bookingData = json.decode(response.body);

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
