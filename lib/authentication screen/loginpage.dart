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
import 'package:icons_plus/icons_plus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSecurePassword = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
   String _errorMessage = "";

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
    } catch (error) {
      setState(() {
        if (error is FirebaseAuthException) {
          // Customize error messages based on different error codes
          if (error.code == 'user-not-found') {
            _errorMessage = 'No user found with this email.';
          } else if (error.code == 'wrong-password') {
            _errorMessage = 'Invalid password.Please enter a valid password';
          } else {
            _errorMessage = 'An error occurred. Please try again later.';
          }
        } else {
          _errorMessage = 'An error occurred. Please try again later.';
        }});
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
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.black.withOpacity(0.2)),
                  child: Image.asset('assets/FJ FONT.png'),
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
                      SizedBox(width: MediaQuery.of(context).size.width * 0.58,
                            child: ElevatedButton(onPressed: () {
                              FirebaseServices.signInWithGoogle(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Logo(Logos.google,size: 25,),SizedBox(width: 3),Text('Sign In with Google',style: TextStyle(
                                      letterSpacing: 0.6,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold))
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor:
                                  Colors.white, // Customize button color
                              padding: const EdgeInsets.all(7),
                            ),
                            ),
                            
                            ),
                                // SvgPicture.asset('assets/google_sign_up.svg'),
                           
                        const SizedBox(height: 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.58,
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
                              padding: const EdgeInsets.all(7),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 3),
                                Text(
                                  "Trainer Login",
                                  style: TextStyle(
                                      letterSpacing: 0.6,
                                      fontSize: 13,
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
