import 'package:fitness/profilescreens/profile.dart';
import 'package:fitness/my_booking/mybookings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w600, fontFamily: 'WorkSans'),
          unselectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w600, fontFamily: 'WorkSans'),
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xffB3BAC3),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svg/homegrey.svg'),
              activeIcon: SvgPicture.asset('assets/svg/home.svg'),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svg/exploregrey.svg'),
              activeIcon: SvgPicture.asset('assets/svg/explore.svg'),
              label: 'EXPLORE',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svg/bookinggrey.svg'),
              activeIcon: SvgPicture.asset('assets/svg/booking.svg'),
              label: 'BOOKINGS',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svg/profilegrey.svg'),
              activeIcon: SvgPicture.asset('assets/svg/profile.svg'),
              label: 'PROFILE',
            ),
          ],
        ),
      ),
    );
  }
}
