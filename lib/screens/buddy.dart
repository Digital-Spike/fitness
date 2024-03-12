import 'dart:convert';

import 'package:fitness/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class Buddy extends StatefulWidget {
  const Buddy({super.key});

  @override
  State<Buddy> createState() => _BuddyState();
}

class _BuddyState extends State<Buddy> {
  final WebViewController controller = WebViewController();
  String paymentUrl = "";
  List<Map<String, dynamic>> plansList = [];
  Future<void>? futureData;
  final List<String> gridImage = [
    'assets/png/Variant3.png',
    'assets/png/Group 69.png',
    'assets/png/Group 64.png',
    'assets/png/Variant.png',
    'assets/png/Group 65.png',
    'assets/png/Group 66.png',
    'assets/png/Group 67.png',
    'assets/png/Group 68.png',
  ];
  final List<Color> colorPrice = [
    const Color(0xffFF5454),
    const Color(0xff57FF54),
    const Color(0xff00C2FF),
    const Color(0xffFF6600),
    const Color(0xffB454FF),
    const Color(0xffFFE500),
    const Color(0xff00FFC2),
    const Color(0xffFF00F5)
  ];

  @override
  void initState() {
    super.initState();
    futureData = getBranchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<void>(
          future: futureData,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                itemCount: plansList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.03,
                  crossAxisCount: 2,
                ),
                itemBuilder: ((context, index) {
                  var package = plansList[index];
                  String sessions = package['sessions'];
                  String validity = package['validity'];
                  String prices = package['price'];
                  int price = int.tryParse(prices.split(' ')[0]) ?? 0;
                  int session = int.tryParse(sessions.split(' ')[0]) ?? 0;
                  int days = int.tryParse(validity.split(' ')[0]) ?? 0;
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage(gridImage[index]),
                            fit: BoxFit.cover)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (session == 1)
                          Text(
                            '${package['sessions'].toString()} Session',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (session > 1)
                          Text(
                            '${package['sessions'].toString()} Sessions',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        Text(
                          '${package['price_session']}/session',
                          style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'WorkSans',
                              color: Color(0xffB3BAC3)),
                        ),
                        const Spacer(),
                        Center(
                          child: Text(
                            'AED ${package['price']}',
                            style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: colorPrice[index]),
                          ),
                        ),
                        if (days == 1)
                          Center(
                            child: Text(
                              'Validity $days Day',
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (days > 1)
                          Center(
                            child: Text(
                              'Validity $days Days',
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ElevatedButton(
                            style: ButtonStyle(
                                side:
                                    const MaterialStatePropertyAll<BorderSide>(
                                  BorderSide(width: 1, color: Colors.white),
                                ),
                                backgroundColor:
                                    const MaterialStatePropertyAll<Color>(
                                        Colors.transparent),
                                overlayColor: MaterialStateProperty.resolveWith(
                                  (states) {
                                    return states
                                            .contains(MaterialState.pressed)
                                        ? colorPrice[index]
                                        : Colors.transparent;
                                  },
                                ),
                                minimumSize:
                                    const MaterialStatePropertyAll<Size>(
                                        Size(double.infinity, 34))),
                            onPressed: () async {
                              showProgress();
                              await trainerList(price);
                              controller
                                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                ..setBackgroundColor(const Color(0x00000000))
                                ..loadRequest(Uri.parse(paymentUrl));
                              if (!mounted) {
                                return;
                              }
                              Navigator.of(context).pop();
                              _showBottomSheet(context);
                            },
                            child: const Text(
                              'SUBSCRIBE',
                              style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 14,
                                  color: Colors.white),
                            ))
                      ],
                    ),
                  );
                }),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            } else {
              return const Center(
                  child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ));
            }
          },
        ),
      ),
    );
  }

  Future<void> getBranchList() async {
    try {
      String trainerUrl = "https://fitnessjourni.com/api/getAllPackages";
      var response = await http.post(Uri.parse(trainerUrl), body: {});

      if (response.statusCode == 200) {
        print("API Response: ${response.body}");
        List<Map<String, dynamic>> allPackages =
            (json.decode(response.body) as List<dynamic>)
                .map((package) => package as Map<String, dynamic>)
                .toList();

        plansList = allPackages
            .where((package) => package['persons'] == 'buddy')
            .toList();
      }
    } catch (e) {
      print("Error: $e");
    }

    setState(() {});
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
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  'Loading...',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'SpaceGrotesk',
                      color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
