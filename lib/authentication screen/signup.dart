import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication%20screen/loginpage.dart';
import 'package:fitness/authentication%20screen/services.dart';
import 'package:fitness/authentication%20screen/termsandconditions.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isChecked = false;

  TextEditingController countryController = TextEditingController();
  @override
  void initState() {
    countryController.text = "+971";

    super.initState();
  }

  bool _isSecurePassword = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String userName = "Enter your name";
  String mobile = "Enter your mobile number";
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
                  'Join us for a healthier you',
                  style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffFF6600)),
                ),
                RichText(
                    text: const TextSpan(
                        text: 'Sign up for your ',
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontWeight: FontWeight.w500,
                          fontSize: 28,
                        ),
                        children: [
                      TextSpan(
                          text: 'fitness journey ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'today!')
                    ])),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    isDense: true,
                    floatingLabelStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 20,
                        color: Color(0xffB3BAC3)),
                    labelText: userName,
                    labelStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 16,
                        color: Color(0xffB3BAC3)),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter user name';
                    }
                    return null;
                  },
                  onTap: () {
                    setState(() {
                      userName = "Name";
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    prefix: RichText(
                        text: const TextSpan(
                            text: '+971',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffFF6600),
                                fontFamily: 'SpaceGrotesk'),
                            children: [
                          TextSpan(
                              text: '  |  ',
                              style: TextStyle(color: Color(0xffD9DDE1)))
                        ])),
                    isDense: true,
                    floatingLabelStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 20,
                        color: Color(0xffB3BAC3)),
                    labelText: mobile,
                    labelStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 16,
                        color: Color(0xffB3BAC3)),
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
                  onTap: () {
                    setState(() {
                      mobile = "Mobile Number";
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    isDense: true,
                    floatingLabelStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 20,
                        color: Color(0xffB3BAC3)),
                    labelText: emailString,
                    labelStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 16,
                        color: Color(0xffB3BAC3)),
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                  onTap: () {
                    setState(() {
                      emailString = "Email Address";
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isSecurePassword,
                  decoration: InputDecoration(
                    suffixIcon: togglePassword(),
                    isDense: true,
                    floatingLabelStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 20,
                        color: Color(0xffB3BAC3)),
                    labelText: password,
                    labelStyle: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 16,
                        color: Color(0xffB3BAC3)),
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Enter min. 6 characters'
                      : null,
                  onTap: () {
                    setState(() {
                      password = "password";
                    });
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox.adaptive(
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                      side: const BorderSide(color: Colors.white),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TermsAndConditions()));
                      },
                      child: const Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: signUp,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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

                        if (auth.currentUser?.uid ==
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen())))
                          ;
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
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: 'Do you have an account? ',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'SpaceGrotesk',
                                color: Color(0xffB3BAC3)),
                            children: [
                          TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffFF6600)))
                        ])),
                  ),
                )
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

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ),
            ));

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

      var url = Uri.parse('${ApiList.apiUrl}/addUser.php');
      Map<String, dynamic> userData = {
        'userId': userCredential.user?.uid,
        'name': _userNameController.text,
        'phoneNumber': countryController.text + _phoneController.text,
        'email': _emailController.text,
      };
      await http.post(url, body: userData);

      if (!mounted) {
        return;
      }

      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, a, b) => const MainScreen(),
          transitionDuration: const Duration(seconds: 0),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showErrorMessage(
          e.message ?? "Something went wrong!. Please try again later.");
    }
  }

  void showErrorMessage(String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Failed to Sign Up!',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text(
                    'Okay',
                    style: TextStyle(
                      color: Color(0xff0f4c81),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(appleProvider);
  }
}
