import 'package:flutter/material.dart';

import 'bottomnav.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainChild: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
              height: 800,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/IMG_9750.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.7),
                    child: Center(
                        child: Image.asset(
                      'assets/fitness.png',
                      height: 300,
                      width: 600,
                      scale: 2,
                    )),
                  ),
                  Container(
                    height: 20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.orange,
                      Colors.indigo,
                      Colors.green,
                      Colors.blue
                    ])),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            height: 140,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.7)),
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
                                      color: Colors.white,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Wrap(spacing: 10, runSpacing: 25, children: [
                          Container(
                            height: 140,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange.withOpacity(0.7),
                            ),
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
                                      color: Colors.white,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 140,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.indigo.withOpacity(0.7),
                            ),
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
                                      color: Colors.white,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 140,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green.withOpacity(0.7),
                            ),
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
                                      color: Colors.white,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 140,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.withOpacity(0.7),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/offer.png', scale: 2),
                                SizedBox(height: 5),
                                Text(
                                  'Our Offers',
                                  style: TextStyle(
                                      fontFamily: 'ITCAvant',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ])
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
