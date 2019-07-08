import 'package:flutter/material.dart';

class AppStore extends StatefulWidget {
  final Widget child;

  AppStore({this.child});

  @override
  _AppStoreState createState() {
    // TODO: implement createState
    return _AppStoreState();
  }

  static _AppStoreState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedAppState) as _InheritedAppState).data;
  }
}

class _AppStoreState extends State<AppStore> {
  String testingData = 'Testing Data';

  @override
  Widget build(BuildContext context) {
    return _InheritedAppState(
      child: widget.child,
      data: this
    );
  }
}

class _InheritedAppState extends InheritedWidget {
  final _AppStoreState data;

  _InheritedAppState({@required Widget child, @required this.data}) : super(child: child);

  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
