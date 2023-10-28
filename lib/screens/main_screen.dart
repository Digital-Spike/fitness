import 'package:fitness/drawerscreen/profile.dart';
import 'package:fitness/my_booking/mybookings.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
import 'video.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String id = 'main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Video(),
    MyBookingPage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex > 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false; // Prevent app from closing
        }
        return true; // Allow app to close
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          selectedIconTheme: IconThemeData(color: Color(0xff9EEB47)),
          selectedItemColor: Color(0xff9EEB47),
          unselectedIconTheme: IconThemeData(color: Colors.white),
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Color(0xffF5E6C2)),
            BottomNavigationBarItem(
                icon: Icon(Icons.slow_motion_video_outlined),
                activeIcon: Icon(Icons.slow_motion_video_sharp),
                label: 'Explore',
                backgroundColor: Color(0xffF5E6C2)),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_online_outlined),
                activeIcon: Icon(Icons.book_online),
                label: 'My booking',
                backgroundColor: Color(0xffF5E6C2)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                activeIcon: Icon(Icons.person_2),
                label: 'Profile',
                backgroundColor: Color(0xffF5E6C2)),
          ],
        ),
      ),
    );
  }
}
