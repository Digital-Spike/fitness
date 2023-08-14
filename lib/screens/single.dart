import 'dart:convert';

import 'package:fitness/screens/payment_ui.dart';
import 'package:fitness/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Single extends StatefulWidget {
  const Single({super.key});

  @override
  State<Single> createState() => _SingleState();
}

class _SingleState extends State<Single> {
  String paymentUrl = "";
  List<String> session = ['2', '4', '8', '12', '24', '48', '96'];
  List<int> price = [359, 652, 1248, 1788, 3096, 4800, 7599];
  List<String> perSession = ['169', '163', '156', '149', '129', '100', '79'];
  List<String> validity = [
    '15 days',
    '15 days',
    '30 days',
    '30 days',
    '60 days',
    '120 days',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
            itemCount: session.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 120, crossAxisCount: 2),
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () async {
                  showProgress();
                  await trainerList(price[index]);
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
                child: AnimatedContainer(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [colorss[index], colors[index]]),
                    // color: colors[index],
                  ),
                  duration: const Duration(seconds: 5),
                  child: Column(
                    children: [
                      Text(
                        session[index],
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Sessions',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }

  Future<bool> trainerList(int amount) async {
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
