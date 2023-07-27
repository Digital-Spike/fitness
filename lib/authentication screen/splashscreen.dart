import 'package:fitness/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});
  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
      backgroundColor: Color(0xffF5E6C2),
      splash: 'assets/logo.png',
      nextScreen: HomePage(),
      animationDuration: Duration(seconds: 2),
      splashTransition: SplashTransition.scaleTransition,
     // customTween: DecorationTween(begin: BoxDecoration(color: Colors.deepOrange),end: BoxDecoration(color: Colors.black87)),
      //curve: Curves.easeInOut,
      

    );
  }
}
