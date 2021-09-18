part of 'survey_creation_bloc.dart';

@immutable
abstract class SurveyCreationState {}

class SurveyCreationInitial extends SurveyCreationState {
  SurveyCreationInitial({this.questions = const []});

  final List<Question> questions;
}

class SurveyCreationUploading extends SurveyCreationState {}

class SurveyCreationSuccessful extends SurveyCreationState {}
