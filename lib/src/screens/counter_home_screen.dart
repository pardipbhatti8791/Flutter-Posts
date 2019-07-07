import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/bottom_navigation.dart';

class CounterHomeScreen extends StatefulWidget {
  final String _title;


  CounterHomeScreen({String title}) : _title = title;

  @override
  State<StatefulWidget> createState() => CounterHomeScreenState();
}

class CounterHomeScreenState extends State<CounterHomeScreen> {

  int _counter = 0;

  _increment() {
    setState(() {
      _counter++;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Welcome in ${widget._title}, lets increment numbers',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 15.0)),
              Text(
                'Counter: $_counter',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 30.0),
              ),
              RaisedButton(
                child: Text("Go To Details"),
                onPressed: () => Navigator.pushNamed(context, "/meetupDetails"),
              )
            ]),
      ),
      appBar: AppBar(
        title: Text(widget._title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigation()
    );
  }
}

