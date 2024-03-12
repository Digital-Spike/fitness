import 'dart:convert';

import 'package:fitness/screens/buddy.dart';
import 'package:fitness/screens/single.dart';
import 'package:fitness/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OurPackages extends StatefulWidget {
  final int initialtab;
  const OurPackages({super.key, required this.initialtab});

  @override
  State<OurPackages> createState() => _OurPackagesState();
}

class _OurPackagesState extends State<OurPackages> {
  List<Widget> plans = <Widget>[
    const Text(
      'Single',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    const Text('Buddy',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
  ];
  final List<bool> _selectedPlans = <bool>[true, false];
  bool vertical = false;
  bool isSelectedPlans = true;
  bool isSelectedPlans2 = false;
  bool isSelectedPlans1 = false;

  String? value;
  final items = ['Standard Plan', 'Special Plan'];
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
  var colors = [
    Colors.deepOrange[100],
    Colors.yellow[100],
    Colors.red[100],
    Colors.blue[100],
    Colors.green[100],
    Colors.amber[100],
    Colors.purple[100]
  ];
  var colors1 = [
    Colors.deepOrange[100],
    Colors.yellow[100],
    Colors.redAccent[100],
    Colors.blue[100],
    Colors.green[100],
    Colors.amberAccent[100],
    Colors.purple[100]
  ];

  late final WebViewController controller;
  String paymentUrl = "";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initialtab,
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: const Text(
              'Our Packages',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SpaceGrotesk',
                fontWeight: FontWeight.w600,
              ),
            ),
            elevation: 0,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                height: 1.0,
                color: const Color(0xff142129),
              ),
            ),
          ),
          body: Column(children: [
            const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                indicator: BoxDecoration(color: Colors.white),
                tabs: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Single',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'SpaceGrotesk',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    'Buddy',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'SpaceGrotesk',
                        fontWeight: FontWeight.w600),
                  )
                ]),
            Container(
              height: 2,
              color: const Color(0xff142129),
            ),
            const Expanded(child: TabBarView(children: [Single(), Buddy()])),
          ])),
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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.001),
              child: GestureDetector(
                onTap: () {},
                child: DraggableScrollableSheet(
                  expand: true,
                  initialChildSize: 1,
                  builder: (BuildContext context, controller) {
                    return SingleChildScrollView(
                      controller: controller,
                      child: Container(
                        height: 1500,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: WebViewWidget(controller: this.controller),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showProgress() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Lottie.asset('assets/json/fjloader.json', height: 100)),
        );
      },
    );
  }
}
