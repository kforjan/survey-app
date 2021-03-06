part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class CheckExistingAuth extends AuthenticationEvent {}

class LogIn extends AuthenticationEvent {
  LogIn({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class LogOut extends AuthenticationEvent {}

class Register extends AuthenticationEvent {
  Register({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String email;
  final String password;
  final String confirmPassword;
}
