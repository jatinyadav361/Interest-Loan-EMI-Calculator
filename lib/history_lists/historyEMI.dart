import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/services/firestore.dart';
import 'package:simple_interest_calculator/shared/loading.dart';

class EMIHistoryList extends StatefulWidget {
  @override
  _EMIHistoryListState createState() => _EMIHistoryListState();
}

class _EMIHistoryListState extends State<EMIHistoryList> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final historyListEMI  = Provider.of<List<UserData>>(context) ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          FlatButton.icon(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                int len = historyListEMI.length;
                for(int i=0 ;i<len;i++) {
                  await FireStoreService().deleteEMIHistory('${historyListEMI.length-i-1}');
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
            itemCount: historyListEMI.length,
            itemBuilder: (context,count) {
              return Card(
                child: ListTile(
                  title: Text('Monthly EMI : ${historyListEMI[historyListEMI.length-count-1].monthlyEMI}'),
                  subtitle: Text('Loan Amount : ${historyListEMI[historyListEMI.length-count-1].principal}'),
                  trailing: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Time : ${historyListEMI[historyListEMI.length-count-1].time} months'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('Rate : ${historyListEMI[historyListEMI.length-count-1].roiYearly}% annually'),
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
