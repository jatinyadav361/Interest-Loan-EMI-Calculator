import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/screens/compound_interest.dart';
import 'package:simple_interest_calculator/screens/emi_calculator.dart';
import 'package:simple_interest_calculator/screens/monthly_interest.dart';
import 'package:simple_interest_calculator/services/firestore.dart';

class InterMediateEMIHistory extends StatefulWidget {
  @override
  _InterMediateEMIHistoryState createState() => _InterMediateEMIHistoryState();
}

class _InterMediateEMIHistoryState extends State<InterMediateEMIHistory> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: FireStoreService().historyEMI,
      child: EMI(),
    );
  }
}
