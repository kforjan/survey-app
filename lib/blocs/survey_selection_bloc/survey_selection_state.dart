part of 'survey_selection_bloc.dart';

@immutable
abstract class SurveySelectionState {}

class SurveySelectionInitial extends SurveySelectionState {}

class SurveysLoading extends SurveySelectionState {}

class SurveysLoaded extends SurveySelectionState {
  SurveysLoaded({
    required this.ids,
    required this.titles,
  });

  final List<String> titles;
  final List<String> ids;
}

class LoadingFailure extends SurveySelectionState {}
