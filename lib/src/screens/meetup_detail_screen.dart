import 'package:flutter/material.dart';

class MeetupDetailScreen extends StatelessWidget {
  static final String route = '/meetupDetails';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Meetup Details"),
      ),
      body: Center(
        child: Text("I am Meetup Details Screen"),
      ),
    );
  }
}