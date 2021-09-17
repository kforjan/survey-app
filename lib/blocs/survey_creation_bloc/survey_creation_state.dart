part of 'survey_creation_bloc.dart';

@immutable
abstract class SurveyCreationState {}

class SurveyCreationInitial extends SurveyCreationState {}

class SurveyCreationUploading extends SurveyCreationState {}

class SurveyCreationSuccessful extends SurveyCreationState {}
