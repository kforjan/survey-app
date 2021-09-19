part of 'fill_survey_bloc.dart';

@immutable
abstract class FillSurveyState {}

class FillSurveyInitial extends FillSurveyState {}

class SurveyLoading extends FillSurveyState {}

class SurveyLoaded extends FillSurveyState {}

class SurveyResultsUploading extends FillSurveyState {}

class SurveyFinished extends FillSurveyState {}
