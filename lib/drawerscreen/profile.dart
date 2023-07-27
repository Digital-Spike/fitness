


import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/loginpage.dart';
import 'package:fitness/screens/editprofile.dart';
import 'package:fitness/screens/homepage.dart';
import 'package:fitness/screens/main_screen.dart';
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
  Widget build(BuildContext context) {
    return MainScreen(
      mainAppBar: AppBar(
        backgroundColor: const Color(0xffF5E6C2),
        elevation: 0,
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black, fontSize: 20),
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
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
                
          },
        ),
        
      ),
      mainChild: SingleChildScrollView(
        child: Column(
          children: [
           SizedBox(height: 10),
                  SizedBox(
                    height: 110,
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
                          Text(
                            _displayName ?? '',
                            style:
                                const TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Text(
                    _email ?? '',
                    style:
                        const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                        ],
                      ),
                      
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                    },
                    child: SvgPicture.asset(
                      'assets/Edit.svg',color: Colors.black,
                    ),
                  ),
                    ],
                  ),SizedBox(height: 10),
                  Divider(height: 1.0,thickness: 1.0,color: Colors.black,),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.yellow[50]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/password.png'),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Change Password',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                Text('Change your password easily')
                              ],
                            ),
                            
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios)

                      ],
                    ),
                  ),
                   Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.yellow[50]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/arabic.png'),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Change Language',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                Text('Change your Language here')
                              ],
                            ),
                            
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios)

                      ],
                    ),
                  ),
                   Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:  Colors.yellow[50]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/credit-card.png'),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Subscription',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                Text('Check your Subscription here')
                              ],
                            ),
                            
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios)

                      ],
                    ),
                  ),
                   Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.yellow[50]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/insurance.png'),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Privacy and Policy',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                Text('Check our Policy here')
                              ],
                            ),
                            
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios)

                      ],
                    ),
                  ),
                   GestureDetector(
                    onTap: (){
                      showLogoutPopup();
                    },
                     child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.yellow[50]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: [
                          Row(
                            children: [
                            Icon(Icons.logout_outlined,size: 35,),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Logout',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                  Text('Click here to logout ')
                                ],
                              ),
                              
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios)
                   
                        ],
                      ),
                                     ),
                   ),
                  
               
            
            
            
            const SizedBox(height: 5),
            Center(
              child: Image.asset(
                'assets/FJ FONT.png',
                height: 50,width: 250,
              ),
            ),
         
    ],
              ), ));
  }

  

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
              color: Colors.black,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            MaterialButton(
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
            MaterialButton(
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
        );
      },
    );
  }
}
