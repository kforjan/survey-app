part of 'survey_creation_bloc.dart';

@immutable
abstract class SurveyCreationEvent {}

class AddQuestion extends SurveyCreationEvent {}

class RemoveQuestion extends SurveyCreationEvent {}

class FinishSurvey extends SurveyCreationEvent {}
