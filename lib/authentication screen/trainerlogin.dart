import 'dart:convert';

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
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _trainerIdController,
                          decoration: InputDecoration(
                              hintText: 'Trainer Id',
                              isDense: true,
                              filled: true,
                              fillColor: Colors.black54,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Id';
                            }
                            return null;
                          },
                          onChanged: (String value) {},
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
                              suffixIcon: togglePassword(),
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
                        const SizedBox(height: 20),
                        GestureDetector(
                            onTap: () async {
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
                                          CircularProgressIndicator(),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.0),
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please enter valid Trainer Id and Password')));
                              }
                            },
                            child: SvgPicture.asset('assets/login.svg')),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget togglePassword() {
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
