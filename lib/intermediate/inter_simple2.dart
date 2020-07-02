import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/history_lists/simpleinterestHistory.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/screens/simple_interest.dart';
import 'package:simple_interest_calculator/services/firestore.dart';

class IntermediateSimpleInterest2 extends StatefulWidget {
  @override
  _IntermediateSimpleInterest2State createState() => _IntermediateSimpleInterest2State();
}

class _IntermediateSimpleInterest2State extends State<IntermediateSimpleInterest2> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: FireStoreService().simpleInterestHistory,
      child: SimpleInterestHistory(),
    );
  }
}
