import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/screens/monthly_interest.dart';
import 'package:simple_interest_calculator/services/firestore.dart';

class InterMediateMonthlyHistory extends StatefulWidget {
  @override
  _InterMediateMonthlyHistoryState createState() => _InterMediateMonthlyHistoryState();
}

class _InterMediateMonthlyHistoryState extends State<InterMediateMonthlyHistory> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: FireStoreService().monthlyInterestHistory,
      child: MonthlyInterest(),
    );
  }
}
