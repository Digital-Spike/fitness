import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/welcome.dart';
import 'package:fitness/screens/homepage.dart';
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
    Timer(const Duration(milliseconds: 2800), () {
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const HomePage()),
          );
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
      //backgroundColor: Color(0xffF5E6C2),
      body: Center(
        child: Image.asset(
          'assets/FJ.gif',
          height: 350, // Adjust the height as needed
          width: 300, // Adjust the width as needed
        ),
      ),
    );
  }
}
