import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/blocs/auth_bloc/events.dart';
import 'package:flutter_app/src/blocs/auth_bloc/state.dart';
import 'package:flutter_app/src/blocs/bloc_provider.dart';
import 'package:flutter_app/src/services/auth_api_service.dart';

export 'package:flutter_app/src/blocs/auth_bloc/state.dart';
export 'package:flutter_app/src/blocs/auth_bloc/events.dart';


class AuthBloc extends BlocBase {
  final AuthApiService auth;

  final BehaviorSubject<AuthenticationState> _authController = BehaviorSubject<AuthenticationState>();
  Stream<AuthenticationState> get authState => _authController.stream;
  StreamSink<AuthenticationState> get _inAuth => _authController.sink;

  AuthBloc({@required this.auth}): assert(auth != null);

  void dispatch(AuthenticationEvent event) async {
    await for (var state in _authStream(event)) {
      _inAuth.add(state);
    }
  }


  Stream<AuthenticationState> _authStream(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool isAuth = await auth.isAuthenticated();

      if (isAuth) {

        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is InitLogging) {
      yield AuthenticationLoading();
    }

    if (event is LoggedIn) {
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationUnauthenticated(message: event.message);
    }
  }

  dispose() {
    _authController.close();
  }
}
