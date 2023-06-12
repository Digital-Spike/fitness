import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16),
        children: [
          Container(
            color: Colors.grey[800],
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null ? Icon(Icons.person) : null,
              ),
              title: Text(
                _displayName ?? '',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                _email ?? '',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.edit,
                color: Colors.grey,
              ),
              onTap: _chooseProfileImage,
            ),
          ),
          Divider(
            color: Colors.white, // Set the divider color to white
            thickness: 1, // Set the thickness as desired
          ),
          SizedBox(height: 20),
          buildSettingsButton('Languages', Icons.language, () {
            // Handle languages button tap
          }),
          SizedBox(height: 20),
          buildSettingsButton('Subscription', Icons.subscriptions, () {
            // Handle subscription button tap
          }),
          SizedBox(height: 20),
          buildSettingsButton('Account and Privacy', Icons.security, () {
            // Handle Account and Privacy button tap
          }),
          SizedBox(height: 20),
          buildSettingsButton('Settings', Icons.settings, () {
            // Handle Settings button tap
          }),
          SizedBox(height: 20),
          buildSettingsButton('Help & Support', Icons.help, () {
            // Handle Help & Support button tap
          }),
          SizedBox(height: 20),
          buildSettingsButton('Logout', Icons.logout, () {
            // Handle Logout button tap
          }),
          SizedBox(height: 20),
          Center(
            child: Image.asset(
              'assets/fitnessname.png',
              height: 80, // Adjust the height as needed
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSettingsButton(
      String title, IconData icon, VoidCallback onPressed) {
    return Container(
      width: 200, // Set the desired width of the button
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 10, vertical: 1), // Adjust the padding as needed
      child: ListTile(
        title: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
        ),
        onTap: onPressed,
      ),
    );
  }
}
