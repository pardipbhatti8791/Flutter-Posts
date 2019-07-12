import 'dart:async';
import 'package:flutter/material.dart';

class CounterBloc {
  final  StreamController<int> _streamController = StreamController<int>.broadcast();
  final StreamController<int> _counterController = StreamController<int>();

  Stream<int> get counterStream => _counterController.stream;
  StreamSink<int> get counterSink => _counterController.sink;

  int _counter = 0;

  CounterBloc() {
    _streamController.stream
        .listen(_handleIncrement);
  }

  _handleIncrement(int number) {
    _counter += number;
    counterSink.add(_counter);
  }

  increment(int number) {
    _streamController.sink.add(number);
  }

  dispose() {
    _streamController.close();
    _counterController.close();
  }
}

class CounterBlocProvider extends InheritedWidget {
  final CounterBloc bloc;

  CounterBlocProvider({ Widget child, Key key })
  : bloc = CounterBloc(), super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CounterBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CounterBlocProvider)as CounterBlocProvider).bloc;
  }

}