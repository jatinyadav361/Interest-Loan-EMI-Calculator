import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/history_lists/compoundHistory.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/screens/compound_interest.dart';
import 'package:simple_interest_calculator/screens/monthly_interest.dart';
import 'package:simple_interest_calculator/services/firestore.dart';

class InterMediateCompoundHistory2 extends StatefulWidget {
  @override
  _InterMediateCompoundHistory2State createState() => _InterMediateCompoundHistory2State();
}

class _InterMediateCompoundHistory2State extends State<InterMediateCompoundHistory2> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: FireStoreService().compoundInterestHistory,
      child: CompoundHistoryList(),
    );
  }
}
