import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/services/firestore.dart';
import 'package:simple_interest_calculator/shared/loading.dart';

class CompoundHistoryList extends StatefulWidget {
  @override
  _CompoundHistoryListState createState() => _CompoundHistoryListState();
}

class _CompoundHistoryListState extends State<CompoundHistoryList> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final historyListCompound  = Provider.of<List<UserData>>(context) ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          FlatButton.icon(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                int len = historyListCompound.length;
                for(int i=0 ;i<len;i++) {
                  await FireStoreService().deleteCompoundHistory('${historyListCompound.length-i-1}');
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
            itemCount: historyListCompound.length,
            itemBuilder: (context,count) {
              return Card(
                child: ListTile(
                  title: Text('Total Interest : ${historyListCompound[historyListCompound.length-count-1].compoundInterest}'),
                  subtitle: Text('Principal : ${historyListCompound[historyListCompound.length-count-1].principal}'),
                  trailing: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Time : ${historyListCompound[historyListCompound.length-count-1].time} months'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('Rate : ${historyListCompound[historyListCompound.length-count-1].roiYearly}% annually'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('Compounded : ${historyListCompound[historyListCompound.length-count-1].interestCompounded}'),
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
