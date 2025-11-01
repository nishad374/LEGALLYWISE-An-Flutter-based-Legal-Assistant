import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import '../routes/app_routes.dart';
import '../services/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Authenticator authenticator = Authenticator(context: context);
    final User? user = authenticator.getCurrentUser();

    return Drawer(
      backgroundColor: const Color.fromRGBO(41, 41, 41, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black54),
                currentAccountPicture: CircleAvatar(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
                accountName: Text(user?.displayName ?? "Guest User"),
                accountEmail: Text(user?.email ?? "guest.abc@gmail.com"),
              ),
              InkWell(
                child: ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.yellow,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.homeScreen);
                  },
                ),
              ),
              InkWell(
                child: ListTile(
                  leading: const Icon(Icons.notes, color: Colors.yellow),
                  title: const Text(
                    "Explore Laws",
                    style: TextStyle(color: Colors.white70),
                  ),
                  onTap: () => Navigator.pushReplacementNamed(
                      context, AppRoutes.exploreLaws),
                ),
              ),
              InkWell(
                child: ListTile(
                    leading: const Icon(Icons.person_2, color: Colors.yellow),
                    title: const Text(
                      "Hire Lawyers",
                      style: TextStyle(color: Colors.white70),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.hireLawyers);
                    }),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: authenticator.processSignOut,
              textColor: Colors.white70,
              iconColor: Colors.yellow,
            ),
          )
        ],
      ),
    );
  }
}
