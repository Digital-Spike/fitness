import 'dart:convert';

import 'package:fitness/constants/api_list.dart';
import 'package:fitness/schedule/trainerDetailPage.dart';
import 'package:fitness/screens/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TrainerList extends StatefulWidget {
  final bool isBranchTrainers;
  final String? branchId;
  const TrainerList({required this.isBranchTrainers, this.branchId, super.key});

  @override
  State<TrainerList> createState() => _TrainerListState();
}

class _TrainerListState extends State<TrainerList> {
  List trainersList = [];
  Future<bool>? futureData;

  @override
  void initState() {
    futureData = trainerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        mainAppBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              color: Colors.white,
            ),
          ),
          title: const Text('Available Trainers',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          centerTitle: true,
        ),
        mainChild: FutureBuilder<bool>(
          future: futureData,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: trainersList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainerDetailPage(
                                    trainer: trainersList[index],
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: SvgPicture.network(
                                      ApiList.imageUrl +
                                          (trainersList[index]['image'] ?? ""),
                                      fit: BoxFit.cover,
                                      placeholderBuilder: (BuildContext
                                              context) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      Text(
                                        trainersList[index]['name'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.orange),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        trainersList[index]['description'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        trainersList[index]['description'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Available',
                                style: TextStyle(
                                    color: (trainersList[index]['status'] ==
                                            "ACTIVE")
                                        ? Colors.green
                                        : Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            if (snapshot.hasError) {
              const Text("Something wrong");
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Future<bool> trainerList() async {
    try {
      Response? response;
      if (widget.isBranchTrainers) {
        String trainerUrl = "${ApiList.apiUrl}getBranchTrainers.php";
        response = await http
            .post(Uri.parse(trainerUrl), body: {'branch': widget.branchId});
      } else {
        String trainerUrl = "${ApiList.apiUrl}getAllTrainers.php";
        response = await http.post(Uri.parse(trainerUrl), body: {});
      }

      trainersList = json.decode(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }
  /*{
        "id": "7",
        "name": "Jeylan Silanovich",
        "phoneNumber": "0",
        "category": "None",
        "branch": "01",
        "image": "Trainer4.svg",
        "status": "ACTIVE",
        "balance": "0",
        "description": "3+ Years of experience",
        "rating": "4",
        "trainerId": "FJT01",
        "branchId1": "branch1",
        "branchId2": "branch2",
        "branchId3": "branch3",
        "branchId4": "branch4",
        "branchId5": "branch5"
    },*/
}
