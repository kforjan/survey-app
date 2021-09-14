import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:survey_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:survey_app/data/user_repository.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerFactory(() => AuthenticationBloc(locator()));
  locator.registerLazySingleton(() => UserRepository(locator()));
  locator.registerLazySingleton(() => FirebaseAuth.instance);
}
