import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../drawerscreen/password.dart';
import '../screens/mainScreen.dart';
import 'forgetpassword.dart';
import 'google.dart';
import 'sign_in.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? errorMessage;
  final _name = TextEditingController();
  final _password = TextEditingController();
  List? data;
  String? msgs, branch, securityKey;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      // User is already logged in, navigate to home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  Future<dynamic> loginactivity() async {
    String apiurl = "https://fitnessjourni.com/api/getUser.php";
    var response = await http.post(Uri.parse(apiurl),
        body: {'name': _name.text, 'password': _password.text});

    void teststatus() async {
      var jsondata = json.decode(response.body);
      msgs = jsondata["name"];
      branch = jsondata["branch"];
      securityKey = jsondata["securityKey"];
      final prefs = await SharedPreferences.getInstance();

      if (response.statusCode == 200 && msgs != "") {
        await prefs.setString('name', msgs.toString());
        await prefs.setString('branch', branch.toString());
        await prefs.setString('securityKey', securityKey.toString());
        await prefs.setString('login_status', "yes");
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      } else {
        const snackdemo = SnackBar(
          content: Text('Wrong credentials'),
          backgroundColor: Color.fromRGBO(24, 164, 132, 1),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      }
    }

    teststatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    autofocus: false,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    autofocus: false,
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        signIn(emailController.text, passwordController.text);
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blue,
                    elevation: 5,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => forgetpassword(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: signInWithGoogle,
                    icon: Icon(Icons.g_mobiledata),
                    label: Text('Sign in with Google'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        // User login successful, navigate to home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "No user found for that email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Wrong password provided for that user.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Login failed. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Login failed. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        // User login successful, navigate to home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Login failed. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
