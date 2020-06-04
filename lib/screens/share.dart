import 'package:share/share.dart';
import 'package:flutter/material.dart';

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {

  String text='';
  String subject = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jatin'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'share Text',
              ),
              maxLines: 2,
              onChanged: (String value) =>setState((){
                text=value;
              }),

            ),

            TextField(
              decoration: InputDecoration(
                  labelText: 'share subject',
              ),
              maxLines: 2,
              onChanged: (String value) =>setState((){
                subject=value;
              }),

            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0),
            ),
            Builder(
              builder: (BuildContext context){
                return RaisedButton(
                  child: Text('Share'),
                  onPressed: text.isEmpty ? null : (){
                    final RenderBox box = context.findRenderObject();
                    Share.share(text,subject: subject,
                        sharePositionOrigin:
                    box.localToGlobal(Offset.zero) & box.size
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
