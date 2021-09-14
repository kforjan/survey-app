import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:survey_app/data/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._userRepository) : super(AuthenticationInitial());

  final UserRepository _userRepository;

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
    _userRepository.signOut();
  }
}
