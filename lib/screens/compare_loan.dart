import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LoanCompare extends StatefulWidget {
  @override
  _LoanCompareState createState() => _LoanCompareState();
}

class _LoanCompareState extends State<LoanCompare> {

  var _formKey = GlobalKey<FormState>();

  TextEditingController principal1Controlled = TextEditingController();
  TextEditingController principal2Controlled = TextEditingController();

  TextEditingController roi1Controlled = TextEditingController();
  TextEditingController roi2Controlled = TextEditingController();

  TextEditingController term1Controlled = TextEditingController();
  TextEditingController term2Controlled = TextEditingController();

  var displayEMI1 = '';
  var EMIdiff1 = '';
  var Paymentdiff1 = '';
  var Interestdiff1 = '';
  var EMIdiff2 = '';
  var Paymentdiff2 = '';
  var Interestdiff2 = '';
  var displayEMI2 = '';
  var displayPayment2 = '';
  var displayPayment1 = '';
  var displayInterest2 = '';
  var displayInterest1 = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Loan Comparison'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: Form( key: _formKey,
              child:ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 40.0),
                      child: Text(
                        'LOAN 1',
                        textScaleFactor: 1.8,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 40.0),
                      child: Text(
                        'LOAN 2',
                        textScaleFactor: 1.8,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      style: textStyle,
                      controller: principal1Controlled,
                      keyboardType: TextInputType.number,
                      validator: (String value){
                        if(value.isEmpty) {
                          return 'Please enter loan\namount'; }
                      },
                      decoration: InputDecoration(
                          labelText: 'Loan Amount',
                          errorStyle: TextStyle(fontSize: 13.0),
                          labelStyle:
                              textStyle,
                          hintText: '',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      style: textStyle,
                      controller: principal2Controlled,
                      keyboardType: TextInputType.number,
                      validator: (String value){
                        if(value.isEmpty ) {
                          return 'Please enter loan\namount'; }

                      },
                      decoration: InputDecoration(
                          labelText: 'Loan Amount',
                          errorStyle: TextStyle(fontSize: 13.0),
                          labelStyle:
                              textStyle,
                          hintText: '',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      style: textStyle,
                      controller: roi1Controlled,
                      keyboardType: TextInputType.number,
                      validator: (String value){
                        if(value.isEmpty || value=='0') {
                          return 'Please enter a valid\nrate of interest'; }
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate%(yearly)',
                          errorStyle: TextStyle(fontSize: 13.0),
                          labelStyle:
                              textStyle,
                          hintText: '',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      style: textStyle,
                      controller: roi2Controlled,
                      keyboardType: TextInputType.number,
                      validator: (String value){
                        if(value.isEmpty|| value=='0') {
                          return 'Please enter a valid\nrate of interest'; }
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate%(yearly)',
                          errorStyle: TextStyle(fontSize: 13.0),
                          labelStyle:
                              textStyle,
                          hintText: '',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      style: textStyle,
                      controller: term1Controlled,
                      keyboardType: TextInputType.number,
                      validator: (String value){
                        if(value.isEmpty|| value=='0') {
                          return 'Please enter valid\nloan term'; }

                      },
                      decoration: InputDecoration(
                          labelText: 'Term(months',
                          errorStyle: TextStyle(fontSize: 13.0),
                          labelStyle:
                             textStyle,
                          hintText: '',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      style: textStyle,
                      controller: term2Controlled,
                      keyboardType: TextInputType.number,
                      validator: (String value){
                        if(value.isEmpty|| value=='0') {
                          return 'Please enter valid\nloan term'; }
                      },
                      decoration: InputDecoration(
                          labelText: 'Term(months',
                          errorStyle: TextStyle(fontSize: 13.0),
                          labelStyle:
                              textStyle,
                          hintText: '',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                SizedBox(width: 10.0),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState.validate()) {
                          _calculateTotalReturns(); }
                          else {
                            displayEMI1 = '';
                            displayEMI2 = '';
                            displayInterest1 = '';
                            displayInterest2 = '';
                            displayPayment1 = '';
                            displayPayment2 = '';
                            Paymentdiff1 = '';
                            Paymentdiff2 = '';
                            EMIdiff1 = '';
                            EMIdiff2 = '';
                            Interestdiff1 = '';
                            Interestdiff2 = '';
                          }
                        });
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
            SizedBox(height: 35.0),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Row(children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'EMI',
                    )
                  ]),
                  Column(
                    children: <Widget>[
                      Text(displayEMI1),
                      Text(EMIdiff1,style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(displayEMI2),
                      Text(EMIdiff2,style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ]),
                TableRow(children: [
                  Row(children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Total Interest',
                    )
                  ]),
                  Column(
                    children: <Widget>[
                      Text(displayInterest1),
                    Text(Interestdiff1,style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(displayInterest2),
                      Text(Interestdiff2,style: TextStyle(color: Colors.red)),
                    ],
                  )
                ]),
                TableRow(children: [
                  Row(children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Total Payment',
                    )
                  ]),
                  Column(
                    children: <Widget>[
                      Text(displayPayment1),
                      Text(Paymentdiff1,style: TextStyle(color: Colors.red),),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(displayPayment2),
                      Text(Paymentdiff2,style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ])
              ],
            ),
          ],
        ),
      ),
    ));
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }

  void _calculateTotalReturns() {
    double principal1 = double.parse(principal1Controlled.text);
    double roi1 = double.parse(roi1Controlled.text);
    double term1 = double.parse(term1Controlled.text);
    double principal2 = double.parse(principal2Controlled.text);
    double roi2 = double.parse(roi2Controlled.text);
    double term2 = double.parse(term2Controlled.text);

    double x = 1;
    for (int i = 0; i < term1; i++) {
      x = x * (1 + roi1 / 1200);
    }
    double monthlyEMI1 = (principal1 * roi1 * (x) / (1200 * (x - 1)));
    monthlyEMI1 = roundOff(monthlyEMI1);
    double interest1 = monthlyEMI1 * term1 - principal1;
    interest1 = roundOff(interest1);
    double totalAmount1 = principal1 + interest1;
    totalAmount1 = roundOff(totalAmount1);
    displayInterest1 = '$interest1';
    displayPayment1 = '$totalAmount1';
    displayEMI1 = '$monthlyEMI1';

    double y = 1;
    for (int i = 0; i < term2; i++) {
      y = y * (1 + roi2 / 1200);
    }
    double monthlyEMI2 = (principal2 * roi2 * (y) / (1200 * (y - 1)));
    monthlyEMI2 = roundOff(monthlyEMI2);
    double interest2 = monthlyEMI2 * term2 - principal2;
    interest2 = roundOff(interest2);
    double totalAmount2 = principal2 + interest2;
    totalAmount2 = roundOff(totalAmount2);
    displayInterest2 = '$interest2';
    displayPayment2 = '$totalAmount2';
    displayEMI2 = '$monthlyEMI2';

    double EMIdiffer2 = monthlyEMI2 - monthlyEMI1;
    double EMIdiffer1 = monthlyEMI1 - monthlyEMI2;
    EMIdiffer1=roundOff(EMIdiffer1);
    EMIdiffer2=roundOff(EMIdiffer2);
    if (monthlyEMI1 < monthlyEMI2) {EMIdiff1 = '$EMIdiffer1';EMIdiff2='';}
    else  {EMIdiff2 = '$EMIdiffer2'; EMIdiff1='';}

    double Paymentdiffer2 = totalAmount2 - totalAmount1;
    double Paymentdiffer1 = totalAmount1 - totalAmount2;
    Paymentdiffer1=roundOff(Paymentdiffer1);
    Paymentdiffer2=roundOff(Paymentdiffer2);
    if (monthlyEMI1 < monthlyEMI2) {Paymentdiff1 = '$Paymentdiffer1';Paymentdiff2='';}
    else  {Paymentdiff2 = '$Paymentdiffer2';Paymentdiff1='';}

    double Interestdiffer2 = interest2 - interest1;
    double Interestdiffer1 = interest1 - interest2;
    Interestdiffer1 = roundOff(Interestdiffer1);
    Interestdiffer2 = roundOff(Interestdiffer2);
    if (interest1 < interest2) {Interestdiff1 = '$Interestdiffer1';Interestdiff2='';}
    else {Interestdiff2 = '$Interestdiffer2';Interestdiff1='';}
  }

  void resetdata() {
    principal1Controlled.text = '';
    principal2Controlled.text = '';
    roi1Controlled.text = '';
    roi2Controlled.text = '';
    term1Controlled.text = '';
    term2Controlled.text = '';
    displayEMI1 = '';
    displayEMI2 = '';
    displayInterest1 = '';
    displayInterest2 = '';
    displayPayment1 = '';
    displayPayment2 = '';
    Paymentdiff1 = '';
    Paymentdiff2 = '';
    EMIdiff1 = '';
    EMIdiff2 = '';
    Interestdiff1 = '';
    Interestdiff2 = '';
  }

  double roundOff(double num) {
    int decimals = 2;
    int fac = pow(10, decimals);
    num = (num * fac).round() / fac;
    return num;
  }

}
