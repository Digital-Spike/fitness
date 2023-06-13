import 'dart:async';
import 'dart:convert';

import 'package:fitness/constants/api_list.dart';
import 'package:fitness/model/branch.dart';
import 'package:fitness/model/trainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool>? futureData;
  Map<String, dynamic> trainersAndBranchList = {};
  List<TrainerModel> trainerList = [];
  List<BranchModel> branchList = [];

  @override
  void initState() {
    futureData = fetchData();
    super.initState();
  }

  Future<bool> fetchData() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}getTrainerandBranch.php";
      var response = await http.post(Uri.parse(trainerUrl), body: {});
      trainersAndBranchList = json.decode(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: SvgPicture.asset('assets/language_icon.svg',),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              SizedBox(
                height: 100,
                child: Image.asset(
                  'assets/fitnessname.png',
                  height: 80,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                color: Colors.white,
                onPressed: () {
                  // Handle notification button press
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder<bool>(
          future: futureData,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Select a Trainer for EMS at Home',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.grey)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 160,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: trainersAndBranchList['tariners'].length,
                          itemBuilder: (BuildContext context, int index) {
                            final trainerImage =
                                trainersAndBranchList['tariners'][index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: Colors.deepOrangeAccent),
                                    borderRadius: BorderRadius.circular(80)),
                                child: SvgPicture.network(
                                  ApiList.imageUrl +
                                      (trainerImage['image'] ?? ""),
                                  height: 150,
                                  placeholderBuilder: (BuildContext context) =>
                                      Container(
                                          padding: const EdgeInsets.all(60.0),
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator())),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Select a Trainer for EMS at Gym',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.grey)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: trainersAndBranchList['branches'].length,
                          itemBuilder: (BuildContext context, int index) {
                            final branchImage =
                                trainersAndBranchList['branches'][index];
                            return GestureDetector(
                              onTap: () {
                                // Handle trainer selection
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey, width: 1.5),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SvgPicture.network(
                                    ApiList.imageUrl +
                                        (branchImage['image'] ?? ""),
                                    placeholderBuilder:
                                        (BuildContext context) => const Center(
                                            child: CircularProgressIndicator()),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              const Text("Something wrong");
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
