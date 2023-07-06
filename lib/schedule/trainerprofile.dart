import 'package:fitness/drawerscreen/slotbooking1.dart';
import 'package:flutter/material.dart';
class TrainerProfile extends StatefulWidget {
  const TrainerProfile({super.key});

  @override
  State<TrainerProfile> createState() => _TrainerProfileState();
}

class _TrainerProfileState extends State<TrainerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Trainer Name',// call Trainer name from api
          style: TextStyle(
            fontSize:18,fontWeight:FontWeight.w900,color: Colors.black),
        ),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const CircleAvatar(
                    minRadius: 60,
                    backgroundColor: Colors.grey,
                  ),const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Trainer Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.deepOrange),),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                           padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: const LinearGradient(colors: [
                              Colors.blue,
                              Colors.purple
                            ])),
                            child: const Text('EMS Trainer',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white),)),
                             Container(
                           padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: const LinearGradient(colors: [
                              Colors.blue,
                              Colors.purple
                            ])),
                            child: const Text('Body Building',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white),)),
                        ],
                      ),
                        Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                           padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: const LinearGradient(colors: [
                              Colors.blue,
                              Colors.purple
                            ])),
                            child: const Text('Arabic',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white),)),
                             Container(
                           padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: const LinearGradient(colors: [
                              Colors.blue,
                              Colors.purple
                            ])),
                            child: const Text('English',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white),)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1.0,
              color: Colors.black,
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  Text('data')
                ],
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Slotbooking1()));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),gradient: LinearGradient(colors: [Colors.green,Colors.blue])
                  ),
                  child: Text('Book Session',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),textAlign: TextAlign.center,),
                ),
              )
            )

          ],
        ),
      ),
    );
  }
}