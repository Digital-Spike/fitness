import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  Future<bool>? futureData;
  Map<String, dynamic>? bookingData;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    futureData = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // backgroundColor: Color(0xffF5E6C2),
        body: FutureBuilder<bool>(
            future: futureData,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                   // color: Colors.white,
                    child: (bookingData == null)
                        ? const Center(
                            child: Text(
                              "No Bookings found!",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        : ListView.builder(
           itemCount: 1,
            itemBuilder: ((context, index) {
            return Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Trainer :',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                           Text(' ${bookingData?['trainerName']}',style: TextStyle(color: Colors.deepOrange,fontSize: 15),),
                        ],
                      ),
                     
                       Row(
                    children: [
                      Text('Id :',style: TextStyle(fontSize: 15,color: Colors.black),),
                      Text(' ${bookingData?['bookingId']}',style: TextStyle(fontSize: 14,color: Colors.black),)
                    ],
                  ),
                    ],
                  ),
                  
                 
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(
                      children: [
                        Text('Date :',style: TextStyle(fontSize: 14,color: Colors.black),),
                        Text(' ${bookingData?['bookingDate']}',style: TextStyle(fontSize: 12,color: Colors.black),)
                      ],
                    ),
                     Row(children: [
                    Text('Time :',style: TextStyle(fontSize: 14,color: Colors.black),),
                    Text(' ${bookingData?['bookingTime']}',style: TextStyle(fontSize: 12,color: Colors.black),)
                  ],),
                  ],),
                  
                 
                   SizedBox(height: 5),
                  Row(children: [
                    Text('Branch :',style: TextStyle(fontSize: 15,color: Colors.black),),
                    Text( ' ${bookingData?['branchName']}',style: TextStyle(fontSize: 15,color: Colors.black),)
                  ],),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(onPressed: (){},child: Text('Postpone',style: TextStyle(color: Colors.white,fontSize: 15),),color:Color(0xff404040)),
                       MaterialButton(onPressed: (){},child: Text('Prepone',style: TextStyle(color: Colors.white,fontSize: 15),),color: Color(0xff404040)),
                        MaterialButton(onPressed: (){},child: Text('Cancel',style: TextStyle(color: Colors.white,fontSize: 15),),color: Color(0xff404040))
                    ],
                  )
                ],
              ),
            );
          })),
                  ),
                );
              }

              if (snapshot.hasError) {
                const Text("Something wrong");
              }

              return const Center(child: CircularProgressIndicator());
            }));
  }

  Future<bool> fetchData() async {
    try {
      String trainerUrl = "${ApiList.apiUrl}getUserBookings.php";
      var response =
          await http.post(Uri.parse(trainerUrl), body: {'userId': user?.uid});
      bookingData = json.decode(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }
}

