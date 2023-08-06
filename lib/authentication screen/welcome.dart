import 'package:fitness/authentication%20screen/services.dart';
import 'package:fitness/authentication%20screen/signup.dart';
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
    controller = VideoPlayerController.asset('assets/welcom.mp4')
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
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.2)),
                      padding: const EdgeInsets.all(10),
                      child: Image.asset('assets/FJ FONT.png')),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 190,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.2)),
                  child: Column(
                    children: [
                      GestureDetector(
                          child: SvgPicture.asset('assets/google_sign_up.svg'),
                          onTap: () =>
                              FirebaseServices.signInWithGoogle(context)),
                      const SizedBox(height: 15),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                          },
                          child: SvgPicture.asset('assets/Signup.svg')),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: () {
                          // Handle login action
                          Navigator.pushReplacement(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => const LoginPage())));
                        },
                        child: const Text(
                          'Already have an Account? Login',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
