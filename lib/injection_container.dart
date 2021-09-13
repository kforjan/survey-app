import 'package:get_it/get_it.dart';
import 'package:survey_app/blocs/authentication_bloc/authentication_bloc.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerFactory(() => AuthenticationBloc());
}
