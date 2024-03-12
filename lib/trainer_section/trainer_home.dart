import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/authentication%20screen/loginpage.dart';
import 'package:fitness/constants/api_list.dart';

import 'package:fitness/trainer_section/completedsession.dart';
import 'package:fitness/trainer_section/upcoming_session.dart';
import 'package:fitness/trainer_section/updatedsession.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TrainerHome extends StatefulWidget {
  const TrainerHome({super.key});

  @override
  State<TrainerHome> createState() => _TrainerHomeState();
}

class _TrainerHomeState extends State<TrainerHome> {
  Future<bool>? futureData;
  Map<String, dynamic> trainer = {};
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? trainerId;

  @override
  void initState() {
    futureData = getTrainer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: futureData,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff142129)),
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  ApiList.imageUrl + (trainer['image'] ?? ""),
                              errorWidget: (context, url, error) => Container(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      'assets/svg/fjuser.svg',
                                      height: 10,
                                      width: 10,
                                    ),
                                  )),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${trainer['name']}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'SpaceGrotesk',
                                fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffFF6600),
                                fontFamily: 'SpaceGrotesk'),
                          )
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                width: 1.5, color: Colors.white)),
                        onPressed: showLogoutPopup,
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                  toolbarHeight: 65,
                  automaticallyImplyLeading: false,
                ),
                body: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        color: const Color(0xff142129),
                        child: const TabBar(
                            labelColor: Colors.white,
                            indicator: BoxDecoration(color: Color(0xffFF6600)),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: Color(0xffFF6600),
                            tabs: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Upcoming\nSessions',
                                  style: TextStyle(
                                      fontFamily: 'SpaceGrotesk',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('Updated\nSessions',
                                    style: TextStyle(
                                        fontFamily: 'SpaceGrotesk',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('Completed\nSessions',
                                    style: TextStyle(
                                        fontFamily: 'SpaceGrotesk',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center),
                              )
                            ]),
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          UpcomingSession(trainerId: trainerId ?? ''),
                          UpdatedSession(trainerId: trainerId ?? ''),
                          CompletedSession(trainerId: trainerId ?? '')
                        ]),
                      )
                    ],
                  ),
                )),
          );
        }

        if (snapshot.hasError) {
          const Text("Something wrong");
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<bool>? getTrainer() async {
    try {
      final SharedPreferences prefs = await _prefs;
      trainerId = prefs.getString('trainerId');
      String trainerUrl = "https://fitnessjourni.com/api/admin/viewTrainer.php";
      http.Response? response = await http
          .post(Uri.parse(trainerUrl), body: {'trainerId': trainerId});

      trainer = json.decode(response.body);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> showLogoutPopup() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1, color: Colors.white)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: const Text(
            'Are you sure you want to log\nout?',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          content: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(154, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(154, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side:
                              const BorderSide(width: 1, color: Colors.white))),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'SpaceGrotesk',
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () async {
                    final SharedPreferences prefs = await _prefs;
                    await prefs.remove('trainerId');
                    if (!mounted) {
                      return;
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
