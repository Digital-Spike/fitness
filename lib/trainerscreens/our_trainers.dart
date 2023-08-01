import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/Slotscreens/slotBookingPage.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/trainerscreens/triner_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class OurTrainers extends StatefulWidget {
  final bool isBranchTrainers;
  final String? branchId;
  final bool? isOurTrainers;
  const OurTrainers(
      {required this.isBranchTrainers,
      this.branchId,
      this.isOurTrainers,
      super.key});

  @override
  State<OurTrainers> createState() => _OurTrainersState();
}

class _OurTrainersState extends State<OurTrainers> {
  List trainersList = [];
  Future<bool>? futureData;

  @override
  void initState() {
    futureData = OurTrainers();
    super.initState();
  }
  List<Widget> trainer = <Widget>[
    const Text(
      'EMS Trainer',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    const Text('Personal Trainer',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
  ];
  final List<bool> _selectedTrainer = <bool>[true, false];
  bool vertical = false;
  bool isSelectedTrainer = false;
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5E6C2),
        appBar: AppBar(
          backgroundColor: Color(0xffF5E6C2),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              color: Colors.black,
            ),
          ),
          title: const Text('Available Trainers',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,color: Colors.black
                  )),
          centerTitle: true,
          leading: BackButton(color: Colors.black,),
        ),
        body: Container(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Center(
                child: ToggleButtons(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < _selectedTrainer.length; i++) {
                      _selectedTrainer[i] = i == index;
                    }
                    isSelectedTrainer = !isSelectedTrainer;
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
                borderColor: Colors.red,
                fillColor: const Color(0xff50E3C2),
                color: Colors.red[400],
                constraints: const BoxConstraints(
                  minHeight: 50.0,
                  minWidth: 180.0,
                ),
                isSelected: _selectedTrainer,
                children: trainer,
                          ),
              ),
              SizedBox(height: 10),
              FutureBuilder<bool>(
                future: futureData,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Visibility(
                      visible: !isSelectedTrainer,
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: trainersList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                (widget.isOurTrainers ?? false)
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TrainerProfile(
                                                trainer: trainersList[index])))
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SlotBookingPage(
                                                isBranch: widget.isBranchTrainers,
                                                trainer: trainersList[index])));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),  color: Colors.white,),
                                
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: CachedNetworkImage(
                                              imageUrl: ApiList.imageUrl +
                                                  (trainersList[index]['image'] ?? ""),
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget: (context, url, error) =>
                                                  const Icon(Icons.error),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            children: [
                                              Text(
                                                trainersList[index]['name'],
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.deepOrange),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                trainersList[index]['description'],
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,color: Colors.black),
                                              ),
                                              const SizedBox(height: 10),
                                              /*  Row(
                                                children: [
                                                  const Icon(Icons.phone),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    ((trainersList[index]
                                                                    ['phoneNumber'])
                                                                .toString()
                                                                .length >=
                                                            2
                                                        ? trainersList[index]
                                                            ['phoneNumber']
                                                        : 'Not Available'),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),*/
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            '    Available',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: (trainersList[index]['status'] ==
                                                        "ACTIVE")
                                                    ? Colors.green
                                                    : Colors.grey),
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 30,
                                          ),
                                          const SizedBox(width: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: Text(
                                              trainersList[index]['rating'],
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
        
                  if (snapshot.hasError) {
                    const Text("Something wrong");
                  }
        
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              Visibility(
                visible: isSelectedTrainer,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                             height: 180,
                             width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: AssetImage('assets/IMG_9588.jpg'),fit: BoxFit.cover)
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Container(height: 30,width: 8,color: Colors.deepOrange,),
                                    Text('  Karina Medvidova',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.deepOrange),)
                                  ],
                                ),
                                SizedBox(height: 0,),
                                Text('  3+ Years of Experience',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black)),
                                SizedBox(height: 5),
                                Text('  Expertise in:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.deepOrange),),
                                
                                Wrap(
                                  direction: Axis.vertical,
                                 children: [
                                   Container(
                                      margin: EdgeInsets.all(5),
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),gradient: LinearGradient(colors: [Colors.blueAccent,Colors.greenAccent])),
                                      child: Text('Personal Trainer',style: TextStyle(fontSize: 14),),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),gradient: LinearGradient(colors: [Colors.blueAccent,Colors.greenAccent])),
                                  child: Text('Body Building',style: TextStyle(fontSize: 14),),
                                ),
                                
                                 ],
                                 
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                  }),
                ),
              )
            ],
          ),
        ));
  }

  Future<bool> OurTrainers() async {
    try {
      Response? response;
      if (widget.isBranchTrainers) {
        String trainerUrl = "${ApiList.apiUrl}getBranchTrainers.php";
        response = await http
            .post(Uri.parse(trainerUrl), body: {'branch': widget.branchId});
      } else {
        String trainerUrl = "${ApiList.apiUrl}getAllTrainers.php";
        response = await http.post(Uri.parse(trainerUrl), body: {});
      }

      trainersList = json.decode(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }
  /*{
        "id": "7",
        "name": "Jeylan Silanovich",
        "phoneNumber": "0",
        "category": "None",
        "branch": "01",
        "image": "Trainer4.svg",
        "status": "ACTIVE",
        "balance": "0",
        "description": "3+ Years of experience",
        "rating": "4",
        "trainerId": "FJT01",
        "branchId1": "branch1",
        "branchId2": "branch2",
        "branchId3": "branch3",
        "branchId4": "branch4",
        "branchId5": "branch5"
    },*/
}
