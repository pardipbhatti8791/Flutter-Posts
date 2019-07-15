import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/bloc_provider.dart';
import 'package:flutter_app/src/blocs/counter_bloc.dart';
import 'package:flutter_app/src/widgets/bottom_navigation.dart';

class CounterHomeScreen extends StatefulWidget {
  final String _title;
  CounterHomeScreen({String title}) : _title = title;

  @override
  State<StatefulWidget> createState() => CounterHomeScreenState();
}

class CounterHomeScreenState extends State<CounterHomeScreen> {
  CounterBloc counterBloc;

  didChangeDependencies() {
    super.didChangeDependencies();
    counterBloc = BlocProvider.of<CounterBloc>(context);
  }

  _increment() {
    counterBloc.increment(1);
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
                  stream: counterBloc.counterStream,
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
