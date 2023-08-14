import 'dart:convert';

import 'package:fitness/screens/payment_ui.dart';
import 'package:fitness/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PackageDetail extends StatefulWidget {
  final Gradient gradient;
  final int session;
  final int price;
  final int perSession;
  final int validity;

  const PackageDetail(
      {super.key,
      required this.gradient,
      required this.session,
      required this.price,
      required this.perSession,
      required this.validity});

  @override
  State<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  late final WebViewController controller;

  String paymentUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black38),
          Container(
            height: 340,
            width: double.infinity,
            decoration: BoxDecoration(gradient: widget.gradient),
            // color: Color(0xfff26f14),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Number of Sessions : ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.session.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  const Text(
                    'Per Session',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        widget.perSession.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        '/Session',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      const Text(
                        'AED',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.price.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Duration ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.validity.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        ' Days',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: 60,
              right: 60,
              top: 315,
              child: MaterialButton(
                elevation: 10,
                height: 50,
                minWidth: 200,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Colors.white,
                onPressed: () async {
                  showProgress();
                  await trainerList(widget.price);
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
                child: const Text(
                  'Subscribe',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange),
                ),
              )),
        ],
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
