import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/authentication%20screen/log_in.dart';
import 'package:fitness/authentication%20screen/splashSceen.dart';
import 'package:fitness/screens/mainScreen.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication screen/welcome.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
