import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    if (event is Register) {
      yield* _mapRegisterToState(event);
    }
    if (event is LogOut) {
      yield* _mapALogOutToState();
    }
  }

  Stream<AuthenticationState> _mapCheckExistingAuthToState() async* {
    final isSignedIn = await _userRepository.isSignedIn;
    if (isSignedIn) {
      final user = await _userRepository.currentUser;
      yield AuthenticationSuccess(user!);
    } else {
      yield AuthenticationInitial();
    }
  }

  Stream<AuthenticationState> _mapLogInToState(LogIn event) async* {
    try {
      final userCred = await _userRepository.signInWithCredentials(
          event.email, event.password);
      if (userCred.user != null) {
        yield AuthenticationSuccess(userCred.user!);
      } else {
        yield AuthenticationFailure();
        yield AuthenticationInitial();
      }
    } catch (e) {
      yield AuthenticationFailure();
      yield AuthenticationInitial();
    }
  }

  Stream<AuthenticationState> _mapRegisterToState(Register event) async* {
    if (event.password == event.confirmPassword) {
      try {
        final userCred =
            await _userRepository.register(event.email, event.password);
        if (userCred.user != null) {
          yield AuthenticationSuccess(userCred.user!);
        } else {
          yield RegistrationFailure();
          yield AuthenticationInitial();
        }
      } catch (e) {
        yield RegistrationFailure();
        yield AuthenticationInitial();
      }
    }
  }

  Stream<AuthenticationState> _mapALogOutToState() async* {
    yield AuthenticationInitial();
    _userRepository.signOut();
  }
}
