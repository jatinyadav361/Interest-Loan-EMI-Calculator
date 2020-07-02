import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/screens/compound_interest.dart';
import 'package:simple_interest_calculator/screens/monthly_interest.dart';
import 'package:simple_interest_calculator/services/firestore.dart';

class InterMediateCompoundHistory extends StatefulWidget {
  @override
  _InterMediateCompoundHistoryState createState() => _InterMediateCompoundHistoryState();
}

class _InterMediateCompoundHistoryState extends State<InterMediateCompoundHistory> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: FireStoreService().compoundInterestHistory,
      child: CompoundInterest(),
    );
  }
}
