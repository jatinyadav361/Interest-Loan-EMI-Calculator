import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/services/firestore.dart';
import 'package:simple_interest_calculator/shared/loading.dart';

class SimpleInterestHistory extends StatefulWidget {
  @override
  _SimpleInterestHistoryState createState() => _SimpleInterestHistoryState();
}

class _SimpleInterestHistoryState extends State<SimpleInterestHistory> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final historyList = Provider.of<List<UserData>>(context) ?? [];

    return Scaffold(

      appBar: AppBar(
        title: Text('History'),
        actions:[
        FlatButton.icon(
            onPressed: () async {
              setState(() {
                loading = true;
              });
              for(int i=0;i<historyList.length;i++) {
                print('$i ${historyList.length}');
                await FireStoreService().deleteHistory('${historyList.length-i-1}');
              }
                setState(() {
                  loading = false;
                });
            },
            icon: Icon(Icons.delete,color: Colors.white,),
            label: Text('Delete History',style: TextStyle(
              color: Colors.white,
            ),)),
        ],
      ),
      body: Stack(
        children: [

          ListView.builder(
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                      'Interest : ${historyList[historyList.length - index - 1].simpleInterest}'),
                  subtitle: Text(
                      'Principal : ${historyList[historyList.length - index - 1].principal}'),
                  trailing: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                            'Time : ${historyList[historyList.length - index - 1].time} years'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                            'Rate : ${historyList[historyList.length - index - 1].roiYearly}% annually'),
                      ),
                    ],
                  ),
                ),
                elevation: 4,
              );
            },
          ),

          Positioned(
            child: loading? Loading():Container(),
          )
        ],
      ),
    );
  }

  Widget _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('History Deleted Successfully'));
    Scaffold.of(context).showSnackBar(snackBar);
  }

}
