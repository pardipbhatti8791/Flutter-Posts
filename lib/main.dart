import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/counter_bloc.dart';
import 'package:flutter_app/src/models/arguments.dart';
import 'package:flutter_app/src/screens/counter_home_screen.dart';
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
      home: CounterBlocProvider(
        child: Builder(
          builder: (BuildContext context) {
            return CounterHomeScreen(
              title: appTitle,
              bloc: CounterBlocProvider.of(context),
            );
          },
        ),
      ),
//      home: LoginScreen(),
      routes: {
        MeetupHomeScreen.route: (context) => MeetupHomeScreen(),
        RegisterScreen.route: (context) => RegisterScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == MeetupDetailScreen.route) {
          final MeetupDetailArguments arguments = settings.arguments;
          return MaterialPageRoute(
              builder: (context) => MeetupDetailScreen(meetupId: arguments.id));
        }

        if (settings.name == LoginScreen.route) {
          final LoginScreenArguments arguments = settings.arguments;
          return MaterialPageRoute(
              builder: (context) => LoginScreen(message: arguments?.message));
        }
      },
    );
  }
}
