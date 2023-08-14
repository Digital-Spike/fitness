import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/authentication%20screen/loginpage.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/theme/trainer_button.dart';
import 'package:fitness/trainer_section/completedsession.dart';
import 'package:fitness/trainer_section/upcoming_session.dart';
import 'package:flutter/material.dart';
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
          return Scaffold(
              appBar: AppBar(
                centerTitle: false,
                leading: CircleAvatar(
                  minRadius: 30,
                  child: CachedNetworkImage(
                    imageUrl: ApiList.imageUrl + (trainer['image'] ?? ""),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                toolbarHeight: 65,
                title: Text('${trainer['name']}'),
                automaticallyImplyLeading: false,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    TrainerButton(
                        title: 'Upcoming Sessions',
                        leadingColor: Colors.deepOrange,
                        trailingIcon: Icons.arrow_forward_ios,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpcomingSession(
                                        trainerId: trainerId ?? "",
                                      )));
                        }),
                    TrainerButton(
                        title: 'Completed Sessions',
                        leadingColor: Colors.indigoAccent,
                        trailingIcon: Icons.arrow_forward_ios,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompletedSession(
                                        trainerId: trainerId ?? "",
                                      )));
                        }),
                    TrainerButton(
                        title: 'Updated Sessions',
                        leadingColor: Colors.amberAccent,
                        trailingIcon: Icons.arrow_forward_ios,
                        onPressed: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UpdatedSession()));*/
                        }),
                    TrainerButton(
                      title: 'EMS at Home/ Personal Trainer',
                      trailingIcon: Icons.arrow_forward_ios,
                      onPressed: () {},
                      leadingColor: Colors.greenAccent,
                    ),
                    
                    TrainerButton(title: 'Logout', leadingColor: Colors.teal, trailingIcon: Icons.arrow_forward_ios, onPressed: () async {
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
                            (Route<dynamic> route) => false);}),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     final SharedPreferences prefs = await _prefs;
                    //     await prefs.remove('trainerId');
                    //     if (!mounted) {
                    //       return;
                    //     }
                    //     Navigator.pushAndRemoveUntil(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (BuildContext context) =>
                    //                 const LoginPage()),
                    //         (Route<dynamic> route) => false);
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10)),
                    //     backgroundColor:
                    //         Colors.blueGrey[100], // Customize button color
                    //     padding: const EdgeInsets.all(10),
                    //   ),
                    //   child: const Text(
                    //     "Logout",
                    //     style: TextStyle(
                    //         fontSize: 15, fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                    const Spacer(),
                    const Icon(
                      Icons.home_filled,
                      color: Color(0xff9EEB47),
                      size: 35,
                    ),
                    const Text(
                      'Home',
                      style: TextStyle(fontSize: 16, color: Color(0xff9EEB47)),
                    )
                  ],
                ),
              ));
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
}
