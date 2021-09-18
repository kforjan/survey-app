part of 'survey_creation_bloc.dart';

@immutable
abstract class SurveyCreationEvent {}

class AddQuestion extends SurveyCreationEvent {
  AddQuestion(this.question);

  final Question question;
}

class RemoveQuestion extends SurveyCreationEvent {
  RemoveQuestion(this.question);

  final Question question;
}

class FinishSurvey extends SurveyCreationEvent {
  FinishSurvey(this.title);

  final String title;
}
