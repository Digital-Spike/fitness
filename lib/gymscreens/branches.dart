import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/trainerscreens/trainer_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BranchList extends StatefulWidget {
  const BranchList({super.key});

  @override
  State<BranchList> createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  List branchList = [];
  Future<bool>? futureData;

  @override
  void initState() {
    futureData = getBranchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // backgroundColor: const Color(0xffF5E6C2),
        appBar: AppBar(
        // backgroundColor: const Color(0xffF5E6C2),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              color: Colors.black,
            ),
          ),
          title: const Text('Available Branches',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  )),
          centerTitle: true,
          // leading: const BackButton(color: Colors.black,
            
          // ),
        ),
        body: FutureBuilder<bool>(
          future: futureData,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: branchList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainerList(
                                    isBranchTrainers: true,
                                    branchId: branchList[index]['branchId'],
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.white12,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: CachedNetworkImage(
                                      imageUrl: ApiList.imageUrl +
                                          (branchList[index]['image'] ?? ""),fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(branchList[index]['branch'],
                                          style: const TextStyle(
                                             
                                              fontSize: 16,
                                              color: Colors.deepOrange,
                                              fontWeight: FontWeight.w600,
                                              decoration:
                                                  TextDecoration.underline),textAlign: TextAlign.center,),
                                      const SizedBox(height: 10),
                                      const SizedBox(height: 10)
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  Expanded(
                                    child: Text(
                                      branchList[index]['address'],
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,color: Colors.white),
                                      textAlign: TextAlign.start,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                              /*Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(branchList[index]['phoneNumber']),
                                  Center(
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.orange,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              minimumSize: const Size(100, 30)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TrainerList(
                                                          isBranchTrainers:
                                                              true,
                                                          branchId:
                                                              branchList[index]
                                                                  ['branchId'],
                                                        )));
                                          },
                                          child: const Text('Book Now'))),
                                ],
                              ),*/
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

  Future<bool> getBranchList() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}getAllBranches.php";
      var response = await http.post(Uri.parse(trainerUrl), body: {});
      branchList = json.decode(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }
/*{
        "id": "76",
        "branchId": "Branch2",
        "branch": "Business Village Branch",
        "phoneNumber": "",
        "email": "",
        "address": "Port Saeed - Business Village,\r\nDubai",
        "gpsLat": "",
        "gpsLong": "",
        "image": "branchbusiness.svg",
        "status": "ACTIVE"
    },*/
}
