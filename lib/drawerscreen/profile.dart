import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/drawerscreen/signout.dart';
import 'package:fitness/screens/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  late String? _displayName;
  late String? _email;
  File? _profileImage;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _displayName = user?.displayName;
    _email = user?.email;
    _loadProfileImage();
  }

  Future<void> _chooseProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
      _saveProfileImage();
    }
  }

  Future<void> _loadProfileImage() async {
    _prefs = await SharedPreferences.getInstance();
    final imagePath = _prefs?.getString('profile_image_path');
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> _saveProfileImage() async {
    final imagePath = _profileImage?.path ?? '';
    await _prefs?.setString('profile_image_path', imagePath);
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
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                Container(
                  width: 300, // Increased width for the circular avatar
                  height: 80,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 60, // Increased size for the circular avatar
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    title: Text(
                      _displayName ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      _email ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onTap: _chooseProfileImage,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
                const SizedBox(height: 15),
                buildSettingsButton('Languages', Icons.language, () {
                  // Handle languages button tap
                }),
                const SizedBox(height: 15),
                buildSettingsButton('Subscription', Icons.subscriptions, () {
                  // Handle subscription button tap
                }),
                const SizedBox(height: 15),
                buildSettingsButton('Account and Privacy', Icons.security, () {
                  // Handle Account and Privacy button tap
                }),
                const SizedBox(height: 15),
                buildSettingsButton('Settings', Icons.settings, () {
                  // Handle Settings button tap
                }),
                const SizedBox(height: 15),
                buildSettingsButton('Help & Support', Icons.help, () {
                  // Handle Help & Support button tap
                }),
                const SizedBox(height: 15),
                buildSettingsButton('Logout', Icons.logout, () {
                  // Handle Logout button tap
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogoutScreen()));
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
              borderRadius: BorderRadius.circular(6),
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
