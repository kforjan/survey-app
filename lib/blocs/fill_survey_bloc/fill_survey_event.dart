part of 'fill_survey_bloc.dart';

@immutable
abstract class FillSurveyEvent {}

class GetSurveyQuestions extends FillSurveyEvent {}

class ChangeSurveyData extends FillSurveyEvent {}

class FinishSurvey extends FillSurveyEvent {}
