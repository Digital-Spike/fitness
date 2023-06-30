/*import 'package:fitness/drawerscreen/profile.dart';
import 'package:fitness/screens/homepage.dart';
import 'package:fitness/screens/mybookings.dart';
import 'package:fitness/screens/video.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class MaterialYou extends StatefulWidget {
  const MaterialYou({Key? key}) : super(key: key);

  @override
  State<MaterialYou> createState() => _MaterialYouState();
}

class _MaterialYouState extends State<MaterialYou> {
  int _currentIndex = 0;
  List<Widget> pages = const [
    HomePage(),
    Video(),
    MyBookingPage(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Colors.white,
            indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
        child: NavigationBar(
          backgroundColor: Colors.white,
          surfaceTintColor: const Color(0xff2bb793),
          shadowColor: const Color(0xff2bb793),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 60,
          selectedIndex: _currentIndex,
          onDestinationSelected: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
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
    );
  }
}*/
