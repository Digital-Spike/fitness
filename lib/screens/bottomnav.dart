import 'package:fitness/theme/glassbox.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../drawerscreen/profile.dart';
import 'homescreen.dart';
import 'my_bottombar.dart';
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
  static int? _currentBottomIndex;
  void _handleBottomnav(int? index) {
    setState(() {
      _currentBottomIndex = index!;
    });
    switchScreen(index!);
  }

  switchScreen(int index) {
    _currentBottomIndex = index;
    switch (_currentBottomIndex) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
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
      extendBody: true,
      bottomNavigationBar: Glassbox(
        child: Mybottom(
          index: _currentBottomIndex ?? 0,
          onTap: _handleBottomnav,
        ),
      ),
      body: SafeArea(child: widget.mainChild),
    );
  }
}
