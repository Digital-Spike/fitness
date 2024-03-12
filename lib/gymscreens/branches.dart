import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/trainerscreens/trainer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(height: 15),
        const Text('Available Branches',
            style: TextStyle(fontSize: 14, fontFamily: 'Work Sans')),
            FutureBuilder<bool>(
                future: futureData,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        itemCount: branchList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color(0xff142129),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 130,
                                    width: 116,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: CachedNetworkImage(
                                      imageUrl: ApiList.imageUrl +
                                          (branchList[index]['image'] ?? ""),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      branchList[index]['branch'],
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'SpaceGrotesk',
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/marker.svg',
                                          height: 13,
                                          width: 8.3,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width /
                                              2.1,
                                          child: Text(
                                            branchList[index]['address'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'WorkSans'),
                                            softWrap: true,
                                            // overflow: TextOverflow
                                            //     .visible,
                                            maxLines: 3,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }
                  if (snapshot.hasError) {
                    const Text("Something wrong");
                  }

                  return const Center(child: CircularProgressIndicator());
                }),
          ],
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
