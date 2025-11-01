import "package:flutter/material.dart";
import "../screens/splashscreen.dart";
import "../screens/homescreen.dart";
import "../screens/explore_laws.dart";
import "../screens/lawyerscreen.dart";
import "../screens/auth/authpage.dart";

class AppRoutes {
  static const String initialRoute = '/';
  static const String splashScreen = '/splash-screen';
  static const String homeScreen = '/home-screen';
  static const String exploreLaws = '/explore-laws';
  static const String hireLawyers = '/hire-lawyers';
  static const String authPage = '/auth-page';

  static Map<String, WidgetBuilder> routes = {
    // initialRoute: (context) => const Splashscreen(),
    splashScreen: (context) => const Splashscreen(),
    homeScreen: (context) => const Homescreen(),
    exploreLaws: (context) => const ExploreLaws(),
    hireLawyers: (context) => const LawyerListScreen(),
    authPage: (context) => const AuthenticationPage(),
  };
}
