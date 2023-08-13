import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/theme/trainer_button.dart';
import 'package:fitness/trainer_section/completedsession.dart';
import 'package:fitness/trainer_section/upcoming_session.dart';
import 'package:fitness/trainer_section/updatedsession.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrainerHome extends StatefulWidget {
  const TrainerHome({super.key});

  @override
  State<TrainerHome> createState() => _TrainerHomeState();
}

class _TrainerHomeState extends State<TrainerHome> {
  Future<bool>? futureData;
  Map<String, dynamic> trainer = {};

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
                                  builder: (context) =>
                                      const UpcomingSession()));
                        }),
                    TrainerButton(
                        title: 'Completed Sessions',
                        leadingColor: Colors.indigoAccent,
                        trailingIcon: Icons.arrow_forward_ios,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CompletedSession()));
                        }),
                    TrainerButton(
                        title: 'Updated Sessions',
                        leadingColor: Colors.amberAccent,
                        trailingIcon: Icons.arrow_forward_ios,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UpdatedSession()));
                        }),
                    TrainerButton(
                      title: 'EMS at Home/ Personal Trainer',
                      trailingIcon: Icons.arrow_forward_ios,
                      onPressed: () {},
                      leadingColor: Colors.greenAccent,
                    ),
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
      String trainerUrl = "https://fitnessjourni.com/api/admin/viewTrainer.php";
      http.Response? response =
          await http.post(Uri.parse(trainerUrl), body: {'trainerId': 'FJT01'});

      trainer = json.decode(response.body);

      return true;
    } catch (e) {
      return false;
    }
  }
}
