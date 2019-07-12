import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/bottom_navigation.dart';

class CounterHomeScreen extends StatefulWidget {
  final String _title;

  CounterHomeScreen({String title}) : _title = title;

  @override
  State<StatefulWidget> createState() => CounterHomeScreenState();
}

class CounterHomeScreenState extends State<CounterHomeScreen> {
  final StreamController<int> _streamController =
      StreamController<int>.broadcast();

//  final StreamTransformer<int, int> _streamTransformer =
//      StreamTransformer.fromHandlers(
//          handleData: (int data, EventSink<int> sink) {
//    print("calling from handle data");
//    print(data);
//    sink.add(data ~/ 2);
//  });

  @override
  initState() {
    super.initState();
    _streamController.stream
//        .map((data) => data * 2)
//        .map((data) => data - 4)
//        .map((data) => data * data)
//        .transform(_streamTransformer)
        .listen((int number) {
          _counter += number;
    });
  }

  int _counter = 0;

  _increment() {
//    setState(() {
//      _counter++;
//    });
    _streamController.sink.add(1);
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
        bottomNavigationBar: BottomNavigation());
  }
}
