part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  AuthenticationSuccess(this.user);

  final User user;
}

class AuthenticationFailure extends AuthenticationState {}

class RegistrationFailure extends AuthenticationState {}
