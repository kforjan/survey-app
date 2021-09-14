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
      yield* _mapLogInToState();
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
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapLogInToState() async* {
    yield AuthenticationSuccess();
  }

  Stream<AuthenticationState> _mapALogOutToState() async* {
    yield AuthenticationFailure();
    _userRepository.signOut();
  }
}
