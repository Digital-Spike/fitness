import 'package:fitness/bookingscreens/mybookings.dart';
import 'package:fitness/drawerscreen/profile.dart';
import 'package:flutter/material.dart';

import '../theme/glassbox.dart';
import 'homepage.dart';
import 'video.dart';

class MainScreen extends StatefulWidget {
  final Widget mainChild;
  final PreferredSizeWidget? mainAppBar;
  const MainScreen({required this.mainChild, this.mainAppBar, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static int? _bottomNavIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2EEFF),
      appBar: widget.mainAppBar,
      body: SafeArea(child: widget.mainChild),
      /*Center(
        child: page[_currentBottomIndex],
      ),*/
      extendBody: true,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
        child: Glassbox(
          child: NavigationBar(
              height: 70,
              selectedIndex: _bottomNavIndex ?? 0,
              onDestinationSelected: (int index) {
                switchScreen(index);
                setState(() {
                  _bottomNavIndex = index;
                });
              },

              //shadowColor: Colors.white,
              // indicatorColor: Color(0xffE2EEFF),
              backgroundColor: Colors.transparent,
              elevation: 0,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                    icon: Icon(Icons.slow_motion_video_outlined),
                    selectedIcon: Icon(Icons.slow_motion_video_sharp),
                    label: 'Explore'),
                NavigationDestination(
                    icon: Icon(Icons.book_online_outlined),
                    selectedIcon: Icon(Icons.book_online),
                    label: 'My booking'),
                NavigationDestination(
                    icon: Icon(Icons.person_2_outlined),
                    selectedIcon: Icon(Icons.person_2),
                    label: 'Profile'),
              ]),
        ),
      ),
    );
  }

  switchScreen(int index) {
    _bottomNavIndex = index;
    switch (_bottomNavIndex) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Video(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyBookingPage(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
        break;
    }
  }
}
