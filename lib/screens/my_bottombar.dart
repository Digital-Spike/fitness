import 'package:flutter/material.dart';

class Mybottom extends StatelessWidget {
  final int index;
  final Function(int?) onTap;
  const Mybottom({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: index,
        onTap: onTap,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.slow_motion_video_outlined), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_online_outlined), label: 'My booking'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: 'profile'),
        ]);
  }
}
