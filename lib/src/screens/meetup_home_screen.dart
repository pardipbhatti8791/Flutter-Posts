import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/Meetup.dart';
import 'package:flutter_app/src/screens/meetup_detail_screen.dart';
import 'package:flutter_app/src/services/auth_api_service.dart';
import 'package:flutter_app/src/services/meetup_api_service.dart';

class MeetupDetailArguments {
  final String id;

  MeetupDetailArguments({this.id});
}

class MeetupHomeScreen extends StatefulWidget {
  static final String route = '/meetups';
  final MeetupApiService _api = MeetupApiService();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MeetupHomeScreenState();
  }
}

class MeetupHomeScreenState extends State<MeetupHomeScreen> {
  List<Meetup> meetups = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchMeetups();
  }

  _fetchMeetups() async {
    final meetups = await widget._api.fetchMeetups();
    setState(() => this.meetups = meetups);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Meetup Home"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: Column(
        children: [
          _MeetupTitle(),
          _MeetupList(
            meetups: meetups,
          )
        ],
      ),
    );
  }
}

class _MeetupTitle extends StatelessWidget {


  final AuthApiService auth = AuthApiService();

  _buildWelcomeTitle()  {

    return FutureBuilder<bool>(
        future: auth.isAuthenticated(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if(snapshot.hasData && snapshot.data) {
            final user = auth.authUser;
            return Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  user.avatar != null ?
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                  ) : Container(width: 0, height: 0,),
                  Text('Welcome ${user.username}'),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      auth.logout().then((isLogout) => Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false));
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(width: 0, height: 0,);
          }
        }
    );
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Featured Meetup',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),

          _buildWelcomeTitle()
        ],
      ),
    );
  }
}

class _MeetupCard extends StatelessWidget {
  final Meetup meetup;

  _MeetupCard({@required this.meetup});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(meetup.image),
            ),
            title: Text(meetup.title),
            subtitle: Text(meetup.description),
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Visit Meetup'),
                  onPressed: () {
                    Navigator.pushNamed(context, MeetupDetailScreen.route,
                        arguments: MeetupDetailArguments(id: meetup.id));
                  },
                ),
                FlatButton(
                  child: Text('Favorite'),
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _MeetupList extends StatelessWidget {
  final List<Meetup> meetups;

  _MeetupList({@required this.meetups});

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: meetups.length,
        itemBuilder: (BuildContext cntext, int i) {
          if (i.isOdd) return Divider();

          return _MeetupCard(meetup: meetups[i]);
        },
      ),
    );
  }
}
