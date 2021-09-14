part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class CheckExistingAuth extends AuthenticationEvent {}

class LogIn extends AuthenticationEvent {}

class LogOut extends AuthenticationEvent {}
