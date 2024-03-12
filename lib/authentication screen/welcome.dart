import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/services.dart';
import 'package:fitness/authentication%20screen/signup.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

import 'loginpage.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/welcome.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    controller.setLooping(true);
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          VideoPlayer(controller),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Image.asset('assets/png/FJ.png')),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.only(left: 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.center,
                          colors: [Colors.transparent, Colors.black])),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/svg/invertedcomma.svg'),
                        const SizedBox(height: 10),
                        RichText(
                            text: const TextSpan(
                                text: 'Start your ',
                                style: TextStyle(
                                    fontFamily: 'SpaceGrotesk',
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffB3BAC3)),
                                children: [
                              TextSpan(
                                  text: 'fitness journey',
                                  style: TextStyle(
                                      fontFamily: 'SpaceGrotesk',
                                      color: Color(0xffFFFFFF),
                                      fontWeight: FontWeight.w700)),
                              TextSpan(
                                  text:
                                      ' with personalized workouts and expert guidance in our fitness app!')
                            ])),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupPage()));
                                },
                                child: const Text(
                                  'Join Us',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SpaceGrotesk',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                      backgroundColor: Colors.black,
                                      side: const BorderSide(
                                          width: 1.5, color: Colors.white),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        (MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage())));
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'SpaceGrotesk',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 0.8,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                            ),
                            const Text('  OR  '),
                            Expanded(
                              child: Container(
                                height: 0.8,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        if (Platform.isIOS)
                          GestureDetector(
                            onTap: () async {
                              final appleProvider = AppleAuthProvider();
                              await FirebaseAuth.instance
                                  .signInWithProvider(appleProvider);
                              FirebaseAuth auth = FirebaseAuth.instance;
                              print(auth.currentUser?.uid);
                              if (auth.currentUser?.uid ==
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainScreen()))) ;
                            },
                            child: Center(
                                child:
                                    SvgPicture.asset('assets/svg/Apple.svg')),
                          ),
                        const SizedBox(height: 5),
                        GestureDetector(
                            onTap: () =>
                                FirebaseServices.signInWithGoogle(context),
                            child: Center(
                                child: SvgPicture.asset(
                                    'assets/svg/gsignup.svg'))),
                        const SizedBox(height: 5)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(appleProvider);
  }
}
