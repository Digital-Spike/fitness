import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Google extends StatefulWidget {
  @override
  _GoogleState createState() => _GoogleState();
}

class _GoogleState extends State<Google> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final GoogleSignInAccount? googleSignInAccount =
                      await _googleSignIn.signIn();
                  final GoogleSignInAuthentication googleSignInAuthentication =
                      await googleSignInAccount!.authentication;
                  final AuthCredential credential =
                      GoogleAuthProvider.credential(
                    accessToken: googleSignInAuthentication.accessToken,
                    idToken: googleSignInAuthentication.idToken,
                  );
                  await _auth.signInWithCredential(credential);

                  // Get the user display name
                  final user = _auth.currentUser;
                  final userName = user?.displayName ?? 'User';

                  // Display success message
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Sign In Successful'),
                        content: Text('User $userName signed in successfully!'),
                      );
                    },
                  );

                  // Navigate to the MainScreen after a short delay
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  });
                } on FirebaseAuthException catch (e) {
                  print(e.message);
                  throw e;
                }
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
