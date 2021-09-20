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

class FinishSurveyCreation extends SurveyCreationEvent {
  FinishSurveyCreation(this.title);

  final String title;
}
