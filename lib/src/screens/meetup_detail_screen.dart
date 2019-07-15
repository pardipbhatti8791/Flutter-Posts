import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/bloc_provider.dart';
import 'package:flutter_app/src/blocs/meetup_bloc.dart';
import 'package:flutter_app/src/models/Meetup.dart';
import 'package:flutter_app/src/services/auth_api_service.dart';
import 'package:flutter_app/src/services/meetup_api_service.dart';

class MeetupDetailScreen extends StatefulWidget {
  final String meetupId;
  MeetupDetailScreen({this.meetupId});

  static final String route = '/meetupDetails';
  final MeetupApiService api = MeetupApiService();

  @override
  State<StatefulWidget> createState() => MeetupDetailScreenState();
}

class MeetupDetailScreenState extends State<MeetupDetailScreen> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    BlocProvider.of<MeetupBloc>(context).fetchMeetup(widget.meetupId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Meetup Details"),
      ),
      floatingActionButton: _MeetupActionButton(),
      body: StreamBuilder<Meetup>(
        stream: BlocProvider.of<MeetupBloc>(context).meetup,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final meetup = snapshot.data;
            return ListView(
              children: <Widget>[
                HeaderSection(
                  meetup: meetup,
                ),
                TitleSection(
                  meetup: meetup,
                ),
                AdditionalInfoSection(
                  meetup: meetup,
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(meetup.description),
                  ),
                )
              ],
            );
          } else {
            return Container(
              width: 0,
              height: 0,
            );
          }
        },
      ),
    );
  }
}

class _MeetupActionButton extends StatelessWidget {
  final AuthApiService auth = AuthApiService();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<bool>(
      future: auth.isAuthenticated(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData && snapshot.data) {
          // TODO: Check if user is meetup owner or check if user is already member
          final isMember = false;
          if(isMember) {
            return FloatingActionButton(
              child: Icon(Icons.exit_to_app),
              onPressed: () {},
              backgroundColor: Colors.red,
              tooltip: 'Leave Meetup',
            );
          } else {
            return FloatingActionButton(
              child: Icon(Icons.person_add),
              onPressed: () {},
              backgroundColor: Colors.green,
              tooltip: 'Join Meetup',
            );
          }

        } else {
          return Container(width: 0, height: 0,);
        }
      },
    );


  }
}

class AdditionalInfoSection extends StatelessWidget {
  final Meetup meetup;

  AdditionalInfoSection({this.meetup});

  _captilize(String word) {
    return (word != null && word.isNotEmpty)
        ? word[0].toUpperCase() + word.substring(1)
        : '';
  }

  Widget _buildColumn(String label, String text, Color color) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 13.0, fontWeight: FontWeight.w400, color: color),
        ),
        Text(
          _captilize(text),
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildColumn('CATEGORY', meetup.category.name, color),
        _buildColumn('FROM', meetup.timeFrom, color),
        _buildColumn('TO', meetup.timeTo, color)
      ],
    );
  }
}

class TitleSection extends StatelessWidget {
  final Meetup meetup;

  TitleSection({this.meetup});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  meetup.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  meetup.shortInfo,
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          Icon(
            Icons.people,
            color: color,
          ),
          Text(' ${meetup.joinedPeopleCount} People')
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final Meetup meetup;
  HeaderSection({this.meetup});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        Image.network(
          meetup.image,
          width: width,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: 640,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage("https://fakeimg.pl/300/"),
              ),
              title: Text(
                meetup.title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              subtitle: Text(
                meetup.shortInfo,
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
