import 'package:flutter/material.dart';
import 'dart:async';
import 'package:simple_interest_calculator/screens/simple_interest.dart';
import 'package:simple_interest_calculator/screens/splash_2.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => SplashScreens())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
//        height: 1000.0,
//        width: 100.0,
//        color: Colors.grey,
        child: Center(
                child: Image(
          image: AssetImage('assets/Screenshot_2020-03-31-09-01-22-25.jpg'),

        )),
      )),
    );
  }
}
