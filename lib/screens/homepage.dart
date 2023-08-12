// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/gymscreens/branches.dart';
import 'package:fitness/gymscreens/partner.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:fitness/screens/offers.dart';
import 'package:fitness/screens/ourpackages.dart';
import 'package:fitness/screens/packages_.dart';
import 'package:fitness/trainerscreens/our_trainers.dart';
import 'package:fitness/trainerscreens/trainer_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'freetrialsession.dart';

const colorizeColors = [
  Colors.purple,
  Colors.blue,
];

const colorizeTextStyle = TextStyle(
    fontSize: 18.0, fontFamily: 'ITCAvant', fontWeight: FontWeight.w700);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   final user = FirebaseAuth.instance.currentUser!;
  late String? _displayName;
  File? _profileImage;
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
     _displayName = user.displayName;
  }
  

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainAppBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        title: Row(
         mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              minRadius: 30,
               backgroundColor: Colors.white,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? const Icon(Icons.person)
                            : null,
            ),SizedBox(width: 10),
            Text(_displayName??''),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          Icon(Icons.notifications),SizedBox(width: 10,)
        ],
      ),
      mainChild: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   height: 70,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       color: Colors.black.withOpacity(0.9),
              //       image: const DecorationImage(
              //           image: AssetImage('assets/FJ FONT.png'),
              //           scale: 10,
                        
              //           alignment: Alignment.center)),
              // ),
              // Container(
              //   height: 10,
              //   width: double.infinity,
              //   decoration: const BoxDecoration(
              //       gradient: LinearGradient(
              //           begin: Alignment.topLeft,
              //           end: Alignment.bottomRight,
              //           colors: [
              //         Colors.orange,
              //         Colors.indigo,
              //         Colors.green,
              //         Colors.blue
              //       ])),
              // ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FreeTrialSession(
                                isBranch: false,
                                trainer: {},
                              )));
                },
                child: Container(
                    
                  padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.black),
                      color: Colors.white,
                      /* gradient: const LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Colors.deepOrange,Colors.yellow])*/
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText('Book Free Trial Session',
                            textStyle: colorizeTextStyle,
                            colors: colorizeColors,
                            speed: const Duration(milliseconds: 200))
                      ],
                      isRepeatingAnimation: true,
                      totalRepeatCount: 100,
                    )),
              ),
      
              /* GestureDetector(
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
          ),*/
              const SizedBox(height: 20),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 120,
                            crossAxisCount: 2),
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BranchList()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 3, color: Colors.white),
                              color: Color(0xfff26f14)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/Gym.png',
                                  height: 50,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'EMS at Gym',
                                style: TextStyle(
                                    
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
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
                                  builder: (context) => const TrainerList(
                                        isBranchTrainers: false,
                                      )));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 3, color: Colors.white),
                              color: Color(0xff758058)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/home.png',
                                  height: 50,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'EMS at Home',
                                style: TextStyle(
                                   
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
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
                                  builder: (context) => const OurTrainers(
                                        isOurTrainers: true,
                                        isBranchTrainers: false,
                                      )));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 3, color: Colors.white),
                              color: Color(0xff8cbd62)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/trainer.png',
                               height: 50,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Our Trainers',
                                style: TextStyle(
                                    
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
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
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 3, color: Colors.white),
                              color: Color(0xfffff4d4d)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/barbell.png',
                                height: 50,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Our Partners',
                                style: TextStyle(
                                    
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
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
                                  builder: (context) => const Packages()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 3, color: Colors.white),
                              color: Color(0xffffc16a)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/plan.png',
                                height: 50,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Our Packages',
                                style: TextStyle(
                                    
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
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
                                  builder: (context) => const Offers()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 3, color: Colors.white),
                              color: Color(0xff006c84)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/offer.png',
                                height: 50,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                'Our Offers',
                                style: TextStyle(
                                    
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
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
              const SizedBox(height: 30),
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
                          onPressed: () {
                            launch('tel://+971588340905');
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
