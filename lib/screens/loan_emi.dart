import 'package:flutter/material.dart';
import 'package:simple_interest_calculator/intermediate/interEMI.dart';
import 'package:simple_interest_calculator/models/emi.dart';
import 'package:simple_interest_calculator/screens/compare_loan.dart';
import 'package:simple_interest_calculator/screens/emi_calculator.dart';

class LoanEMI extends StatefulWidget {
  @override
  _LoanEMIState createState() => _LoanEMIState();
}

class _LoanEMIState extends State<LoanEMI> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan and EMI calculator'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: ListTile(
              leading: Image(image: AssetImage('assets/IMG_20200401_120443.jpg'),),
              title: Text('Loan Comparision',textScaleFactor: 1.75,),
              subtitle: Text('Click to compare Loans'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoanCompare();
                }));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: ListTile(
              leading:Container( width: 45.0,
                child: Image(image: AssetImage('assets/Screenshot_2020-04-01-12-16-44-46.jpg'),),),
              title: Text(
                'EMI calculator',
                textScaleFactor: 1.75,
              ),
              subtitle: Text('Click to calculate monthly EMI'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InterMediateEMIHistory();
                }));
              },
            ),
          )
        ],
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }


}
