import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/authentication%20screen/splashSceen.dart';
import 'package:flutter/material.dart';

import 'authentication screen/splashscreen.dart';
import 'firebase_options.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Fitness',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'NotoSans',
        ),
        home: const SplashScreen());
  }
}
