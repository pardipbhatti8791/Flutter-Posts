import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_app/src/blocs/auth_bloc/state.dart';
import 'package:flutter_app/src/blocs/bloc_provider.dart';
import 'package:flutter_app/src/blocs/meetup_bloc.dart';
import 'package:flutter_app/src/models/arguments.dart';
import 'package:flutter_app/src/screens/login_screen.dart';
import 'package:flutter_app/src/screens/meetup_detail_screen.dart';
import 'package:flutter_app/src/screens/meetup_home_screen.dart';
import 'package:flutter_app/src/screens/register_screen.dart';
import 'package:flutter_app/src/services/auth_api_service.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<AuthBloc>(
      bloc: AuthBloc(auth: AuthApiService()),
      child: MeetuperApp(),
    );
  }
}

class MeetuperApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MeetuperAppState();
}

class _MeetuperAppState extends State<MeetuperApp> {
  String appTitle = "Meetuper App";
  AuthBloc authBloc;

  @override
  void initState() {
    // TODO: implement initState
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.brown),
      home: StreamBuilder<AuthenticationState>(
        stream: authBloc.authState,
        initialData: AuthenticationUninitialized(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final state = snapshot.data;

          if(state is AuthenticationUnauthenticated) {
            final LoginScreenArguments arguments = ModalRoute.of(context).settings.arguments;
            final message = state.message ?? arguments?.message;
            state.message = null;
            return LoginScreen(message: message);
          }

          if(state is AuthenticationUninitialized) {
            //TODO: Return splash screen
            return SplashScreen();
          }

          if(state is AuthenticationAuthenticated) {
            return BlocProvider<MeetupBloc>(
              bloc: MeetupBloc(),
              child: MeetupHomeScreen(),
            );
          }

          if(state is AuthenticationLoading) {
            print(state);
            // TODO: return loading screen
            return LoadingScreen();
          }

        },
      ),
      routes: {
        MeetupHomeScreen.route: (context) => BlocProvider<MeetupBloc>(
              bloc: MeetupBloc(),
              child: MeetupHomeScreen(),
            ),
        RegisterScreen.route: (context) => RegisterScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == MeetupDetailScreen.route) {
          final MeetupDetailArguments arguments = settings.arguments;
          return MaterialPageRoute(
              builder: (context) => BlocProvider<MeetupBloc>(
                    bloc: MeetupBloc(),
                    child: MeetupDetailScreen(meetupId: arguments.id),
                  ));
        }

        if (settings.name == LoginScreen.route) {
          final LoginScreenArguments arguments = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => LoginScreen(message: arguments?.message),
          );
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


