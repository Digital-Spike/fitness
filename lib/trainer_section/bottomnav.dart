import 'package:fitness/trainer_section/trainer_home.dart';
import 'package:flutter/material.dart';

class Tscreen extends StatefulWidget {
  final Widget trainerChild;
  final PreferredSizeWidget? trainerAppbar;
  const Tscreen({required this.trainerChild, this.trainerAppbar, super.key});

  @override
  State<Tscreen> createState() => _TrainerState();
}

class _TrainerState extends State<Tscreen> {
  static int? _bottomNavIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.trainerAppbar,
      body: SafeArea(child: widget.trainerChild),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          // backgroundColor: Color(0xffF5E6C2),
          currentIndex: _bottomNavIndex ?? 0,
          onTap: (index) => switchScreen(index),

          // setState(() {
          //   _bottomNavIndex = index;
          // });

          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w900),
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

            // BottomNavigationBarItem(
            //     icon: Icon(Icons.person_2_outlined),
            //     activeIcon: Icon(Icons.person_2),
            //     label: 'Profile',
            //     backgroundColor: Color(0xffF5E6C2)),
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
            builder: (context) => const TrainerHome(),
          ),
        );
        break;
      // case 1:
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const TrainerAccount(),
      //     ),
      //   );
      //   break;
    }
  }
}
