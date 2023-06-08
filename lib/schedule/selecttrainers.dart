import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'slot.dart';

class SelectTrainers extends StatefulWidget {
  const SelectTrainers({super.key});

  @override
  State<SelectTrainers> createState() => _SelectTrainersState();
}

class _SelectTrainersState extends State<SelectTrainers> {
  List<dynamic>? data;

  Future<dynamic> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String apiurl = "https://fitnessjourni.com/api/getAllTrainers.php";
    var response = await http.post(Uri.parse(apiurl),
        body: {'branchId': prefs.getString('branchId')});

    var jsondata = json.decode(response.body);
    print(jsondata);

    setState(() {
      data = jsondata;
    });
  }

  void initState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 2,
            shape: const Border(
              bottom: BorderSide(
                color: Colors.grey,
              ),
            ),
            backgroundColor: Colors.white,
            title: Center(
                child: Text(
              "Select Trainers",
              style: TextStyle(color: Colors.black),
            ))),
        body: SingleChildScrollView(
          child: Column(
            children: data != null
                ? data!
                    .map((trainer) => TrainerCard(
                          name: trainer['name'],
                          id: trainer['id'],
                          image: trainer['image'],
                          trainerId: trainer['trainerId'],
                        ))
                    .toList()
                : [Center(child: CircularProgressIndicator())],
          ),
        ));
  }
}

class TrainerCard extends StatelessWidget {
  final String? name;
  final String? id;
  final String? image;
  final String? trainerId;

  const TrainerCard({
    Key? key,
    this.name,
    this.id,
    this.image,
    this.trainerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/mma.jpg',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Text("ID: $id",
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              SizedBox(height: 8.0),
              Text("Name: $name",
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              SizedBox(height: 8.0),
              Text("Trainer ID: $trainerId",
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(100, 40),
                      backgroundColor: Colors.grey,
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  child: Text('View Schedule'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SlotAvailability()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
