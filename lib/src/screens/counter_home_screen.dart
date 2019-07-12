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
  final StreamController<int> _streamController = StreamController<int>.broadcast();
  final StreamController<int> _counterController = StreamController<int>();

  @override
  initState() {
    super.initState();
    _streamController.stream
        .listen((int number) {
          _counter += number;
          _counterController.sink.add(_counter);
    });
  }

  int _counter = 0;

  _increment() {
    _streamController.sink.add(1);
  }

  dispose() {
    _streamController.close();
    _counterController.close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Welcome in ${widget._title}, lets increment numbers',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 15.0),),
                StreamBuilder(
                  stream: _counterController.stream,
//                  initialData: _counter,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if(snapshot.hasData) {
                      return Text(
                        'Counter: ${snapshot.data}',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontSize: 30.0),
                      );
                    } else {
                      return Text(
                        'Counter is sad :( No data',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontSize: 30.0),
                      );
                    }
                  },
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
        bottomNavigationBar: BottomNavigation());
  }
}
