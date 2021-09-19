part of 'fill_survey_bloc.dart';

@immutable
abstract class FillSurveyState {}

class FillSurveyInitial extends FillSurveyState {}

class SurveyLoading extends FillSurveyState {}

class SurveyLoaded extends FillSurveyState {
  SurveyLoaded(this.questions);

  final List<Question> questions;
}

class SurveyResultsUploading extends FillSurveyState {}

class SurveyFinished extends FillSurveyState {}

class ConnectionFailure extends FillSurveyState {}
