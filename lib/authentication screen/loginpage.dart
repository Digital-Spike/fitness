import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/forgetpassword.dart';
import 'package:fitness/authentication%20screen/services.dart';
import 'package:fitness/authentication%20screen/signup.dart';
import 'package:fitness/authentication%20screen/trainerlogin.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/screens/homepage.dart';
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

  userLogin() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      // Get the user ID after successful login
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      // Make an API call and pass the user ID
      final response = await http.post(
        Uri.parse('https://fitnessjourni.com/api/getUser.php'),
        body: {'userId': userId},
      );

      if (response.statusCode == 200) {
        ApiList.user = jsonDecode(response.body);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignupPage()));
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.deepOrange,
              title: Center(
                  child: Text(
                message,
                style: const TextStyle(
                    fontFamily: 'Roboto', fontWeight: FontWeight.w600),
              )));
        });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        //.com  backgroundColor: Color(0xffF5E6C2),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('assets/ems jacket.webp'),
                  fit: BoxFit.contain,
                  opacity: 0.98,
                )),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.2)),
                    child: const Column(
                      children: [
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
                  const SizedBox(height: 80),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.2)),
                    child: Column(
                      children: [
                        TextFormField(
                          // style: const TextStyle(color: Colors.black),
                          controller: _emailController,
                          decoration: InputDecoration(
                              //  label: const Text('Email',style: TextStyle(color: Colors.grey),),
                              hintText: 'Email',
                              // hintStyle: const TextStyle(color: Colors.grey),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.black54,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            } else if (!value.contains('@')) {
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          // style: const TextStyle(color: Colors.black),
                          controller: _passwordController,
                          obscureText: _isSecurePassword,
                          decoration: InputDecoration(
                              //   label: const Text('Password',style: TextStyle(color: Colors.grey),),
                              hintText: 'Password',
                              // hintStyle: const TextStyle(color: Colors.grey),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.black54,
                              suffixIcon: togglepassword(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
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
                                      builder: (context) =>
                                          const ForgotPassword()));
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            )),
                        const SizedBox(height: 20),
                        GestureDetector(
                            onTap: userLogin,
                            child: SvgPicture.asset('assets/login.svg')),
                        const SizedBox(height: 15),
                        const Divider(color: Colors.white),
                        /*const Text(
                          'OR',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),*/
                        const SizedBox(height: 15),
                        GestureDetector(
                            child:
                                SvgPicture.asset('assets/google_sign_up.svg'),
                            onTap: () =>
                                FirebaseServices.signInWithGoogle(context)),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const TrainerLogin()));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor:
                                  Colors.white, // Customize button color
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.login_rounded),
                                SizedBox(width: 3),
                                Text(
                                  "Trainer Login",
                                  style: TextStyle(
                                      letterSpacing: 0.6,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an Account?",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupPage()));
                              },
                              child: const Text(
                                'Signup',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
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

  Widget togglepassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }
}
