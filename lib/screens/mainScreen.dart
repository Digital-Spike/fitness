import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';
import 'package:fitness/theme/glassbox.dart';
import 'package:flutter/material.dart';

import '../drawerscreen/profile.dart';
import 'home.dart';
import 'mybookings.dart';
import 'video.dart';

class MainScreen extends StatefulWidget {
  final Widget mainChild;
  final PreferredSizeWidget? mainAppBar;
  final Color? backgroundColor;

  const MainScreen({
    required this.mainChild,
    this.mainAppBar,
    this.backgroundColor,
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static int? _bottomNavIndex;

  switchScreen(int index) {
    _bottomNavIndex = index;
    switch (_bottomNavIndex) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: widget.mainAppBar,
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.transparent,
          selectedItemBorderColor: Colors.transparent,
          selectedItemBackgroundColor: Colors.deepOrange,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.white,
          unselectedItemIconColor: Colors.grey,
          unselectedItemLabelColor: Colors.white,
        ),
        selectedIndex: _bottomNavIndex ?? 0,
        onSelectTab: (int index) {
          setState(() {
            _bottomNavIndex = index;
          });
          switchScreen(index);
        },
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
      body: SafeArea(child: widget.mainChild),
    );
  }
}
