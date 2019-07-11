import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/login_screen.dart';
import 'package:flutter_app/src/screens/meetup_detail_screen.dart';
import 'package:flutter_app/src/screens/meetup_home_screen.dart';
import 'package:flutter_app/src/screens/post_screen.dart';
import 'package:flutter_app/src/screens/register_screen.dart';

void main() => runApp(MeetuperApp());

class MeetuperApp extends StatelessWidget {
  String appTitle = "Meetuper App";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.brown),
//      home: CounterHomeScreen(
//        title: appTitle,
//      ),
//      home: PostScreen(),
      home: LoginScreen(),
      routes: {
        MeetupHomeScreen.route: (context) => MeetupHomeScreen(),
        LoginScreen.route: (context) => LoginScreen(),
        RegsiterScreen.route: (context) => RegsiterScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == MeetupDetailScreen.route) {
          final MeetupDetailArguments arguments = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => MeetupDetailScreen(meetupId: arguments.id)
          );
        }
      },
    );
  }
}
