import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Contacts help'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen();
              },
            ),
          ),
          body: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView(children: <Widget>[
                Text(
                    "If some of you are facing some problems with this app, we recommend you the following options: ",
                    textScaleFactor: 1.25),
                SizedBox(
                  height: 10.0,
                ),
                Text(" 1. Make sure that you have reset the current data before again using the interest calculator",
                    textScaleFactor: 1.25),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  " 2. For more advanced details, please visit ",
                  textScaleFactor: 1.25,
                ),
                GestureDetector(
                  child: Text(
                    "https://apps_jatin_yadav.ac.in",
                    textScaleFactor: 1.25,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                  onTap: () {
                    debugPrint('pressed');
                  },
                ),
                SizedBox(
                  height: 375,
                ),
                Center(
                    child: Text(
                  'from',
                  textScaleFactor: 1.0,
                )),
                Center(
                  child: Text(
                    'Jatin Yadav',
                    textScaleFactor: 1.75,
                  ),
                )
              ])),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
