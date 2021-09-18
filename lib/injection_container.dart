import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:survey_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:survey_app/blocs/survey_creation_bloc/survey_creation_bloc.dart';
import 'package:survey_app/blocs/survey_selection_bloc/survey_selection_bloc.dart';
import 'package:survey_app/data/survey_repository.dart';
import 'package:survey_app/data/user_repository.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerFactory(() => AuthenticationBloc(locator()));
  locator.registerLazySingleton(() => UserRepository(locator()));
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => SurveyRepository(locator()));
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => SurveyCreationBloc(locator()));
  locator.registerFactory(() => SurveySelectionBloc(locator()));
}
