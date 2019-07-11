import 'package:flutter/material.dart';

class RegsiterScreen extends StatefulWidget {
  static final String route = '/register';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegsiterScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('Register'),
        ),
      ),
    );
  }

}