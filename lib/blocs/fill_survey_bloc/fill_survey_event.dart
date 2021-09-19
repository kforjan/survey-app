part of 'fill_survey_bloc.dart';

@immutable
abstract class FillSurveyEvent {}

class LoadSurveyQuestions extends FillSurveyEvent {
  final String id;

  LoadSurveyQuestions(this.id);
}

class ChangeSurveyData extends FillSurveyEvent {}

class FinishSurvey extends FillSurveyEvent {}
