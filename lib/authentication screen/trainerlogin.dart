import 'dart:convert';

import 'package:fitness/authentication%20screen/loginpage.dart';
import 'package:fitness/trainer_section/trainer_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TrainerLogin extends StatefulWidget {
  const TrainerLogin({super.key});

  @override
  State<TrainerLogin> createState() => _TrainerLoginState();
}

class _TrainerLoginState extends State<TrainerLogin> {
  bool _isSecurePassword = true;

  final formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _trainerIdController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? trainerId;
  @override
  void dispose() {
    _passwordController.dispose();
    _trainerIdController.dispose();
    super.dispose();
  }

  String emailString = "Enter your username";
  String password = "Enter your password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
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
                  controller: _trainerIdController,
                  decoration: InputDecoration(
                    floatingLabelStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 18,
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
                      emailString = "User Name";
                    });
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Id';
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
                          fontSize: 18,
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
                const SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56)),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Dialog(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        'Processing...',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      await trainerLogin();
                      if (!mounted) {
                        return;
                      }
                      if (trainerId != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const TrainerHome()),
                        );
                      } else {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Please enter valid Trainer Id and Password')));
                      }
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )),
                const Spacer(),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 46)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      'Login as a Trainee',
                      style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
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
          ? const Icon(
              Icons.visibility,
            )
          : const Icon(Icons.visibility_off),
      color: Colors.white,
    );
  }

  Future<void> trainerLogin() async {
    if (formKey.currentState!.validate()) {
      try {
        final SharedPreferences prefs = await _prefs;
        var url =
            Uri.parse('https://fitnessjourni.com/trainers/trainerLogin.php');
        Map<String, dynamic> trainerData = {
          'trainerId': _trainerIdController.text,
          'password': _passwordController.text,
        };
        http.Response? response = await http.post(url, body: trainerData);
        await prefs.setString(
            'trainerId', json.decode(response.body)['trainerId']);
        trainerId = json.decode(response.body)['trainerId'];
      } catch (e) {}
    }
  }
}
