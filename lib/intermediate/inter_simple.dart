import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/history_lists/simpleinterestHistory.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/screens/simple_interest.dart';
import 'package:simple_interest_calculator/services/firestore.dart';

class IntermediateSimpleInterest extends StatefulWidget {
  @override
  _IntermediateSimpleInterestState createState() => _IntermediateSimpleInterestState();
}

class _IntermediateSimpleInterestState extends State<IntermediateSimpleInterest> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: FireStoreService().simpleInterestHistory,
      child: SimpleInterest(),
    );
  }
}
