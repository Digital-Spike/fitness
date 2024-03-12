import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/screens/ourpackages.dart';
import 'package:flutter/material.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  String? totalSlots, plan, available;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subscription',
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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            if (totalSlots != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff142129),
                    border:
                        Border.all(width: 1, color: const Color(0xff1A2A34))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Subcription Plan',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffB3BAC3),
                          fontFamily: 'Spacegrotesk'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${totalSlots != null ? totalSlots.toString() : ''} Session',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '175/session',
                              style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 12,
                                  color: Color(0xffB3BAC3)),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'AED ${plan != null ? plan.toString() : ''}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Validity 1 Day',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 12,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    // OutlinedButton(
                    //     style: OutlinedButton.styleFrom(
                    //         minimumSize: Size(double.infinity, 38)),
                    //     onPressed: () {},
                    //     child: const Text(
                    //       'Cancel Subscription',
                    //       style: TextStyle(
                    //           fontFamily: 'WorkSans',
                    //           fontSize: 14,
                    //           color: Colors.white),
                    //     ))
                  ],
                ),
              ),
            const Spacer(
              flex: 2,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text(
                'Discover subscription options for enhanced features and benefits.',
                style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 20,
                    color: Color(0xffB3BAC3)),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, minimumSize: Size(190, 46)),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const OurPackages(initialtab: 0)));
                },
                child: const Text(
                  'EXPLORE',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'SpaceGrotesk',
                      color: Colors.black),
                )),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Future<String> getUser() async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      String url = 'https://fitnessjourni.com/api/getUser.php';

      var response = await http.post(Uri.parse(url), body: {'userId': userId});
      print(response.body);
      var jsondata = json.decode(response.body);

      setState(() {
        available = jsondata['available'];
        plan = jsondata['plan'];
        totalSlots = jsondata['totalSlots'];
        userId = jsondata['userId'];
      });
    } on HandshakeException catch (_) {}
    return "success";
  }
}
