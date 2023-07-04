import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/loginpage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late String? _displayName;
  late String? _email;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _displayName = user.displayName;
    _email = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF1F1F2),
        elevation: 0,
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        actions: [
          PopupMenuButton(
            color: Colors.black,
            itemBuilder: (context) {
              return [];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  child: CircleAvatar(
                    minRadius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child:
                        _profileImage == null ? const Icon(Icons.person) : null,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      _displayName ?? '',
                      style: const TextStyle(color: Colors.black),
                    ),
                    Text(
                      _email ?? '',
                      style: const TextStyle(
                          fontFamily: 'Roboto', color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                SvgPicture.asset('assets/Edit.svg')
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            buildSettingsButton('Languages', Icons.language, () {
              // Handle languages button tap
            }),
            const SizedBox(height: 10),
            buildSettingsButton('Subscription', Icons.subscriptions, () {
              // Handle subscription button tap
            }),
            const SizedBox(height: 10),
            buildSettingsButton('Account and Privacy', Icons.security, () {
              // Handle Account and Privacy button tap
            }),
            const SizedBox(height: 10),
            buildSettingsButton('Settings', Icons.settings, () {
              // Handle Settings button tap
            }),
            const SizedBox(height: 10),
            buildSettingsButton('Help & Support', Icons.help, () {
              // Handle Help & Support button tap
            }),
            const SizedBox(height: 10),
            buildSettingsButton('Logout', Icons.logout, () {
              showLogoutPopup();
            }),
            const SizedBox(height: 10),
            Center(
              child: Image.asset(
                'assets/fitnessname.png',
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsButton(
      String title, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 6),
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showLogoutPopup() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Are you sure?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text(
                    'YES',
                    style: TextStyle(
                      color: Color(0xff0f4c81),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginPage()),
                          ModalRoute.withName('/'));
                    });
                  },
                ),
                TextButton(
                  child: const Text(
                    'NO',
                    style: TextStyle(
                      color: Color(0xff0f4c81),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
