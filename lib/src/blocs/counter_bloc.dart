import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/bloc_provider.dart';

class CounterBloc extends BlocBase {
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

class CounterBlocProvider extends StatefulWidget {
  final CounterBloc bloc;
  final Widget child;

  CounterBlocProvider({Key key, @required this.child}): bloc = CounterBloc(), super(key: key);

  @override
  _CounterBlocProviderState createState() => _CounterBlocProviderState();

  static CounterBloc of(BuildContext context) {
    _CounterBlocProviderInheited provider = (context.ancestorInheritedElementForWidgetOfExactType(_CounterBlocProviderInheited).widget as _CounterBlocProviderInheited);

    return provider.bloc;
  }

}

class _CounterBlocProviderState extends State<CounterBlocProvider> {

  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _CounterBlocProviderInheited(
      child: widget.child,
      bloc: widget.bloc
    );
  }
}

class _CounterBlocProviderInheited extends InheritedWidget {
  final CounterBloc bloc;

  _CounterBlocProviderInheited({ @required Widget child, @required this.bloc, Key key }): super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}