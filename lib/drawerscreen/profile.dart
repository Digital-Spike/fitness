


import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/loginpage.dart';
import 'package:fitness/authentication%20screen/termsandconditions.dart';
import 'package:fitness/profilescreens/subscription.dart';
import 'package:fitness/screens/editprofile.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:fitness/theme/profile_button.dart';
import 'package:flutter/cupertino.dart';
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
  Widget build(BuildContext context) =>
    WillPopScope(
      onWillPop: ()async{
        return true;
      },
      child: MainScreen(
        mainAppBar: AppBar(
         // backgroundColor: const Color(0xffF5E6C2),
          elevation: 0,
          title: const Center(
            child: Text(
              'Profile',
              style: TextStyle(
                  fontWeight: FontWeight.w600,  fontSize: 20,),
            ),
          ),
          actions: [
            PopupMenuButton(
              
              itemBuilder: (context) {
                return [];
              },
            ),
          ],
        // leading: BackButton(color: Colors.black,),
          
        ),
        mainChild: SingleChildScrollView(
          child: Column(
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
                            const SizedBox(height: 5,),
                            Text(
                              _displayName ?? '',
                              style:
                                  const TextStyle( fontSize: 16),
                            ),
                            Text(
                      _email ?? '',
                      style:
                          const TextStyle( fontSize: 16),
                    ),
                          ],
                        ),
                      ],
                    ),const SizedBox(height: 10),
                    const Divider(height: 1.0,thickness: 1.0,color: Colors.white,),
                    const SizedBox(height: 5),                   
                    CustomButton(title: 'Edit Profile', subtitle: 'Edit your profile here', leadingIcon: Icons.edit_outlined, trailingIcon: Icons.arrow_forward_ios, onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile()));}),
                    CustomButton(title: 'Change Password', subtitle: 'Change your password easily', leadingIcon: Icons.lock, trailingIcon: Icons.arrow_forward_ios, onPressed: (){}),
                    CustomButton(title: 'Change Language', subtitle: 'Change your Language here',leadingIcon: Icons.language_outlined, trailingIcon: Icons.arrow_forward_ios, onPressed: (){}),
                    CustomButton(title: 'Subscription', subtitle: 'Check your Subscription here',leadingIcon: Icons.credit_card, trailingIcon: Icons.arrow_forward_ios, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Subscription()));}),
                    CustomButton(title: 'Privacy and Policy', subtitle: 'Check our Policy here', leadingIcon: Icons.privacy_tip, trailingIcon: Icons.arrow_forward_ios, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditions()));}),
                     CustomButton(title: 'Logout', subtitle: 'Click here to logout', leadingIcon: Icons.logout, trailingIcon: Icons.arrow_forward_ios, onPressed: (){showLogoutPopup();}),                                                                                      
              Center(
                child: Image.asset(
                  'assets/FJ FONT.png',
                  height: 50,width: 200,
                ),
              ),
           
      ],
                ), )),
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
                  color:Colors.blue,
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
