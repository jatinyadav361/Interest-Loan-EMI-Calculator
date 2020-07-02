import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/intermediate/inter_simple2.dart';
import 'package:simple_interest_calculator/models/userData.dart';
import 'package:simple_interest_calculator/services/firestore.dart';
import 'package:simple_interest_calculator/shared/loading.dart';

class SimpleInterest extends StatefulWidget {
  @override
  _SimpleInterestState createState() => _SimpleInterestState();
}

class _SimpleInterestState extends State<SimpleInterest> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var _currentItemSelected = 'Rupees';

  bool loading = false;

  TextEditingController principalControlled = TextEditingController();

  TextEditingController roiControlled = TextEditingController();

  TextEditingController termControlled = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    var size = MediaQuery.of(context).size;

    final historyList = Provider.of<List<UserData>>(context) ?? [];

    return StreamProvider<List<UserData>>.value(
        value: FireStoreService().simpleInterestHistory,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Simple Interest Calculator',
                textScaleFactor: size.width*0.00265,
                style: TextStyle(

                ),
              ),
              actions: [
                IconButton(
                  tooltip: 'History',
                    onPressed: () {
                      displayResult = '';
                      resetdata();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return IntermediateSimpleInterest2();
                        }
                      ));
                    },
                    icon: Icon(Icons.history,color: Colors.white,),
                    ),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Center(
                          child: Image(
                            image: AssetImage(
                                'assets/Screenshot_2020-03-31-09-01-22-25.jpg'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            style: textStyle,
                            controller: principalControlled,
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              return value.isEmpty
                                  ? 'Please enter principal value'
                                  : null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Enter Principal',
                                labelStyle: textStyle,
                                errorStyle: TextStyle(fontSize: 15.0),
                                hintText: 'Enter Principal e.g. 12000',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                        ),
                        Row(children: <Widget>[
                          SizedBox(width: 10.0),
                          Text(
                            'Rate of Interest :',
                            textScaleFactor: 1.66,
                            style: TextStyle(color: Colors.green),
                          ),
                          Expanded(
                              child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 5.0),
                                  child: Text(
                                    'Yearly',
                                    textScaleFactor: 1.66,
                                    style: TextStyle(color: Colors.green),
                                  ))),
                        ]),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: textStyle,
                            controller: roiControlled,
                            validator: (String value) {
                              return value.isEmpty
                                  ? 'Please enter rate of interest'
                                  : null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Enter Rate of Interest(Yearly)',
                                labelStyle: textStyle,
                                errorStyle: TextStyle(fontSize: 15.0),
                                hintText: 'Enter Rate in percent e.g. 15',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            Expanded(
                              child: TextFormField(
                                style: textStyle,
                                controller: termControlled,
                                keyboardType: TextInputType.number,
                                validator: (String value) {
                                  return value.isEmpty
                                      ? 'Please enter time'
                                      : null;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Enter Time',
                                    labelStyle: textStyle,
                                    errorStyle: TextStyle(fontSize: 15.0),
                                    hintText: 'Time in years',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                                child: DropdownButton<String>(
                              items: _currencies.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _currentItemSelected,
                              onChanged: (String newValueSelected) {
                                _onDropDownItemSelected(newValueSelected);
                              },
                            )),
                            SizedBox(width: 10.0),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            Expanded(
                              flex: 1,
                              child: RaisedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      var result = await FireStoreService()
                                          .updateUserDataSimpleInterest(
                                              '${historyList.length}',
                                              principalControlled.text,
                                              roiControlled.text,
                                              termControlled.text,
                                              _calculateInterest());
                                      if (result == null) {
                                        loading = false;
                                      } else {
                                        loading = false;
                                      }
                                      setState(() {
                                        displayResult =
                                            _calculateTotalReturns();
                                      });
                                    } else
                                      displayResult = '';
                                  },
                                  child: Text(
                                    'Calculate',
                                    style: textStyle,
                                  )),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              flex: 1,
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    resetdata();
                                  });
                                },
                                child: Text(
                                  'Reset',
                                  style: textStyle,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            displayResult,
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: loading ? Loading() : Container(),
                )
              ],
            )));
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiControlled.text);
    double term = double.parse(termControlled.text);

    double interest = (principal * term * roi) / 100;

    String result;
    double totalReturns = principal + (principal * term * roi) / 100;
    result =
        'After $term years ,\n\nSimple Interest is : $interest $_currentItemSelected\n\nTotal amount is : $totalReturns $_currentItemSelected';

    return result;
  }

  String _calculateInterest() {
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiControlled.text);
    double term = double.parse(termControlled.text);

    double interest = (principal * term * roi) / 100;

    return '$interest';
  }

  void resetdata() {
    principalControlled.text = '';
    roiControlled.text = '';
    termControlled.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
