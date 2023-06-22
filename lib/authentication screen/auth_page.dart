import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/loginpage.dart';
import 'package:fitness/screens/home.dart';
import 'package:flutter/material.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
