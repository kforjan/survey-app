part of 'fill_survey_bloc.dart';

@immutable
abstract class FillSurveyEvent {}

class LoadSurveyQuestions extends FillSurveyEvent {
  final String id;

  LoadSurveyQuestions(this.id);
}

class FinishSurveyFill extends FillSurveyEvent {
  FinishSurveyFill({
    required this.id,
    required this.surveyAnswers,
  });

  final String id;
  final List<int> surveyAnswers;
}
