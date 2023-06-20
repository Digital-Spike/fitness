import 'package:fitness/authentication%20screen/log_in.dart';
import 'package:fitness/authentication%20screen/welcome.dart';
import 'package:fitness/screens/mainScreen.dart';
import 'package:fitness/authentication%20screen/sign_in.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Welcome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          height: 280, // Adjust the height as needed
          width: 220, // Adjust the width as needed
        ),
      ),
    );
  }
}
