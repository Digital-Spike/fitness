import 'package:fitness/schedule/partner.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../schedule/trainer.dart';
import 'freetrialsession.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Url =
      'https://instagram.com/fitness_journey_uae?igshid=MzRlODBiNWFlZA==';
  final number = '';
  launchWhatsApp() async {
    final link = const WhatsAppUnilink(
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
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/IMG_9779.jpg'), fit: BoxFit.cover)),
        child: Column(children: [
          const SizedBox(height: 25),
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                image: const DecorationImage(
                    image: AssetImage('assets/fitness.png'),
                    scale: 2,
                    alignment: Alignment.center)),
          ),
          Container(
            height: 15,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.orange,
              Colors.indigo,
              Colors.green,
              Colors.blue
            ])),
          ),
          const SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FreeTrialSession()));
            },
            child: Container(
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
                  const SizedBox(height: 10),
                  const Text(
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
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Partner()));
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
            ],
          ),
          const SizedBox(height: 60),
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
                        if (await canLaunch(Url)) {
                          await launch(Url);
                        } else {
                          throw 'Could not launch $Url';
                        }
                      },
                      child: Logo(Logos.instagram)))
            ],
          )
        ]),
      ),
    );
  }
}
