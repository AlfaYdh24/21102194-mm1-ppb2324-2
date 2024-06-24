import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tubes_sehatyuk/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDAA520), // Set background color to match the image
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/bg.png', // Make sure the image path is correct
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'City Safety',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Education Application',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
