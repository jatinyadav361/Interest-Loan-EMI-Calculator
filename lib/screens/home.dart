

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:simple_interest_calculator/intermediate/interCompound.dart';
import 'package:simple_interest_calculator/intermediate/interEMI.dart';
import 'package:simple_interest_calculator/intermediate/interMonthly.dart';
import 'package:simple_interest_calculator/intermediate/inter_simple.dart';
import 'package:simple_interest_calculator/models/emi.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/screens/compare_loan.dart';
import 'package:simple_interest_calculator/screens/compound_interest.dart';
import 'package:simple_interest_calculator/screens/emi_calculator.dart';
import 'package:simple_interest_calculator/screens/loan_emi.dart';
import 'package:simple_interest_calculator/screens/monthly_interest.dart';
import 'package:simple_interest_calculator/screens/simple_interest.dart';
import 'package:simple_interest_calculator/screens/help.dart';
import 'package:simple_interest_calculator/screens/theme_dynamic.dart';
import 'package:simple_interest_calculator/services/firestore.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = 'Jatin';
  String subject = 'Yadav';

  choiceAction(String choice) {
    if (choice == Constants.SecondItem) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Help();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage(
                          'assets/Screenshot_2020-03-31-09-01-22-25.jpg'),
                    ),
                    Image(
                      image: AssetImage('assets/IMG_20200401_120443.jpg'),
                    ),
                  ],
                )), // DrawerHeader(),
            Padding(
                padding: EdgeInsets.only(left:0,right: 50.0),
                child: Column(
                  children: <Widget>[
                    Consumer<ThemeNotifier>(
                      builder: (context,notifier,child)=>SwitchListTile(
                        title: Text('Dark theme'),
                        onChanged: (val){
                          notifier.toggleTheme();
                          Navigator.of(context).pop();
                        },
                        value: notifier.darkTheme,
                      ),
                    ),
                  ],
                )),
            ListTile(
              title: Text('Compound Interest Calculator'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InterMediateCompoundHistory();
                }));
              },
            ),
            ListTile(
              title: Text('Monthly Interest Calculator'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InterMediateMonthlyHistory();
                }));
              },
            ),
            ListTile(
              title: Text('Monthly EMI Calculator'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InterMediateEMIHistory();
                }));
              },
            ),
            ListTile(
              title: Text('Loan Comparision'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoanCompare();
                }));
              },
            ),

          ],
        ),

      ),
      appBar: AppBar(
        title: Wrap(direction: Axis.vertical,spacing: 2, children: <Widget>[
          Text(
            'Interest & Loan Calculator',
            textScaleFactor: .97,
            softWrap: true,
            overflow: TextOverflow.fade,
          )
        ]),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: action(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Where would you like to go?',
                textScaleFactor: 1.5,
              )),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Image(
                image:
                AssetImage('assets/Screenshot_2020-03-31-09-01-22-25.jpg'),
              ),
              title: FlatButton(
                child: Text('Simple Interest Calculator',
                    textScaleFactor: 1.0, style: textStyle),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return IntermediateSimpleInterest();
                }));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Image(
                image:
                AssetImage('assets/Screenshot_2020-04-01-18-01-17-61.jpg'),
              ),
              title: FlatButton(
                child: Text('Monthly Simple Interest Calculator',
                    textScaleFactor: 1.0, style: textStyle),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InterMediateMonthlyHistory();
                }));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Container(width: 70,
                  child: Image(
                    image:
                    AssetImage('assets/Screenshot_2020-04-01-17-57-39-52.jpg'),
                  )),
              title: FlatButton(
                child: Text(
                  'Compound Interest Calculator',
                  textScaleFactor: 1.0,
                  style: textStyle,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InterMediateCompoundHistory();
                }));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Container(
                  width: 70.0,
                  child: Image(
                    image:
                    AssetImage('assets/Screenshot_2020-04-01-12-16-44-46.jpg'),
                  )),
              title: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.only(right: 60.0),
                    child: Column(children: <Widget>[
                      Text(
                        'Loan EMI',textScaleFactor: 0.9,
                        style: textStyle,
                      ),
                      Text(
                        'Calculator',textScaleFactor: 0.95,
                        style: textStyle,
                      )
                    ]),
                  )),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoanEMI();
                }));
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget action(choice) {
    if (choice == 'Help')
      return ListTile(
        leading: Icon(Icons.help_outline),
        title: Text(choice),
      );
    if (choice == 'Share with friends')
      return ListTile(
        leading: Icon(Icons.share),
        title: Text('Share with friends'),
        onTap: text.isEmpty
            ? null
            : () {
          final RenderBox box = context.findRenderObject();
          Share.share('https://drive.google.com/drive/folders/1WoxOSlgqbbqytgLeP8Q-Qj0lFd24lTK9?usp=sharing',
              subject: 'Interest and EMI Calculator App',
              sharePositionOrigin:
              box.localToGlobal(Offset.zero) & box.size);

          Navigator.pop(context);

        },
      );
    if (choice == 'Rate this app')
      return ListTile(
        leading: Icon(Icons.rate_review),
        title: Text(
          choice,
          style: TextStyle(color: Colors.red),
        ),
      );
  }

}

class Constants {
  static const String SecondItem = 'Help';
  static const String ThirdItem = 'Share with friends';
  static const String FourthItem = 'Rate this app';

  static const List<String> choices = <String>[
    SecondItem,
    ThirdItem,
    FourthItem,
  ];
}
