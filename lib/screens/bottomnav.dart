import 'package:fitness/drawerscreen/profile.dart';
import 'package:fitness/screens/mybookings.dart';
import 'package:flutter/material.dart';

import '../theme/glassbox.dart';
import 'homepage.dart';
import 'video.dart';

class Mybottom extends StatefulWidget {
  const Mybottom({super.key});

  @override
  State<Mybottom> createState() => _MybottomState();
}

class _MybottomState extends State<Mybottom> {
  int _currentBottomIndex = 0;

  List<Widget> Pages = const [
    HomePage(),
    Video(),
    MyBookingPage(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Pages[_currentBottomIndex],
        ),
        extendBody: true,
        bottomNavigationBar: Glassbox(
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.all(TextStyle(fontSize: 15,fontWeight: FontWeight.bold))
            ),
            child: NavigationBar(
                selectedIndex: _currentBottomIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _currentBottomIndex = index;
                  });
                },
                shadowColor: Colors.white,
                indicatorColor: Colors.white,
                backgroundColor: Colors.transparent,
                elevation: 0,
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.home_outlined), label: 'Home',),
                  NavigationDestination(
                      icon: Icon(Icons.slow_motion_video_outlined),
                      label: 'Explore'),
                  NavigationDestination(
                      icon: Icon(Icons.book_online_outlined),
                      label: 'My booking'),
                  NavigationDestination(
                      icon: Icon(Icons.person_2_outlined), label: 'Profile'),
                ]),
          ),
        ));
  }
}
