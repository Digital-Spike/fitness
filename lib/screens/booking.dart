import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
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
        backgroundColor: Colors.black,
        body: FutureBuilder<bool>(
            future: futureData,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Booking Confirmed',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text(
                                'Trainer Name :',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  ' ${bookingData?['trainerName']}',
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text(
                                'Booking Id      :',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  ' ${bookingData?['bookingId']}',
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text(
                                'Booking Date :',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  ' ${bookingData?['bookingDate']}',
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text(
                                'Booking Time :',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  ' ${bookingData?['bookingTime']}',
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text(
                                'Branch Name :',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  ' ${bookingData?['branch']}',
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Center(
                            child: Text(
                              'Thank You For Choosing\nFitness Journey',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                const Text("Something wrong");
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
      return true;
    } catch (e) {
      return false;
    }
  }
}
