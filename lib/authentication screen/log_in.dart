import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/authentication screen/google.dart';
import 'package:fitness/authentication screen/sign_in.dart';
import 'package:fitness/screens/home.dart';
import 'package:fitness/screens/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'forgetpassword.dart';
import 'package:http/http.dart' as http;

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
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        // Account doesn't exist, navigate to Signup
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, a, b) => Signup(),
            transitionDuration: Duration(seconds: 0),
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Color.fromRGBO(217, 217, 217, 0.25),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 40),
                      Text(
                        'Transform your body and mind',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
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
                  SizedBox(height: 40),
                  Container(
                    color: Color.fromRGBO(217, 217, 217, 0.25),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                autofocus: false,
                                decoration: InputDecoration(
                                  labelText: 'Email: ',
                                  labelStyle: TextStyle(fontSize: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorStyle: TextStyle(
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
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                autofocus: false,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password: ',
                                  labelStyle: TextStyle(fontSize: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  errorStyle: TextStyle(
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
                              margin: EdgeInsets.symmetric(vertical: 20.0),
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
                                  Text(
                                    "By Continuing you accept our\nprivacy policy and terms of use",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20.0),
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
                                  Text("Don't have an Account? "),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, a, b) =>
                                              Signup(),
                                          transitionDuration:
                                              Duration(seconds: 0),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: Text(
                                      'Signup',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    'assets/Apple.svg',
                                  ),
                                ),
                                SizedBox(width: 10),
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
                                                HomeScreen()));
                                  },
                                  child: SvgPicture.asset(
                                    'assets/google (3).svg',
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
                              child: Text(
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
