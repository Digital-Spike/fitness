import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/model/branch.dart';
import 'package:fitness/trainerscreens/trainer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Partner extends StatefulWidget {
  const Partner({super.key});

  @override
  State<Partner> createState() => _PartnerState();
}

class _PartnerState extends State<Partner> {
  Future<bool>? futureData;

  List branchList = [];
  @override
  void initState() {
    futureData = getBranchList();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              color: const Color(0xff142129),
            ),
          ),
          title: const Text(
            'Our Partners',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: FutureBuilder<bool>(
            future: futureData,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: branchList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrainerList(
                                        isBranchTrainers: true,
                                        branchId: branchList[index]['branchId'],
                                        branchName: branchList[index]['branch'],
                                        branchAddress: branchList[index]
                                            ['address'],
                                      )));
                        },
                        child: Stack(
                          children: [
                            Container(
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
                                      height: 120,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl: ApiList.imageUrl +
                                            (branchList[index]['image'] ?? ""),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(
                                            strokeAlign: 1,
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.9,
                                        child: Text(
                                          branchList[index]['branch'],
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'SpaceGrotesk',
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/marker.svg',
                                            height: 13,
                                            width: 8.3,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            child: Text(
                                              branchList[index]['address']
                                                  .toString()
                                                  .replaceAll('\n', ''),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'WorkSans'),
                                              softWrap: true,
                                              maxLines: 3,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: 15,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  width: 56,
                                  height: 32,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  child: SvgPicture.asset(
                                      'assets/svg/fjarrow.svg'),
                                ))
                          ],
                        ),
                      );
                    });
              }

              if (snapshot.hasError) {
                const Text("Something wrong");
              }

              return const Center(
                  child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ));
            },
          ),
        ));
  }
}
