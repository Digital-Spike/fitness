import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/welcome.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:fitness/trainer_section/trainer_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final StreamSubscription<User?> listener;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    navigateFunction();
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

  Future<void> navigateFunction() async {
    final SharedPreferences prefs = await _prefs;
    Timer(const Duration(milliseconds: 2800), () {
      if (prefs.getString('trainerId') == null) {
        listener =
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
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
                  builder: (BuildContext context) => const MainScreen()),
            );
          }
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const TrainerHome()),
            (Route<dynamic> route) => false);
      }
    });
  }
}
