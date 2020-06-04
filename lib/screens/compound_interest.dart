import 'package:flutter/material.dart';
import 'dart:math';


class CompoundInterest extends StatefulWidget {
  @override
  _CompoundInterestState createState() => _CompoundInterestState();
}

class _CompoundInterestState extends State<CompoundInterest> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var _currentItemSelected = 'Rupees';

  var _time = ['Yearly', 'Monthly', 'Half-Yearly','Quarterly'];
  var _currentTimeSelected = 'Yearly';
  TextEditingController principalControlled = TextEditingController();

  TextEditingController roiControlled = TextEditingController();

  TextEditingController termControlled = TextEditingController();

  var displayResult = '';


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return WillPopScope(
        onWillPop: (){
          moveToLastScreen();
        },
        child:Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
        onPressed: (){
          moveToLastScreen();
        },
        ),

            title: Text('Compound Interest Calculator',textScaleFactor: 1.0,),
      ),

      body: Form(key: _formKey,
    child:ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              style: textStyle,
              controller: principalControlled,
              keyboardType: TextInputType.number,
              validator: (String value){
                if(value.isEmpty) {
                  return 'Please enter principal value'; }

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
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              style: textStyle,
              keyboardType: TextInputType.number,

              controller: roiControlled,
              validator: (String value){
                if(value.isEmpty) {
                  return 'Please enter rate of interest'; }

              },
              decoration: InputDecoration(
                  labelText: 'Enter Rate of Interest(annual)',
                  labelStyle: textStyle,
                  errorStyle: TextStyle(fontSize: 15.0),
                  hintText: 'Enter Rate in percent e.g. 15',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
      Row(
        children: <Widget>[
          SizedBox(width: 10.0),
          Text('Interest is compounded:',textScaleFactor: 1.4,style: TextStyle(color: Colors.green),),
          Expanded(
              child:Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 5.0),
                  child: DropdownButton<String>(
                    items: _time.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: _currentTimeSelected,
                    onChanged: (String newTimeSelected) {
                      _onDropDownTimeSelected(newTimeSelected);
                    },
                  ))),
          ]),
          SizedBox(width: 10.0),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              SizedBox(width: 10.0),
              Expanded( flex:2,
                  child: TextFormField(
                      style: textStyle,
                      controller: termControlled,
                      keyboardType: TextInputType.number,
                    validator: (String value){
                      if(value.isEmpty) {
                        return 'Please enter time'; }

                    },
                      decoration: InputDecoration(
                          labelText: 'Time(in months)',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(fontSize: 15.0),
                          hintText: 'Enter Time',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
              SizedBox(width: 10.0),
              Expanded( flex: 1,
                child: Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child:DropdownButton<String>(
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
                  ))),
              SizedBox(width: 10.0),
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
                        displayResult = _calculateTotalReturns();}
                        else displayResult='';
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
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              displayResult, textScaleFactor: 1.5,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    )));
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiControlled.text);
    double term = double.parse(termControlled.text);

    double b;
    double amount;
    double a;
    double compoundInterest;
    if(_currentTimeSelected== _time[0]){
       a = term/12;
      if(a>=1)
       b = principal*(1+roi/100);
      else
        b=principal;
      for(int i=2;i<=a;i++) {
        b=b*(1+roi/100);
      }
      amount = b*(1+((term%12)*roi/12)/100);
       compoundInterest=amount-principal;
       compoundInterest= roundOff(compoundInterest);
       amount=roundOff(amount);
    }

    if(_currentTimeSelected== _time[2]){
      a = term/6;
      if(a>=1)
        b = principal*(1+roi/200);
      else
        b=principal;
      for(int i=2;i<=a;i++) {
        b=b*(1+roi/200);
      }
      amount = b*(1+((term%6)*roi/6)/200);
      compoundInterest=amount-principal;
      compoundInterest= roundOff(compoundInterest);
      amount=roundOff(amount);
    }

    if(_currentTimeSelected== _time[1]){
      a = term/1;
      if(a>=1)
        b = principal*(1+roi/100);
      else
        b=principal;
      for(int i=2;i<=a;i++) {
        b=b*(1+roi/100);
      }
      amount = b*(1+((term%1)*roi/1)/1200);
      compoundInterest=amount-principal;
      compoundInterest= roundOff(compoundInterest);
      amount=roundOff(amount);
    }

    if(_currentTimeSelected== _time[3]){
      a = term/3;
      if(a>=1)
        b = principal*(1+roi/400);
      else
        b=principal;
      for(int i=2;i<=a;i++) {
        b=b*(1+roi/400);
      }
      amount = b*(1+((term%3)*roi/3)/400);
      compoundInterest=amount-principal;
      compoundInterest= roundOff(compoundInterest);
      amount=roundOff(amount);

    }

    String result =
    'After $term months ,\n\nCompound Interest is : $compoundInterest $_currentItemSelected\n\nTotal amount is : $amount $_currentItemSelected';
    return result;
  }
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  void _onDropDownTimeSelected(String newTimeSelected) {
    setState(() {
      this._currentTimeSelected = newTimeSelected;
    });
  }

  void resetdata() {
    principalControlled.text = '';
    roiControlled.text = '';
    termControlled.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
    _currentTimeSelected= _time[0];
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }


  double roundOff(double num){
    int decimals=2;
    int fac= pow(10,decimals);
    num = (num*fac).round()/fac;
    return num;
  }
}


