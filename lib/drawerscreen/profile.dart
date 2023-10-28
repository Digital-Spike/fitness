import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/forgetpassword.dart';
import 'package:fitness/authentication%20screen/loginpage.dart';
import 'package:fitness/authentication%20screen/termsandconditions.dart';
import 'package:fitness/profilescreens/subscription.dart';
import 'package:fitness/screens/editprofile.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:fitness/theme/profile_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
              actions: [
                PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => <PopupMenuEntry>[
                          PopupMenuItem(
                              padding: const EdgeInsets.all(5),
                              child: GestureDetector(
                                onTap: () {},
                                child: const Row(
                                  children: [
                                    Icon(CupertinoIcons.delete),
                                    Text(' Delete Account')
                                  ],
                                ),
                              ))
                        ]),
              ],
              // leading: BackButton(color: Colors.black,),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 95,
                    child: CircleAvatar(
                      minRadius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            _displayName ?? '',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            _email ?? '',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 1.0,
                    thickness: 1.0,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 5),
                  CustomButton(
                    title: 'Edit Profile',
                    subtitle: 'Edit your profile here',
                    trailingIcon: Icons.arrow_forward_ios,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfile()));
                    },
                    svgPath: 'assets/edit-3.svg',
                  ),
                  CustomButton(
                    title: 'Change Password',
                    subtitle: 'Change your password easily',
                    trailingIcon: Icons.arrow_forward_ios,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()));
                    },
                    svgPath: 'assets/Locked.svg',
                  ),
                  CustomButton(
                    title: 'Change Language',
                    subtitle: 'Change your Language here',
                    trailingIcon: Icons.arrow_forward_ios,
                    onPressed: () {},
                    svgPath: 'assets/ab-2.svg',
                  ),
                  CustomButton(
                    title: 'Subscription',
                    subtitle: 'Check your Subscription here',
                    trailingIcon: Icons.arrow_forward_ios,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Subscription()));
                    },
                    svgPath: 'assets/CC.svg',
                  ),
                  CustomButton(
                    title: 'Privacy and Policy',
                    subtitle: 'Check our Policy here',
                    trailingIcon: Icons.arrow_forward_ios,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TermsAndConditions()));
                    },
                    svgPath: 'assets/I.svg',
                  ),
                  CustomButton(
                    title: 'Logout',
                    subtitle: 'Click here to logout',
                    trailingIcon: Icons.arrow_forward_ios,
                    onPressed: () {
                      showLogoutPopup();
                    },
                    svgPath: 'assets/lOGOUT SVG.svg',
                  ),
                  // CustomButton(
                  //     title: 'Delete Account',
                  //     subtitle: 'Click here to delete account',
                  //     svgPath: 'assets/delete.svg',
                  //     trailingIcon: Icons.arrow_forward_ios,
                  //     onPressed: () {}),
                  Center(
                    child: Image.asset(
                      'assets/FJ FONT.png',
                      height: 50,
                      width: 200,
                    ),
                  ),
                ],
              ),
            )),
      );

  Future<void> showLogoutPopup() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
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
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text(
                'YES',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const LoginPage()),
                      ModalRoute.withName('/'));
                });
              },
            ),
            MaterialButton(
              child: const Text(
                'NO',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
