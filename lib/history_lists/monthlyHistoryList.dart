import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/services/firestore.dart';
import 'package:simple_interest_calculator/shared/loading.dart';

class MonthlyHistoryList extends StatefulWidget {
  @override
  _MonthlyHistoryListState createState() => _MonthlyHistoryListState();
}

class _MonthlyHistoryListState extends State<MonthlyHistoryList> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final historyListMonthly  = Provider.of<List<UserData>>(context) ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          FlatButton.icon(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                int len = historyListMonthly.length;
                for(int i=0 ;i<len;i++) {
                  await FireStoreService().deleteHistoryMonthly('${historyListMonthly.length-i-1}');
                }

                setState(() {
                  loading = false;
                });

              },
              icon: Icon(Icons.delete,color: Colors.white,),
              label: Text('Delete History',style: TextStyle(color: Colors.white),))
        ],
      ),

      body: Stack(
        children: [
          ListView.builder(
            itemCount: historyListMonthly.length,
            itemBuilder: (context,count) {
              return Card(
                child: ListTile(
                  title: Text('Total Interest : ${historyListMonthly[historyListMonthly.length-count-1].monthlyInterest}'),
                  subtitle: Text('Principal : ${historyListMonthly[historyListMonthly.length-count-1].principal}'),
                  trailing: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Time : ${historyListMonthly[historyListMonthly.length-count-1].time} months'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('Rate : ${historyListMonthly[historyListMonthly.length-count-1].roiMonthly}% monthly'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          Positioned(
            child: loading? Loading(): Container(),
          ),
        ],
      ),

    );
  }
}
