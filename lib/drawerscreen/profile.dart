import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/screens/mainScreen.dart';
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
    return MainScreen(
      mainAppBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [];
            },
          ),
        ],
      ),
      mainChild: Column(
        children: [
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                child: Row(
                  children: [
                    CircleAvatar(
                      minRadius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    Column(
                      children: [
                        Text(
                          _displayName ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          _email ?? '',
                          style: const TextStyle(
                              fontFamily: 'Roboto', color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    SvgPicture.asset('assets/Edit.svg')
                  ],
                ),
              );
            },
          )),
          const Divider(
            color: Colors.white,
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
            // Handle Logout button tap
            () => FirebaseAuth.instance.signOut();
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
}
