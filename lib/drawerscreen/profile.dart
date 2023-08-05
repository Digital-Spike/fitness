


import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/loginpage.dart';
import 'package:fitness/profilescreens/subscription.dart';
import 'package:fitness/screens/editprofile.dart';
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
                        
                    // const SizedBox(width: 10),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                    //   },
                    //   child: SvgPicture.asset(
                    //     'assets/Edit.svg',
                    //   ),
                    // ),
                      ],
                    ),const SizedBox(height: 10),
                    const Divider(height: 1.0,thickness: 1.0,color: Colors.white,),
                    const SizedBox(height: 5),
                     GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile()));
                      },
                       child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffe2e8e4)),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          
                          children: [
                            Row(
                              children: [

                              
                               SvgPicture.asset('assets/edit-3.svg',height: 40),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Edit Profile',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                                    Text('Edit your profile here',style: TextStyle(color: Colors.black),)
                                  ],
                                ),
                                
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,color: Colors.black,)
                         
                          ],
                        ),
                                         ),
                     ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffe2e8e4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/lock.svg',height: 40,),
                              const SizedBox(width: 10),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Change Password',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                                  Text('Change your password easily',style: TextStyle(color: Colors.black),)
                                ],
                              ),
                              
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios,color: Colors.black,)
    
                        ],
                      ),
                    ),
                     Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffe2e8e4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/ab-2.svg',height: 40,color: Colors.black,),
                              const SizedBox(width: 10),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Change Language',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                                  Text('Change your Language here',style: TextStyle(color: Colors.black),)
                                ],
                              ),
                              
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios,color: Colors.black,)
    
                        ],
                      ),
                    ),
                     GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Subscription()));
                      },
                       child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:  Color(0xffe2e8e4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/CC.svg',height: 40,),
                                const SizedBox(width: 10),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Subscription',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                                    Text('Check your Subscription here',style: TextStyle(color: Colors.black),)
                                  ],
                                ),
                                
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios,color: Colors.black,)
                         
                          ],
                        ),
                                         ),
                     ),
                     Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffe2e8e4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/I.svg',height: 40,),
                              const SizedBox(width: 5),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Privacy and Policy',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                                  Text('Check our Policy here',style: TextStyle(color: Colors.black),)
                                ],
                              ),
                              
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios,color: Colors.black,)
    
                        ],
                      ),
                    ),
                     GestureDetector(
                      onTap: (){
                        showLogoutPopup();
                      },
                       child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffe2e8e4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          
                          children: [
                            Row(
                              children: [
                             // Icon(Icons.logout_outlined,size: 35,color: Colors.black,),
                             Padding(
                               padding: const EdgeInsets.only(left: 5),
                               child: SvgPicture.asset('assets/Logout.svg',height: 35,),
                             ),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Logout',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                                    Text('Click here to logout ',style: TextStyle(color: Colors.black),)
                                  ],
                                ),
                                
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,color: Colors.black,)
                     
                          ],
                        ),
                                       ),
                     ),
                    
                 
              
              
              
             
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
