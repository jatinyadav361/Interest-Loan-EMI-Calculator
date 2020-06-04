import 'package:flutter/material.dart';
import 'package:simple_interest_calculator/models/emi.dart';
import 'package:simple_interest_calculator/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';

class HistoryEMI extends StatefulWidget {
  final List<EMIHistory> list;
  final int count;
  final String emi;
  HistoryEMI(this.list,this.count,this.emi);
  @override
  _HistoryEMIState createState() => _HistoryEMIState(this.list,this.count,this.emi);
}

class _HistoryEMIState extends State<HistoryEMI> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<EMIHistory> list;
  String emi;
  int count;
  _HistoryEMIState(this.list,this.count,this.emi);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          moveToLastScreen();
        }),
      ),
    body: ListView.builder(
        itemCount:  count,
          itemBuilder: (BuildContext context, int position) {
          var amount = this.list[position].amount;
          var roi = this.list[position].roi;
          var time = this.list[position].time;
          double amount2 = double.parse(amount);
          double roi2 = double.parse(roi);
          double time2 = double.parse(time);
          double x=1;
          for(int i=0;i<time2;i++){
            x=x*(1+roi2/1200);
          }
          double monthlyEMI = (amount2*roi2*(x)/(1200*(x-1)));
          monthlyEMI=roundOff(monthlyEMI);
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text('Monthly EMI : Rs. $monthlyEMI'),
            subtitle: Text('Loan Amount= Rs. ${this.list[position].amount}'
                '   Time:${this.list[position].time} months'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                setState(() {
                  _delete(context, list[position]);
                });
              },
            ),
          ),
        );
      }),
    );
  }

  void _delete(BuildContext context, EMIHistory emiHistory) async {
    int result = await databaseHelper.deleteHistory(emiHistory.id);

    if (result != 0) {
      _showSnackBar(context, "History deleted successfully");
    updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
//    singleton instance of our database
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){
      Future<List<EMIHistory>> historyListFuture = databaseHelper.getHistoryList();
      historyListFuture.then((historyList){  //then function is used to update history list or our app UI
        setState(() {
          this.list = historyList;
          this.count = historyList.length;
        });
      });
    }) ;
  }

  void moveToLastScreen() {
    Navigator.pop(context);
    updateListView();
  }



  double roundOff(double num){
    int decimals=2;
    int fac= pow(10,decimals);
    num = (num*fac).round()/fac;
    return num;
  }

}
