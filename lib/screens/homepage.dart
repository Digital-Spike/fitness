import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../schedule/branches.dart';
import '../schedule/trainerlist.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '',
      text: "Hi",
    );
    await launch('$link');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/IMG_9779.jpg'), fit: BoxFit.cover)),
        child: Column(children: [
          SizedBox(height: 25),
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                image: DecorationImage(
                    image: AssetImage('assets/fitness.png'),
                    scale: 2,
                    alignment: Alignment.center)),
          ),
          Container(
            height: 15,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.orange,
              Colors.indigo,
              Colors.green,
              Colors.blue
            ])),
          ),
          SizedBox(height: 50),
          Container(
            height: 120,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.7),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/One Free.png',
                  scale: 2,
                ),
                SizedBox(height: 10),
                Text(
                  'Book a Trial Session',
                  style: TextStyle(
                      fontFamily: 'ITCAvant',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TrainerList(isBranchTrainers: true,)));
                },
                child: Container(
                  height: 120,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange.withOpacity(0.7)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/trainer.png',
                        scale: 2,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Our Trainers',
                        style: TextStyle(
                            fontFamily: 'ITCAvant',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BranchList()));
                },
                child: Container(
                  height: 120,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo.withOpacity(0.7)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/barbell.png',
                        scale: 2,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Our Gym Partners',
                        style: TextStyle(
                            fontFamily: 'ITCAvant',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 120,
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.withOpacity(0.7)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/plan.png',
                      scale: 2,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Our Packages',
                      style: TextStyle(
                          fontFamily: 'ITCAvant',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                height: 120,
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.withOpacity(0.7)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/offer.png',
                      scale: 2,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Our Offers',
                      style: TextStyle(
                          fontFamily: 'ITCAvant',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ), SizedBox(height: 60),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: TextButton(
                style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),backgroundColor: Colors.white ,elevation: 10),
                onPressed: () async {
                                                                                  final Uri url = Uri(
                                                                                  scheme: 'tel',
                                                                                  path:"",                                                                                 
                                                                                );
                                                                                if(await canLaunchUrl(url)) {
                                                                                  await launchUrl(url);                                                                               
                                                                                } else {
                                                                                  print('cannot launch this Url');
                                                                                }
                }, child: Icon(Icons.call,color: Colors.black,size: 30,))),
                Container(height: 3.0,
                    width: 50,
                color: Colors.white,),
                
               
                Center(child: TextButton(
                  style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),backgroundColor: Colors.white,elevation: 10),
                  onPressed: () async{
                    
                    launchWhatsApp();}, child: Logo(Logos.whatsapp))),Container(height: 3.0,
                    width: 50,
                color: Colors.white,),
                  Center(child: TextButton(
                    style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),backgroundColor: Colors.white,elevation: 10),
                    onPressed: (){}, child: Logo(Logos.instagram)))
            ],
          )
 
        ]),
      ),
    );

  }
}
