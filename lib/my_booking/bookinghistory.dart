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
  Map<String, dynamic>? bookingData;
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
                    itemCount: bookingData?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Trainer Name :',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(
                                  ' ${bookingData?['trainerName']}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.deepOrange),
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Booking Id :',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text('${bookingData?['bookingId']}',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black))
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Booking Date :',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text('${bookingData?['bookingDate']}',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black))
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Booking Time :',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text('${bookingData?['bookingTime']}',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black))
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Branch :',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text('${bookingData?['branchName']}',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black))
                              ],
                            )
                          ],
                        ),
                      );
                    });
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Future<bool> fetchData() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}getUserBookings.php";
      var response =
          await http.post(Uri.parse(trainerUrl), body: {'userId': user?.uid});
      bookingData = json.decode(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }
}
