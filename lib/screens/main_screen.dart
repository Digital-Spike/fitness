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
    // backgroundColor: const Color(0xffF5E6C2),
      appBar: widget.mainAppBar,
      body: SafeArea(child: widget.mainChild),
      
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        
         elevation: 0,
       // backgroundColor: Color(0xffF5E6C2),
          currentIndex: _bottomNavIndex ?? 0,
          onTap: (int index) {
            switchScreen(index);
            setState(() {
              _bottomNavIndex = index;
            });
          },
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w900),
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        selectedIconTheme: IconThemeData(color: Color(0xff9EEB47)),
         selectedItemColor: Color(0xff9EEB47),
         unselectedIconTheme: IconThemeData(color: Colors.white),
         unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xffF5E6C2)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.slow_motion_video_outlined),
                activeIcon: Icon(Icons.slow_motion_video_sharp),
                label: 'Explore',
                backgroundColor: Color(0xffF5E6C2)
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_online_outlined),
                activeIcon: Icon(Icons.book_online),
                label: 'My booking',
                backgroundColor: Color(0xffF5E6C2)
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                activeIcon: Icon(Icons.person_2),
                label: 'Profile',
                backgroundColor: Color(0xffF5E6C2)
                ),
          ]),
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
