import 'dart:convert';

import 'package:fitness/schedule/slotbooking.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Branchlist extends StatefulWidget {
  const Branchlist({super.key});

  @override
  State<Branchlist> createState() => _BranchlistState();
}

class _BranchlistState extends State<Branchlist> {
  bool _showCircle = true;
  List? data;
  int? total = 0;
  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? branch = await prefs.getString('branch').toString();
    String apiurl = "https://fitnessjourni.com/api/getAllBranches.php";
    var response = await http.post(Uri.parse(apiurl), body: {'branch': branch});

    this.setState(() {
      data = json.decode(response.body);
      total = data?.length;
    });
    _showCircle = false;

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    _showCircle = true;
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Partner Gyms',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: data == null ? 0 : data!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return BranchCard(
                      branch: data?[index]["branch"] ?? "",
                      Address: data?[index]["address"] ?? "",
                      contact: 1234567890,
                      logopath: 'assets/Metrofit.png',
                    );
                  })),
        ],
      ),
    );
  }
}

class BranchCard extends StatelessWidget {
  List? data;
  int? total = 0;
  final String branch;
  final String Address;
  final int contact;
  final String logopath;

  BranchCard(
      {required this.branch,
      required this.Address,
      required this.contact,
      required this.logopath});
  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? branch = await prefs.getString('branch').toString();
    String apiurl = "https://fitnessjourni.com/api/getAllBranches.php";
    var response = await http.post(Uri.parse(apiurl), body: {'branch': branch});

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
                  Container(
                    height: 70,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(
                      logopath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Text(branch,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.black,
                          ),
                          Text(
                            Address,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(contact.toString()),
                  Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize: const Size(100, 30)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SlotBooking(),
                              ),
                            );
                          },
                          child: const Text('Book Now'))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
