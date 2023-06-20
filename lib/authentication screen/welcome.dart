import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'loginpage.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.2)),
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
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 190,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.2)),
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/Applesignup.svg'),
                        SizedBox(height: 15),
                        SvgPicture.asset('assets/Signup.svg'),
                        SizedBox(height: 25),
                        GestureDetector(
                          onTap: () {
                            // Handle login action
                            Navigator.push(
                                context,
                                (MaterialPageRoute(
                                    builder: (context) => LoginPage())));
                          },
                          child: Text(
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
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
