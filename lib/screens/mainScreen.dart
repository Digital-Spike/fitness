import 'package:ff_navigation_bar_plus/ff_navigation_bar_plus.dart';
import 'package:fitness/screens/homepage.dart';
import 'package:fitness/theme/glassbox.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F1F2),
      appBar: widget.mainAppBar,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Colors.white,
            indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
        child: NavigationBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.grey,
          shadowColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 60,
          selectedIndex: _bottomNavIndex ?? 0,
          onDestinationSelected: (int index) {
            setState(() {
              _bottomNavIndex = index;
            });
            switchScreen(index);
          },
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(IonIcons.barbell),
              icon: Icon(IonIcons.barbell_sharp),
              label: 'Explore',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.book_online),
              icon: Icon(Icons.book_online_outlined),
              label: 'Bookings',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: SafeArea(child: widget.mainChild),
    );
  }
}
