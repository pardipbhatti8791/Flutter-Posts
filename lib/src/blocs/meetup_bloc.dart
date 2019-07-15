
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_app/src/blocs/bloc_provider.dart';
import 'package:flutter_app/src/models/Meetup.dart';
import 'package:flutter_app/src/services/meetup_api_service.dart';

class MeetupBloc implements BlocBase {

  final MeetupApiService _api = MeetupApiService();

  final BehaviorSubject<List<Meetup>> _meetupController = BehaviorSubject();
  Stream<List<Meetup>> get meetups => _meetupController.stream;
  StreamSink<List<Meetup>> get _inMeetups => _meetupController.sink;

  final BehaviorSubject<Meetup> _meetupDetailController = BehaviorSubject();
  Stream<Meetup> get meetup => _meetupDetailController.stream;
  StreamSink<Meetup> get _inMeetup => _meetupDetailController.sink;

  void fetchMeetups() async {
    final meetups = await _api.fetchMeetups();
    _inMeetups.add(meetups);
  }

  void fetchMeetup(String meetupId) async {
    final meetup = await _api.fetchMeetupById(meetupId);
    _inMeetup.add(meetup);
  }


  @override
  void dispose() {
    _meetupController.close();
    _meetupDetailController.close();
  }
}