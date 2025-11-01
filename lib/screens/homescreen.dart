import 'package:flutter/material.dart';
import "../widgets/app_drawer.dart";
import 'package:legallywise/screens/chat_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool _isChatScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow[600],
      ),
      backgroundColor: Colors.black,
      drawer: const AppDrawer(),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isChatScreen = true;
          });
        },
        child: _isChatScreen
            ? Hero(
                tag: "tag-1",
                child: ChatScreen(),
              )
            : Hero(
                tag: "tag-1",
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Chat with your ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                text: 'AI-Powered',
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' Lawyer',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: const Text(
                          "Press any where to continue",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
