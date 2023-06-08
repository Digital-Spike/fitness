import 'dart:async';
import 'dart:convert';
import 'package:fitness/schedule/getbranchtrainers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AvailableBranches extends StatefulWidget {
  const AvailableBranches({Key? key}) : super(key: key);

  @override
  State<AvailableBranches> createState() => _AvailableBranchesState();
}

class _AvailableBranchesState extends State<AvailableBranches> {
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
      appBar: AppBar(
        elevation: 2,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Available Branches - " + (total ?? 0).toString(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: _showCircle
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: data == null ? 0 : data!.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString('branch', data?[index]["branchId"]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GetTrainer(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 200, // Adjust the container height as needed
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(color: Colors.grey.shade300),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://fitnessjourni.com/api/uploads/' +
                                  (data?[index]["image"] ?? ""),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            data?[index]["branch"] ?? "",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10), // Add spacing
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    data?[index]["address"] ?? "",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10), // Add spacing
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Contact: " +
                                        (data?[index]["contact"] ?? ""),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
