import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/model/branch.dart';
import 'package:fitness/trainerscreens/trainer_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Partner extends StatefulWidget {
  const Partner({super.key});

  @override
  State<Partner> createState() => _PartnerState();
}

class _PartnerState extends State<Partner> {
  Future<bool>? futureData;
  Map<String, dynamic> trainersAndBranchList = {};

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
        backgroundColor: const Color(0xffF5E6C2),
        appBar: AppBar(
          backgroundColor: const Color(0xffF5E6C2),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Our Partner Gym',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          centerTitle: true,
          leading: const BackButton(color: Colors.black),
        ),
        body: FutureBuilder<bool>(
          future: futureData,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: trainersAndBranchList['branches'].length,
                itemBuilder: (BuildContext context, int index) {
                  final branch = trainersAndBranchList['branches'][index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainerList(
                                    isBranchTrainers: true,
                                    branchId: branch['branchId'],
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 1.5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: ApiList.imageUrl + (branch['image'] ?? ""),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
}
