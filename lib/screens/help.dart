import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {

  String url = 'https://drive.google.com/drive/folders/1WoxOSlgqbbqytgLeP8Q-Qj0lFd24lTK9?usp=sharing';

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

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
                  " 2. For more advanced details, please reinstall or update the app at: ",
                  textScaleFactor: 1.25,
                ),
                InkWell(
                  child: Text(
                    url,
                    textScaleFactor: 1.25,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                  onTap: () async{
                   try {
                     if(await canLaunch(url)) {
                       await launch(url,universalLinksOnly: true, forceSafariVC: false);
                     }
                   } catch(e) {
                     print('$e');
                     Fluttertoast.showToast(msg: '$e');
                   }
                  },
                ),
                SizedBox(
                  height: size.height*0.38,
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
