import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/welcome.dart';
import 'package:fitness/screens/home.dart';
import 'package:fitness/screens/homescreen.dart';
import 'package:fitness/screens/mainScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<User?> listener;
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      listener = FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user ==
                null /*||
            ((user.email ?? "").isNotEmpty && !user.emailVerified)*/
            ) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Welcome(),
            ),
          );
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => Home()),
              ModalRoute.withName('/'));
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
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
