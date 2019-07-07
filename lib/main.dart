import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/meetup_detail_screen.dart';
import 'package:flutter_app/src/screens/post_screen.dart';
import './src/screens/counter_home_screen.dart';

void main() => runApp(MeetuperApp());

class MeetuperApp extends StatelessWidget {
  String appTitle = "Meetuper App";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
//      home: CounterHomeScreen(
//        title: appTitle,
//      ),
      home: PostScreen(),
      routes: {
        MeetupDetailScreen.route: (context) => MeetupDetailScreen(),
      },
    );
  }
}
