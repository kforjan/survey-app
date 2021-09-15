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
    if (event is CheckExistingAuth) {
      yield* _mapCheckExistingAuthToState();
    }
    if (event is LogIn) {
      yield* _mapLogInToState(event);
    }
    if (event is LogOut) {
      yield* _mapALogOutToState();
    }
  }

  Stream<AuthenticationState> _mapCheckExistingAuthToState() async* {
    final isSignedIn = await _userRepository.isSignedIn;
    if (isSignedIn) {
      yield AuthenticationSuccess();
    } else {
      yield AuthenticationInitial();
    }
  }

  Stream<AuthenticationState> _mapLogInToState(LogIn event) async* {
    try {
      final userCred = await _userRepository.signInWithCredentials(
          event.email, event.password);
      if (userCred.user != null) {
        yield AuthenticationSuccess();
      } else {
        yield AuthenticationFailure();
        yield AuthenticationInitial();
      }
    } catch (e) {
      yield AuthenticationFailure();
      yield AuthenticationInitial();
    }
  }

  Stream<AuthenticationState> _mapALogOutToState() async* {
    yield AuthenticationInitial();
    _userRepository.signOut();
  }
}
