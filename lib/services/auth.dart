import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Authenticator {
  final BuildContext context;
  Authenticator({required this.context});

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // Sign-in With Email method

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<void> handleEmailSignIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.message}"),
          backgroundColor: const Color.fromRGBO(185, 90, 90, 1),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  // Signup with Email Method
  Future<void> handleEmailSignUp(
      String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await userCredential.user!.updateDisplayName(name.trim());
      // Show SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Registered Successfully"),
          backgroundColor: Color.fromRGBO(80, 139, 68, 1),
          duration: Duration(seconds: 5),
        ),
      );

      // Update the user's display name
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.message}"),
          backgroundColor: const Color.fromRGBO(185, 90, 90, 1),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  // OAuth with Google
  Future<UserCredential> handleGoogleLogin() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? authUser = await googleUser?.authentication;

    AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: authUser?.idToken,
      accessToken: authUser?.accessToken,
    );

    return firebaseAuth.signInWithCredential(authCredential);
  }

  Future<UserCredential> handleFacebookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login();
    final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.tokenString);

    return firebaseAuth.signInWithCredential(credential);
  }

  Future<void> processSignOut() async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      user.providerData.forEach(
        (provider) async {
          if (provider.providerId == GoogleAuthProvider.PROVIDER_ID) {
            // User is authenticated with Google
            // Sign out using GoogleSignIn
            await GoogleSignIn().signOut();
          } else if (provider.providerId == FacebookAuthProvider.PROVIDER_ID) {
            // User is authenticated with Facebook
            // Sign out using FacebookAuth
            await FacebookAuth.instance.logOut();
          }
        },
      );
    }
    await firebaseAuth.signOut();
  }
  // End of Class
}
