import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      _mapAuthenticationStartedToState();
    }
    if (event is LoggedIn) {
      _mapLoggedInToState();
    }
    if (event is LoggedOut) {
      _mapALoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {}

  Stream<AuthenticationState> _mapLoggedInToState() async* {}

  Stream<AuthenticationState> _mapALoggedOutToState() async* {
    yield AuthenticationFailure();
    //TODO: signout func
  }
}
