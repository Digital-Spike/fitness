import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/gymscreens/partner.dart';
import 'package:fitness/profilescreens/privacy_policy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/loginpage.dart';
import 'package:fitness/profilescreens/subscription.dart';
import 'package:fitness/profilescreens/editprofile.dart';

import 'package:fitness/profilescreens/profile_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late String? _email;
  File? _profileImage;
  String? mobile, email;
  String imageUrl = "";
  String name = '';
  static const url =
      'https://instagram.com/fitness_journey_uae?igshid=MzRlODBiNWFlZA==';
  final number = '+971588340905';
  launchWhatsApp() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+971588340905',
      text: "Hi",
    );

    await launch('$link');
  }

  Future<void> contactDial(String number) async {
    await _launchCaller(number);
  }

  _launchCaller(String number) async {
    String url = Platform.isIOS ? 'tel://$number' : 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    imageUrl = "https://fitnessjourni.com/api/uploads/$userId.jpg";
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
                  fontFamily: 'SpaceGrotesk',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  height: 1.0,
                  color: const Color(0xff142129),
                ),
              ),
              centerTitle: true,
              leading: const BackButton(
                color: Colors.white,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    color: const Color(0xff142129),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xff142129)),
                              height: 85,
                              width: 85,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: imageUrl,
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          padding: EdgeInsets.all(25),
                                          child: SvgPicture.asset(
                                            'assets/svg/fjuser.svg',
                                            height: 10,
                                            width: 10,
                                          ),
                                        )),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  name.isNotEmpty ? name.toString() : "Welcome",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'SpaceGrotesk',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  mobile == null ? '' : '+971 $mobile',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffFF6600),
                                      fontFamily: 'WorkSans',
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                minimumSize: const Size(100, 40)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfile()));
                            },
                            child: const Text(
                              'EDIT',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w600),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomButton(
                    title: 'Subscription',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Subscription()));
                    },
                    svgPath: '',
                  ),
                  CustomButton(
                    title: 'Our Partners',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Partner()));
                    },
                    svgPath: '',
                  ),
                  CustomButton(
                    title: 'Privacy and Policy',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyPolicy()));
                    },
                    svgPath: '',
                  ),
                  CustomButton(
                    title: 'Logout',
                    onPressed: () {
                      showLogoutPopup();
                    },
                    svgPath: '',
                  ),
                  const SizedBox(height: 35),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Need assistance or have questions? Reach out to us for personalized support on your fitness journey!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                launch('tel://+971588340905');
                                launch('tel:+971588340905');
                                contactDial;
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(25),
                                height: 72,
                                width: 72,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white),
                                child: SvgPicture.asset(
                                  'assets/svg/call.svg',
                                  height: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 50),
                            GestureDetector(
                              onTap: () async {
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(25),
                                height: 72,
                                width: 72,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white),
                                child: SvgPicture.asset(
                                  'assets/svg/instagram.svg',
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                            child: GestureDetector(
                          onTap: () {
                            launchWhatsApp();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(25),
                            height: 77,
                            width: 77,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 3, color: Colors.black),
                                color: Colors.white),
                            child: SvgPicture.asset(
                              'assets/svg/whatsapp.svg',
                              height: 20,
                            ),
                          ),
                        ))
                      ],
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
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1, color: Colors.white)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: const Text(
            'Are you sure you want to log\nout?',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          content: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(154, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(154, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side:
                              const BorderSide(width: 1, color: Colors.white))),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'SpaceGrotesk',
                        fontWeight: FontWeight.w600),
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
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String> getUser() async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      String url = 'https://fitnessjourni.com/api/getUser.php';

      var response = await http.post(Uri.parse(url), body: {'userId': userId});
      print(response.body);
      var jsondata = json.decode(response.body);

      setState(() {
        name = jsondata['name'];
        mobile = jsondata['phoneNumber'];
        email = jsondata['email'];
        userId = jsondata['userId'];
        imageUrl = "https://fitnessjourni.com/api/uploads/$userId.png";
      });
    } on HandshakeException catch (_) {}
    return "success";
  }
}
