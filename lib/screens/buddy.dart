import 'dart:convert';

import 'package:fitness/screens/payment_ui.dart';
import 'package:fitness/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Buddy extends StatefulWidget {
  const Buddy({super.key});

  @override
  State<Buddy> createState() => _BuddyState();
}

class _BuddyState extends State<Buddy> {
  List<String> session1 = ['2', '4', '8', '12', '24', '48', '96'];
  List<String> price1 = ['398', '796', '1552', '2328', '4296', '6240', '9600'];
  List<String> persession1 = ['199', '199', '194', '194', '179', '130', '100'];
  List<String> validity1 = [
    '15 days',
    '30 days',
    '60 days',
    '90 days',
    '160 days',
    '180 days',
    '365 days'
  ];
  final List<Color> colors = [
    Colors.red.shade900,
    Colors.green.shade900,
    Colors.cyan.shade900,
    Colors.orange.shade900,
    Colors.purple.shade900,
    Colors.yellow.shade900,
    Colors.teal.shade900,
    Colors.pink.shade900,
  ];
  final List<Color> colorss = [
    Colors.red.shade200,
    Colors.green.shade200,
    Colors.cyan.shade200,
    Colors.orange.shade200,
    Colors.purple.shade200,
    Colors.yellow.shade200,
    Colors.teal.shade200,
    Colors.pink,
  ];

  String paymentUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
            itemCount: session1.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 120, crossAxisCount: 2),
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () async {
                  showProgress();
                  await trainerList(price1[index]);
                  if (!mounted) {
                    return;
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PaymentPage(
                                paymentUrl: paymentUrl,
                              )));
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [colorss[index], colors[index]]),
                  ),
                  child: Column(
                    children: [
                      Text(
                        session1[index],
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Sessions',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }

  Future<bool> trainerList(String amount) async {
    try {
      Response? response = await http.post(
          Uri.parse("https://fitnessjourni.com/getPaymentUrl.php"),
          body: {
            'bookingId': StringUtil().generateRandomNumber(length: 8),
            'amount': amount.toString()
          });
      paymentUrl = jsonDecode(response.body)['paymentUrl'];
      return true;
    } catch (e) {
      return false;
    }
  }

  void showProgress() {
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
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
