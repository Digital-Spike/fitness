// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/forgetpassword.dart';
import 'package:fitness/authentication%20screen/services.dart';
import 'package:fitness/authentication%20screen/signup.dart';
import 'package:fitness/authentication%20screen/trainerlogin.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSecurePassword = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  userLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text(
              'Error',
              textAlign: TextAlign.center,
            ),
            content: const Text(
              'Please enter email and password to login.',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Return early if fields are empty
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      final response = await http.post(
        Uri.parse('https://fitnessjourni.com/api/getUser.php'),
        body: {'userId': userId},
      );

      if (response.statusCode == 200) {
        ApiList.user = jsonDecode(response.body);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignupPage()));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e.code);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text(
                'Login Error',
                textAlign: TextAlign.center,
              ),
              content: Text(
                errorMessage,
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email. please check the email and try again';
      case 'wrong-password':
        return 'Invalid password. please check the password and try again';
      case 'invalid-email':
        return 'Invalid email format.';
      default:
        return 'An error occurred. Please try again later.';
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(width: 1, color: Colors.white)),
              title: Center(
                  child: Text(
                message,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w600),
              )));
        });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String emailString = "Enter your email address";
  String password = "Enter your password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back!',
                    style: TextStyle(
                      color: Color(0xffFF6600),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SpaceGrotesk',
                    ),
                  ),
                  RichText(
                      text: const TextSpan(
                          text: "Let's continue your ",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'SpaceGrotesk',
                          ),
                          children: [
                        TextSpan(
                            text: 'fitness journey',
                            style: TextStyle(fontWeight: FontWeight.w900))
                      ])),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      floatingLabelStyle: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 16,
                          color: Color(0xffB3BAC3)),
                      labelStyle: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 16,
                          color: Color(0xffB3BAC3)),
                      labelText: emailString,
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.white,
                              style: BorderStyle.solid)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.white,
                              style: BorderStyle.solid)),
                    ),
                    onTap: (() {
                      setState(() {
                        emailString = "Email Address";
                      });
                    }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isSecurePassword,
                    decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 16,
                            color: Color(0xffB3BAC3)),
                        labelStyle: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 16,
                            color: Color(0xffB3BAC3)),
                        labelText: password,
                        suffixIcon: togglepassword(),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                                style: BorderStyle.solid)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                                style: BorderStyle.solid)),
                        border: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white))),
                    onTap: () {
                      setState(() {
                        password = "Password";
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffFF6600)),
                          ),
                        ],
                      )),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50)),
                      onPressed: userLogin,
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'SpaceGrotesk',
                            fontWeight: FontWeight.w600),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 0.5,
                          width: double.infinity,
                          color: Colors.white,
                        )),
                        const Text('  OR  '),
                        Expanded(
                            child: Container(
                          height: 0.5,
                          width: double.infinity,
                          color: Colors.white,
                        ))
                      ],
                    ),
                  ),
                  if (Platform.isIOS)
                    GestureDetector(
                        onTap: () async {
                          final appleProvider = AppleAuthProvider();
                          await FirebaseAuth.instance
                              .signInWithProvider(appleProvider);
                          FirebaseAuth auth = FirebaseAuth.instance;
                          print(auth.currentUser?.uid);
                          if (auth.currentUser?.uid ==
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainScreen()))) ;
                        },
                        child: Center(
                            child: SvgPicture.asset('assets/svg/Apple.svg'))),
                  const SizedBox(height: 5),
                  GestureDetector(
                      onTap: () {
                        FirebaseServices.signInWithGoogle(context);
                      },
                      child: Center(
                          child: SvgPicture.asset('assets/svg/gsignup.svg'))),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 46),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            side: const BorderSide(
                                width: 1.5, color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TrainerLogin()));
                        },
                        child: const Text(
                          'Login as a Trainer',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'SpaceGrotesk',
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()));
                      },
                      child: RichText(
                          text: const TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                  fontFamily: 'SpaceGrotesk',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffB3BAC3)),
                              children: [
                            TextSpan(
                                text: ' Sign Up',
                                style: TextStyle(
                                    fontFamily: 'SpaceGrotesk',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffFF6600)))
                          ])),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget togglepassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? const Icon(
              Icons.visibility,
            )
          : const Icon(Icons.visibility_off),
      color: Colors.white,
    );
  }

  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(appleProvider);
  }
}
