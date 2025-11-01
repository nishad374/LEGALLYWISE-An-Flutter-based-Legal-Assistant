import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legallywise/services/auth.dart';
import 'package:legallywise/widgets/square_tile.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool isLogin = true;
  bool _revealPassword = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void toggleFormMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void revealPassword() {
    setState(() {
      _revealPassword = !_revealPassword;
    });
  }

  Future<void> handleEmailSignIn() async {
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("User Registered Successfully"),
              backgroundColor: Color.fromRGBO(80, 139, 68, 1),
              duration: Duration(seconds: 5)));
          // Update the user's display name
          await userCredential.user!
              .updateDisplayName(nameController.text.trim());
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
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleGoogleSignIn() async {
    // Add Google sign-in logic here
  }

  Future<void> handleFacebookSignIn() async {
    // Add Facebook sign-in logic here
  }

  @override
  Widget build(BuildContext context) {
    final Authenticator authenticator = Authenticator(context: context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.yellow[600], fontSize: 18),
      ),
      backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? 'Login' : 'Registration',
              style: GoogleFonts.afacad(
                textStyle:
                    TextStyle(fontSize: 28, color: Colors.yellow.shade600),
              ),
            ),
            const SizedBox(height: 20),
            if (!isLogin)
              TextFormField(
                controller: nameController,
                style: const TextStyle(color: Colors.white70),
                cursorColor: Colors.yellow.shade700,
                cursorHeight: 18,
                cursorWidth: 0.8,
                decoration: const InputDecoration(
                    labelText: 'Name', border: OutlineInputBorder()),
              ),
            const SizedBox(height: 15),
            TextFormField(
              controller: emailController,
              style: const TextStyle(color: Colors.white70),
              cursorColor: Colors.yellow.shade700,
              cursorHeight: 18,
              cursorWidth: 0.8,
              decoration: const InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: passwordController,
              style: const TextStyle(color: Colors.white70),
              obscureText: _revealPassword,
              cursorColor: Colors.yellow.shade700,
              cursorHeight: 18,
              cursorWidth: 0.8,
              enableSuggestions: false,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: revealPassword,
                  icon: _revealPassword
                      ? const Icon(Icons.remove_red_eye)
                      : const Icon(Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: handleEmailSignIn,
              child: Text(isLogin ? 'Login' : 'Sign Up'),
            ),
            TextButton(
              onPressed: toggleFormMode,
              child: Text(
                isLogin
                    ? "Don't have an account? Sign up"
                    : "Already have an account? Login",
                style: TextStyle(color: Colors.yellow.shade700),
              ),
            ),
            const SizedBox(height: 20),
            const Row(children: <Widget>[
              Expanded(child: Divider()),
              Text(
                " Or Continue with ",
                style: TextStyle(color: Colors.white70),
              ),
              Expanded(child: Divider()),
            ]),
            // const Text('Or sign in with'),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(
                    onTap: authenticator.handleGoogleLogin,
                    color: Colors.white,
                    assets_path: "assets/socials/icons8-google.svg"),
                SizedBox(width: 50),
                SquareTile(
                    onTap: authenticator.handleFacebookLogin,
                    color: Colors.white,
                    assets_path: "assets/socials/icons8-fb.svg"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
