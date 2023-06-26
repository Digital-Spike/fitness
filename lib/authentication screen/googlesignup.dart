import 'package:fitness/authentication%20screen/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleSignUp extends StatefulWidget {
  const GoogleSignUp({super.key});

  @override
  State<GoogleSignUp> createState() => _GoogleSignUpState();
}

class _GoogleSignUpState extends State<GoogleSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage('assets/IMG_9750.jpg'),
              fit: BoxFit.cover,
              opacity: 0.98,
            )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.3)),
                child: Column(
                  children: const [
                    SizedBox(height: 20),
                    Text(
                      'Transform your body\nand mind',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'with the ultimate EMS fitness journey app for anyone who wants to take control of their health and fitness',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.3)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      TextFormField(
                        decoration: InputDecoration(
                            label: const Text('User Name'),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter user name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                            label: const Text('Gmail'),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {},
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                            label: const Text('Paswword'),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {},
                      ),
                      const SizedBox(height: 15),
                      SvgPicture.asset('assets/Googlesignup.svg'),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) =>
                                      const LoginPage(),
                                  transitionDuration:
                                      const Duration(seconds: 0),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              'Already have an Account? Login',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
