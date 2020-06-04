import 'package:flutter/material.dart';
import 'dart:async';

import 'package:simple_interest_calculator/screens/home.dart';

class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
            () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Home())));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child:Container(
//        height: 100.0,
//        width: 100.0,
//        color: Colors.grey,

            child: Image(
              image: AssetImage('assets/Screenshot_2020-03-31-09-08-22-11.jpg'),
            )),
      ),
    );
  }
}
