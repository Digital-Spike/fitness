import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSinIn {
  signInWithGoogle() async {
    final GoogleSignInAccount? User = await GoogleSinIn().signInWithGoogle();

    final GoogleSignInAuthentication Auth = await User!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: Auth.accessToken,
      idToken: Auth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
