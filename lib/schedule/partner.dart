import 'dart:convert';
import 'package:fitness/model/branch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: Color(0xffF1F1F2),
       appBar: AppBar(
        backgroundColor: const Color(0xffF1F1F2),
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
            fontSize:18,fontWeight:FontWeight.w900,color: Colors.black),
        ),
        centerTitle: true,
        leading: BackButton(color: Colors.black),
      ),
      body: FutureBuilder<bool>(
          future: futureData,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                
                itemCount: trainersAndBranchList['branches'].length,
                itemBuilder: (BuildContext context, int index) {
                  final branchImage =
                      trainersAndBranchList['branches'][index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    height: 200,
                    width: 250,
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
                        fit: BoxFit.cover,
                        placeholderBuilder:
                            (BuildContext context) => const Center(
                                child: CircularProgressIndicator()),
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
        )
    );
  }
}