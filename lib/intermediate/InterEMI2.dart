import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/history_lists/historyEMI.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/screens/compound_interest.dart';
import 'package:simple_interest_calculator/screens/emi_calculator.dart';
import 'package:simple_interest_calculator/screens/monthly_interest.dart';
import 'package:simple_interest_calculator/services/firestore.dart';

class InterMediateEMIHistory2 extends StatefulWidget {
  @override
  _InterMediateEMIHistory2State createState() => _InterMediateEMIHistory2State();
}

class _InterMediateEMIHistory2State extends State<InterMediateEMIHistory2> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: FireStoreService().historyEMI,
      child: EMIHistoryList(),
    );
  }
}
