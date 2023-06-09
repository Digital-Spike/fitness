import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/drawerscreen/slotBookingPage.dart';
import 'package:fitness/schedule/partner.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:fitness/screens/offers.dart';
import 'package:fitness/screens/ourpackages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../schedule/trainer.dart';
import 'freetrialsession.dart';

const colorizeColors = [
  Colors.purple,
  Colors.blue,
 
];

const colorizeTextStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: 'ITCAvant',
  fontWeight: FontWeight.w900
);
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const url =
      'https://instagram.com/fitness_journey_uae?igshid=MzRlODBiNWFlZA==';
  final number = '+971588340905';
  launchWhatsApp() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+971588340905',
      text: "Hi",
    );
    await launch('$link');
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainChild: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/IMG_9779.jpg'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 30),
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  image: const DecorationImage(
                      image: AssetImage('assets/fitness.png'),
                      scale: 2,
                      alignment: Alignment.center)),
            ),
            Container(
              height: 10,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                   begin: Alignment.topLeft,
                   end: Alignment.bottomRight,
                    colors: [
                Colors.orange,
                Colors.indigo,
                Colors.green,
                Colors.blue
              ])),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const FreeTrialSession()));
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1,color: Colors.black),
                  color: Colors.white.withOpacity(0.5),
                 /* gradient: const LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [Colors.deepOrange,Colors.yellow])*/
                ),
                child: AnimatedTextKit(
                  
                animatedTexts: [
                  
                  ColorizeAnimatedText(
                    'Book Your Free Trial Session Now',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                    speed: const Duration(milliseconds: 200)
                  )],
                  isRepeatingAnimation: true,
                  totalRepeatCount: 100,
              )),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
               /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  SlotBookingPage(isBranch: , trainer: const {},)));*/
              },
              child: Container(
                height: 120,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5,color: Colors.white),
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Session.png',
                      scale: 2,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Book your Session',
                      style: TextStyle(
                          fontFamily: 'ITCAvant',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            
            SizedBox(
              height: 320,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 120,
                    crossAxisCount: 2),
                 
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Trainer(
                                      isBranchTrainers: false,
                                    )));
                      },
                      child: Container(
                        height: 120,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1.5,color: Colors.white),
                            color: Colors.orange.withOpacity(0.7)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/trainer.png',
                              scale: 2,
                            ),
                            const SizedBox(height: 10),
                            const Text(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Partner()));
                      },
                      child: Container(
                        height: 120,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1.5,color: Colors.white),
                            color: Colors.indigo.withOpacity(0.7)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/barbell.png',
                              scale: 2,
                            ),
                            const SizedBox(height: 10),
                            const Text(
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OurPackages()));
                      },
                      child: Container(
                        height: 120,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1.5,color: Colors.white),
                            color: Colors.green.withOpacity(0.7)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/plan.png',
                              scale: 2,
                            ),
                            const SizedBox(height: 10),
                            const Text(
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
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Offers()));
                      },
                      child: Container(
                        height: 120,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1.5,color: Colors.white),
                            color: Colors.blue.withOpacity(0.7)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/offer.png',
                              scale: 2,
                            ),
                            const SizedBox(height: 10),
                            const Text(
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
                    ),
                  ],
                ),
              ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Colors.white,
                            elevation: 10),
                        onPressed: () async {
                          launch('tel://$number');
                        },
                        child: const Icon(
                          Icons.call,
                          color: Colors.black,
                          size: 30,
                        ))),
                Container(
                  height: 3.0,
                  width: 50,
                  color: Colors.white,
                ),
                Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Colors.white,
                            elevation: 10),
                        onPressed: () async {
                          launchWhatsApp();
                        },
                        child: Logo(Logos.whatsapp))),
                Container(
                  height: 3.0,
                  width: 50,
                  color: Colors.white,
                ),
                Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Colors.white,
                            elevation: 10),
                        onPressed: () async {
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Logo(Logos.instagram)))
              ],
            )
          ]),
        ),
      ),
    );
  }

  void getUser() async {
    if (ApiList.user == null) {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      final response = await http.post(
        Uri.parse('https://fitnessjourni.com/api/getUser.php'),
        body: {'userId': userId},
      );
      if (response.statusCode == 200) {
        ApiList.user = jsonDecode(response.body);
      }
    }
  }
}
