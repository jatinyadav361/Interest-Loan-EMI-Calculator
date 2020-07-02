import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:simple_interest_calculator/intermediate/interMonthly2.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/services/firestore.dart';
import 'package:simple_interest_calculator/shared/loading.dart';

class MonthlyInterest extends StatefulWidget {
  @override
  _MonthlyInterestState createState() => _MonthlyInterestState();
}

class _MonthlyInterestState extends State<MonthlyInterest> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var _currentItemSelected = 'Rupees';

  bool loading = false;

  TextEditingController principalControlled = TextEditingController();

  TextEditingController roiControlled = TextEditingController();

  TextEditingController monthControlled = TextEditingController();
  TextEditingController daysControlled = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    var size = MediaQuery.of(context).size;

    final historyListMonthly = Provider.of<List<UserData>>(context);

    return Scaffold(
        appBar: AppBar(
          title: Wrap(direction: Axis.vertical, children: <Widget>[
            Text(
              'Monthly Interest Calculator',
              textScaleFactor: size.width*0.00255,
            )
          ]),
          actions: [
            IconButton(
              icon: Icon(Icons.history,color: Colors.white,),
              tooltip: 'History',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return InterMediateMonthlyHistory2();
                  }
                ));
              },
            )
          ],
        ),
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      style: textStyle,
                      controller: principalControlled,
                      keyboardType: TextInputType.number,
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Please enter principal value'
                            : null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter Principal',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(fontSize: 15.0),
                          hintText: 'Enter Principal e.g. 12000',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Row(children: <Widget>[
                    SizedBox(width: 10.0),
                    Text(
                      'Rate of Interest :',
                      textScaleFactor: 1.66,
                      style: TextStyle(color: Colors.green),
                    ),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 5.0),
                            child: Text(
                              'Monthly',
                              textScaleFactor: 1.66,
                              style: TextStyle(color: Colors.green),
                            ))),
                  ]),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiControlled,
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Please enter rate of interest'
                            : null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter Rate of Interest(Monthly)',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(fontSize: 15.0),
                          hintText: 'Enter Rate in percent e.g. 15',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Currency :',
                          textScaleFactor: 1.6,
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                            padding: EdgeInsets.only(right: 50.0),
                            child: DropdownButton<String>(
                              items: _currencies.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _currentItemSelected,
                              onChanged: (String newValueSelected) {
                                _onDropDownItemSelected(newValueSelected);
                              },
                            )),
                      ),
                      SizedBox(width: 10.0),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Time period:',
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.green),
                            ),
                          )),
                      Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: textStyle,
                              controller: monthControlled,
                              validator: (String value) {
                                return value.isEmpty
                                    ? 'Please enter\nno. of months'
                                    : null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Months',
                                  labelStyle: textStyle,
                                  errorStyle: TextStyle(fontSize: 12.0),
                                  hintText: 'Enter Months',
                                  hintStyle: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: textStyle,
                              controller: daysControlled,
                              validator: (String value) {
                                return value.isEmpty
                                    ? 'Please \nenter no.\nof days'
                                    : null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Days',
                                  labelStyle: textStyle,
                                  hintText: 'Enter days',
                                  errorStyle: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0))),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10.0),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                            onPressed: () async{
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  String time = (double.parse(monthControlled.text)+(roundOff(double.parse(daysControlled.text)/30))).toString();
                                  var result = await FireStoreService().updateMonthlyInterestHistory('${historyListMonthly.length}', principalControlled.text, roiControlled.text,time,_calculateTotalInterest());
                                  if (result == null) {
                                    loading = false;
                                  } else {
                                    loading = false;
                                  }
                                  setState(() {
                                    displayResult = _calculateTotalReturns();
                                  });
                                } else
                                  displayResult = '';
                            },
                            child: Text(
                              'Calculate',
                              style: textStyle,
                            )),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              resetdata();
                            });
                          },
                          child: Text(
                            'Reset',
                            style: textStyle,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      displayResult,
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ),

            Positioned(
              child: loading ? Loading(): Container(),
            )
          ],
        ));
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiControlled.text);
    double month = double.parse(monthControlled.text);
    double day = double.parse(daysControlled.text);

    double term = month + day / 30;
    double interest = (principal * term * roi) / 100;
    interest = roundOff(interest);

    double totalReturns = principal + (principal * term * roi) / 100;
    totalReturns = roundOff(totalReturns);
    String result;
    if (day > 1) {
      result =
          'After $month months and $day days ,\n\nTotal Interest is : $interest $_currentItemSelected\n\nTotal amount is : $totalReturns $_currentItemSelected';
    }
    if (day == 1) {
      result =
          'After $month months and $day day ,\n\nTotal Interest is : $interest $_currentItemSelected\n\nTotal amount is : $totalReturns $_currentItemSelected';
    }
    if (day == 0) {
      result =
          'After $month months ,\n\nTotal Interest is : $interest $_currentItemSelected\n\nTotal amount is : $totalReturns $_currentItemSelected';
    }
    if (month <= 1) {
      result =
          'After $month month ,\n\nTotal Interest is : $interest $_currentItemSelected\n\nTotal amount is : $totalReturns $_currentItemSelected';
    }
    return result;
  }

  String _calculateTotalInterest() {
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiControlled.text);
    double month = double.parse(monthControlled.text);
    double day = double.parse(daysControlled.text);

    double term = month + day / 30;
    double interest = (principal * term * roi) / 100;
    interest = roundOff(interest);

    return '$interest';
  }

  void resetdata() {
    principalControlled.text = '';
    roiControlled.text = '';
    monthControlled.text = '';
    daysControlled.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }

  double roundOff(double num) {
    int decimals = 2;
    int fac = pow(10, decimals);
    num = (num * fac).round() / fac;
    return num;
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}
