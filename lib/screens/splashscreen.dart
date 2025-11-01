import "package:flutter/material.dart";
import "dart:async";
import 'package:firebase_auth/firebase_auth.dart';
// import '../routes/app_routes.dart';
import 'auth/authpage.dart';
import 'homescreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error.toString()}');
              }
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data == null) {
                  return const AuthenticationPage();
                } else {
                  return const Homescreen();
                }
              }
              // End of Logic
              return Center(
                  child:
                      CircularProgressIndicator()); // You can return a loading indicator here
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/legal_icon.png',
              height: 100,
            ),
            const Align(
              alignment: Alignment(0.0, 0.88),
              child: Text(
                'LegallyWise',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Align(
              alignment: Alignment(0.0, 0.95),
              child: Text(
                'AI powered legal guidance system',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/* Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 220),
            // Logo image
            Image.asset(
              'assets/legal_icon.png', // Replace with your logo image path
              height: 100,
            ),
            const SizedBox(height: 120),
            const Text(
              'LegallyWise',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'AI powered legal guidance system',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      )

*/