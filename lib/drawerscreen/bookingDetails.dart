import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookingDetails extends StatefulWidget {
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  List? data;
  String? id,
      bookingId,
      trainerId,
      customerId,
      customerName,
      trainerName,
      created,
      bookingDate,
      bookingTime,
      slot,
      amount,
      status,
      branchId;
  Future<dynamic> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String apiurl = "https://fitnessjourni.com/api/getBookingDetails.php";
    var response = await http.post(Uri.parse(apiurl),
        body: {'bookingId': prefs.getString('bookingId')});

    var jsondata = json.decode(response.body);
    print(jsondata);
    setState(() {
      id = jsondata['id'];
      bookingId = jsondata['bookingId'];
      trainerId = jsondata['trainerId'];
      customerId = jsondata['customerId'];
      customerName = jsondata['customerName'];
      trainerName = jsondata['trainerName'];
      created = jsondata['created'];
      bookingDate = jsondata['bookingDate'];
      bookingTime = jsondata['bookingTime'];
      slot = jsondata['slot'];
      amount = jsondata['amount'];
      status = jsondata['status'];
      branchId = jsondata['branchId'];
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
            // iconTheme: const IconThemeData(color: Colors.black),
            title: Center(
                child: Text(
              "Booking Details",
              style: TextStyle(color: Colors.black),
            ))),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("Id: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(id.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("booking Id: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(bookingId.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("trainer Id : ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(trainerId.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("customer Id: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(customerId.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("customer Name: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(customerName.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("trainer Name: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(trainerName.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("created: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(created.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("booking Date: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(bookingDate.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("booking Time: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(bookingTime.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("slot: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(slot.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18))),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("amount: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(amount.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                    width: 180,
                    child: Text("branch Id: ",
                        style: TextStyle(color: Colors.black, fontSize: 18))),
                SizedBox(
                    width: 200,
                    child: Text(branchId.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18)))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              crossAxisAlignment:
                  CrossAxisAlignment.center, //Center Row contents vertically,
              children: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: Size(100, 40),
                        backgroundColor: Colors.grey,
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    child: Text('Start '),
                    onPressed: () async {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AllTrainer()));
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            )),
            SizedBox(
              height: 50,
            ),
          ],
        )));
  }
}
