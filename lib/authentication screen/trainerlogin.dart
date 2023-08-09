import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/constants/trainer_api.dart';
import 'package:fitness/traineraccount/trainerhome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

import 'forgetpassword.dart';
class TrainerLogin extends StatefulWidget {
  const TrainerLogin({super.key});

  @override
  State<TrainerLogin> createState() => _TrainerLoginState();
}

class _TrainerLoginState extends State<TrainerLogin> {

  bool _isSecurePassword = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  trainerLogin() async {
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
      String trainerId = FirebaseAuth.instance.currentUser?.uid ?? '';

      // Make an API call and pass the user ID
      final response = await http.post(
        Uri.parse('https://fitnessjourni.com/trainers/trainerLogin.php'),
        body: {'trainerId': trainerId},
      );

      if (response.statusCode == 200) {
        TrainerApiList.trainer = jsonDecode(response.body);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TrainerHome(),
          ),
        );
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TrainerLogin()));
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
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('assets/ems jacket.webp'),
                  fit: BoxFit.cover,
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
                          style: const TextStyle(color: Colors.black),
                          controller: _emailController,
                          decoration: InputDecoration(
                            //  label: const Text('Email',style: TextStyle(color: Colors.grey),),
                              hintText: 'Email',
                              hintStyle: const TextStyle(color: Colors.grey),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
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
                          style: const TextStyle(color: Colors.black),
                          controller: _passwordController,
                          obscureText: _isSecurePassword,
                          decoration: InputDecoration(
                          //   label: const Text('Password',style: TextStyle(color: Colors.grey),),
                             hintText: 'Password',
                             hintStyle: const TextStyle(color: Colors.grey),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.white,
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPassword()));
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
                            onTap: trainerLogin,
                            child: SvgPicture.asset('assets/login.svg')),
                        const SizedBox(height: 20),
                        // const Text(
                        //   'OR',
                        //   style: TextStyle(
                        //       fontFamily: 'Roboto',
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.white),
                        // ),
                        // const SizedBox(height: 20),
                      //  GestureDetector(
                      //   onTap: (){},
                      //    child: SvgPicture.asset('assets/Google.1.svg',height: 40,),
                      //  ),
                        /*const SizedBox(width: 20),
                            SvgPicture.asset('assets/Apple.svg'),*/ /*
                          ],
                        ),*/
                       
                        const SizedBox(height: 20),
                      
                ]),
                  ),
                ],
              ),
            ),
          ),
        )
    );
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
