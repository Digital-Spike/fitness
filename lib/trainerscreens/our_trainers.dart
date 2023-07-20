import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/trainerscreens/triner_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class OurTrainers extends StatefulWidget {
  final Map<String, dynamic> trainer;
  final bool isBranchTrainers;
  final bool isBranch;
  final String? branchId;
  const OurTrainers(
      {super.key,
      required this.trainer,
      required this.isBranch,
      required this.isBranchTrainers,
      required this.branchId});

  @override
  State<OurTrainers> createState() => _OurTrainersState();
}

class _OurTrainersState extends State<OurTrainers> {
  List trainersList = [];
  Future<bool>? futureData;

  @override
  void initState() {
    futureData = trainerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffE2EEFF),
        appBar: AppBar(
          backgroundColor: const Color(0xffE2EEFF),
          title: const Text(
            'Trainers',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          leading: const BackButton(
            color: Colors.black,
          ),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                height: 1.0,
                color: Colors.black,
              )),
        ),
        body: FutureBuilder<bool>(
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
                                builder: (context) => TrainerProfile(
                                      trainer: trainersList[index],
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              minRadius: 60,
                              backgroundColor: Colors.grey,
                              child: CachedNetworkImage(
                                height: 120,
                                imageUrl: ApiList.imageUrl +
                                    (widget.trainer['image'] ?? ""),
                                placeholder: (context, url) => Container(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Text(
                              trainersList[index]['name'],
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepOrange),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 30,
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    trainersList[index]['rating'],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
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
}
