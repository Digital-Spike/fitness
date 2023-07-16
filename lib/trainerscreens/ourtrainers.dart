import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/Slotscreens/slotBookingPage.dart';
import 'package:fitness/trainerscreens/trainerprofile.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class OurTrainers extends StatefulWidget {
 final Map<String, dynamic> trainer;
 final bool isBranchTrainers;
  final bool isBranch;
  final String? branchId;
  const OurTrainers(
      {super.key, required this.trainer, required this.isBranch,required this.isBranchTrainers,required this.branchId});


  @override
  State<OurTrainers> createState() => _OurTrainersState();
}

class _OurTrainersState extends State<OurTrainers> {
  List trainersList = [];
  Future<bool>? futureData;

  @override
  void initState() {
    futureData = trainerList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2EEFF),
      appBar: AppBar(
        backgroundColor: Color(0xffE2EEFF),
        title: Text('Trainers',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        leading: BackButton(color: Colors.black,),
        bottom: PreferredSize(child: Container(height: 1.0,color: Colors.black,), preferredSize: Size.fromHeight(1.0)),
      ),
      body: FutureBuilder<bool>(
      future: futureData,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return
      ListView.builder(
        
        itemCount: trainersList.length,
        itemBuilder: (context, index) {
        return InkWell(
          onTap:(){
             Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrainerProfile(isBranch: widget.isBranchTrainers,
                                        trainer: trainersList[index],)));
          },
           
          
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
              children: [
               CircleAvatar(
                minRadius: 60,
                backgroundColor: Colors.grey,
                                      child: CachedNetworkImage(
                                         height: 120,
                      imageUrl:ApiList.imageUrl + (widget.trainer['image'] ?? ""),
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                                      ),
                                    ),
              Text( trainersList[index]['name'],
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.deepOrange),),
                                              Row(
                                                children: [
                                                  Icon(
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
                                      ),)
                                                ],
                                              ),
                                    
        
            ],),),
        );
      });
        
  }
  if (snapshot.hasError) {
              const Text("Something wrong");
            }

            return const Center(child: CircularProgressIndicator());
          },));
  }
  Future<bool> trainerList() async {
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
  void _showDialog(){
    showDialog(context: context, builder: (context){
      return CupertinoAlertDialog(
        
        title: Text('Pay Per Session',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
        actions: [
          MaterialButton(onPressed: (){},child: Text('Pay'),),
          MaterialButton(onPressed: () {
            Navigator.pop(context);
          },child: Text('Cancel'),)
        ],
      );
    });
  }
}