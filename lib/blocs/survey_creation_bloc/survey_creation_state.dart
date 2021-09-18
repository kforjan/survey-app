part of 'survey_creation_bloc.dart';

@immutable
abstract class SurveyCreationState {}

class SurveyCreationInitial extends SurveyCreationState {
  SurveyCreationInitial({
    this.title = '',
    this.questions = const [],
  });

  final title;
  final List<Question> questions;
}

class SurveyCreationUploading extends SurveyCreationState {}
