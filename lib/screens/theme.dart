import 'package:flutter/material.dart';
import 'package:simple_interest_calculator/screens/simple_interest.dart';


class Themes extends StatefulWidget {
  @override
  _ThemesState createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleInterest(),
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark,
      ),
    );
  }
}