import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication screen/sign_in.dart';
import 'package:fitness/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'forgetpassword.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  bool isChecked = false; // For the checkbox

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // Get the user ID after successful login
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      // Make an API call and pass the user ID
      final response = await http.post(
        Uri.parse('https://fitnessjourni.com/api/getUser.php'),
        body: {'userId': userId},
      );

      if (response.statusCode == 200) {
        // Account exists, navigate to MainScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        // Account doesn't exist, navigate to Signup
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, a, b) => Signup(),
            transitionDuration: const Duration(seconds: 0),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: const Color.fromRGBO(217, 217, 217, 0.25),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Transform your body and mind',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'with the ultimate EMS fitness journey app for anyone who wants to take control of their health and fitness',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    color: const Color.fromRGBO(217, 217, 217, 0.25),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                autofocus: false,
                                decoration: InputDecoration(
                                  labelText: 'Email: ',
                                  labelStyle: const TextStyle(fontSize: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorStyle: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 15,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Email';
                                  } else if (!value.contains('@')) {
                                    return 'Please Enter Valid Email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                autofocus: false,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password: ',
                                  labelStyle: const TextStyle(fontSize: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  errorStyle: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 15,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value ?? false;
                                      });
                                    },
                                  ),
                                  const Text(
                                    "By Continuing you accept our\nprivacy policy and terms of use",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: userLogin,
                                    child: SvgPicture.asset(
                                      'assets/Logintab.svg',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an Account? "),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, a, b) =>
                                              Signup(),
                                          transitionDuration:
                                              const Duration(seconds: 0),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text(
                                      'Signup',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    'assets/Apple.svg',
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () async {
                                    try {
                                      final GoogleSignInAccount?
                                          googleSignInAccount =
                                          await _googleSignIn.signIn();
                                      final GoogleSignInAuthentication
                                          googleSignInAuthentication =
                                          await googleSignInAccount!
                                              .authentication;
                                      final AuthCredential credential =
                                          GoogleAuthProvider.credential(
                                        accessToken: googleSignInAuthentication
                                            .accessToken,
                                        idToken:
                                            googleSignInAuthentication.idToken,
                                      );
                                      await _auth
                                          .signInWithCredential(credential);
                                    } on FirebaseAuthException catch (e) {
                                      print(e.message);
                                      throw e;
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()));
                                  },
                                  child: SvgPicture.asset(
                                    'assets/google.svg',
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPassword(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot Password ?',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
