// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                'Password reset link sent! Check your email',
                textAlign: TextAlign.center,
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                e.message.toString(),
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  String emailString = "Enter your email address";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Forgot Password?',
                style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffFF6600)),
              ),
              const Text('Please enter your email to reset your password.',
                  style: TextStyle(
                    fontSize: 28,
                  )),
              const SizedBox(height: 15),
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
                  isDense: true,
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
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: passwordReset,
                child: const Text(
                  'Get Link',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'SpaceGrotesk',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
