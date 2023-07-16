import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Bookinghistory extends StatefulWidget {
  const Bookinghistory({super.key});

  @override
  State<Bookinghistory> createState() => _BookinghistoryState();
}

class _BookinghistoryState extends State<Bookinghistory> {
  List? data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.parse('https://speedrent.in/adminapp/bookingHistory.php'),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data?[1]["bikeName"]);

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
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
          // iconTheme: const IconThemeData(color: Colors.black),
          title: Center(
              child: Text(
            "Booking History",
            style: TextStyle(color: Colors.black),
          ))),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data?.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            elevation: 5,
            margin: const EdgeInsets.all(5),
            child: ListTile(
              title: Text("Booking Id: " + data?[index]["bookingId"],
                  style: TextStyle(color: Colors.black)),
              subtitle: Text("Customer name: " + data?[index]["customerName"]),
              trailing: Text(data?[index]["bikeNumber"]),
            ),
          );
        },
      ),
    );
  }
}
