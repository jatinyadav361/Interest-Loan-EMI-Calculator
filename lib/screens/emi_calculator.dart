
import 'package:flutter/material.dart';
import 'package:simple_interest_calculator/models/emi.dart';
import 'dart:math';
import 'package:simple_interest_calculator/screens/emi_history.dart';
import 'package:simple_interest_calculator/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';


class EMI extends StatefulWidget {
  final EMIHistory emiHistory;
  EMI(this.emiHistory);
  @override
  _EMIState createState() => _EMIState(this.emiHistory);
}

class _EMIState extends State<EMI> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var _currentItemSelected = 'Rupees';
  TextEditingController loanControlled = TextEditingController();

  TextEditingController roiControlled = TextEditingController();

  TextEditingController termControlled = TextEditingController();

  DatabaseHelper helper = DatabaseHelper();
  List<EMIHistory> list;
  EMIHistory emiHistory;
  int count = 0;
  _EMIState(this.emiHistory);

  var emi;

  var displayResult = '';

  var displayOutput= '';

  @override
  Widget build(BuildContext context) {
    if(list == null) {
      list = List<EMIHistory>();
      updateListView();
    }
    emiHistory.amount = loanControlled.text;
    emiHistory.roi = loanControlled.text;
    emiHistory.time =termControlled.text;

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('EMI Calculator'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen();
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                tooltip: 'History',
                onPressed: (){
                    navigateToDetail(list,count,emi);
//                todo
                },
              )
            ],
          ),
          body: Form(
            key: _formKey,
            child:ListView(
            children: <Widget>[
              Center(
                child: Image(
                  image: AssetImage('assets/Screenshot_2020-04-01-12-16-44-46.jpg'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  controller: loanControlled,
                  onChanged: (v){
                    emiHistory.amount = v;
                  },
                  validator: (String value){
                    if(value.isEmpty) {
                      displayResult='';
                      displayOutput= '';
                      return 'Please enter loan amount'; }

                  },
                  decoration: InputDecoration(
                      labelText: 'Loan Amount',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(fontSize: 15.0),
                      hintText: 'Enter Loan amount',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  onChanged: (v){
                    emiHistory.roi = v;
                  },
                  controller: roiControlled,
                  validator: (String value){
                    if(value.isEmpty || value=='0') {
                      displayResult='';
                      displayOutput= '';
                      return
                        'Please enter a valid rate of interest';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter Rate of Interest(annual)',
                      labelStyle: textStyle,
                      hintText: 'Enter Rate in percent e.g. 15',
                      errorStyle: TextStyle(fontSize: 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Expanded( flex:2,
                    child: TextFormField(
                      style: textStyle,
                      controller: termControlled,
                      onChanged: (v){
                        emiHistory.time = v;
                      },
                      validator: (String value){
                        if(value.isEmpty || value=='0') {
                          displayResult='';
                          displayOutput= '';
                          return 'Please enter valid loan term'; }

                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Term (in months)',
                          errorStyle: TextStyle(fontSize: 13.8),
                          labelStyle: textStyle,
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
                                displayResult = _calculateTotalReturns();
                                displayOutput = _calculateEMI();
                                emi = displayOutput;
                                _save();
                            }
                            else {
                              displayResult = '';
                              displayOutput= '';
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
                  SizedBox(width: 10.0),]),
                  SizedBox(height: 15.0),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      displayResult,textScaleFactor: 1.5,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )

            ],
          ),
        )));
  }

      String _calculateEMI() {
        double principal = double.parse(loanControlled.text);
        double roi = double.parse(roiControlled.text);
        double term = double.parse(termControlled.text);

        double x=1;
        for(int i=0;i<term;i++){
          x=x*(1+roi/1200);
        }

        double monthlyEMI = (principal*roi*(x)/(1200*(x-1)));
        monthlyEMI=roundOff(monthlyEMI);

        return '$monthlyEMI';
      }


      String _calculateTotalReturns() {
        double principal = double.parse(loanControlled.text);
        double roi = double.parse(roiControlled.text);
        double term = double.parse(termControlled.text);

        double x=1;
        for(int i=0;i<term;i++){
          x=x*(1+roi/1200);
        }
        double monthlyEMI = (principal*roi*(x)/(1200*(x-1)));
        monthlyEMI=roundOff(monthlyEMI);
        double interest= monthlyEMI*term-principal;
        interest=roundOff(interest);
        double totalAmount = principal+ interest;
        String result =
           'Monthly EMI : $monthlyEMI $_currentItemSelected\n\n'
            'Total Interest payable : $interest $_currentItemSelected\n\n'
            'Total amount(loan+Interest) : $totalAmount $_currentItemSelected';
        return result;
      }

      void resetdata() {
        loanControlled.text = '';
        roiControlled.text = '';
        termControlled.text = '';
        displayResult = '';
        _currentItemSelected = _currencies[0];
      }

      void _onDropDownItemSelected(String newValueSelected) {
        setState(() {
          this._currentItemSelected = newValueSelected;
        });
      }

      double roundOff(double num){
        int decimals=2;
        int fac= pow(10,decimals);
        num = (num*fac).round()/fac;
        return num;
      }

        void moveToLastScreen() {
          Navigator.pop(context);
        }

        void _save() async{
    try{
          int result = await helper.insertHistory(emiHistory);
    }

          catch(e){
      print(e);
          }
        }

  void navigateToDetail(List<EMIHistory> list,int count,String displayEMI) async {
    updateListView();
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return HistoryEMI(list,count,displayEMI);
    }));
  }

  void updateListView() {
    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database){
      Future<List<EMIHistory>> historyListFuture = helper.getHistoryList();
      historyListFuture.then((historyList){
        this.list = historyList;
        this.count = historyList.length;
      });
    });
  }

}
