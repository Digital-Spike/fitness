import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/authentication%20screen/log_in.dart';
import 'package:fitness/authentication%20screen/splashSceen.dart';
import 'package:fitness/schedule/alvailableranches.dart';
import 'package:fitness/schedule/branches.dart';
import 'package:fitness/schedule/gettrinerdetails.dart';
import 'package:fitness/schedule/selecttrainers.dart';
import 'package:fitness/schedule/slot.dart';
import 'package:fitness/schedule/slotbooking.dart';
import 'package:fitness/schedule/trainerlist.dart';
import 'package:fitness/screens/mainScreen.dart';
// Import the generated file
import 'authentication screen/welcome.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication screen/welcome.dart';
import 'schedule/getbranchtrainers.dart';

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

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fitness',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
        ),
        home: SplashScreen());
  }
}
