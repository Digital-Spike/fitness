import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../drawerscreen/profile.dart';
import 'home.dart';
import 'mybookings.dart';
import 'video.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int current_value = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    Video(),
    MyBookingScreen(),
    Profile(),
  ];

  void onTapped(int value) {
    setState(() {
      current_value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.transparent,
          selectedItemBackgroundColor: Colors.deepOrange,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
          unselectedItemIconColor: Colors.grey,
          unselectedItemLabelColor: Colors.black,
        ),
        selectedIndex: current_value,
        onSelectTab: onTapped,
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: Icons.video_call,
            label: 'Explore',
          ),
          FFNavigationBarItem(
            iconData: Icons.book_online,
            label: 'MyBooking',
          ),
          FFNavigationBarItem(
            iconData: Icons.person,
            label: 'Profile',
          ),
        ],
      ),
      body: _pages[current_value],
    );
  }
}
