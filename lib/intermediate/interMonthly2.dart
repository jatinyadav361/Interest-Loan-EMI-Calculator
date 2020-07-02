import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/history_lists/monthlyHistoryList.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/services/firestore.dart';

class InterMediateMonthlyHistory2 extends StatefulWidget {
  @override
  _InterMediateMonthlyHistory2State createState() => _InterMediateMonthlyHistory2State();
}

class _InterMediateMonthlyHistory2State extends State<InterMediateMonthlyHistory2> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: FireStoreService().monthlyInterestHistory,
      child: MonthlyHistoryList(),
    );
  }
}