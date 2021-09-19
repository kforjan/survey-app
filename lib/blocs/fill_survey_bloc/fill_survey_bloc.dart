import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:survey_app/data/survey_repository.dart';
import 'package:survey_app/models/question.dart';

part 'fill_survey_event.dart';
part 'fill_survey_state.dart';

class FillSurveyBloc extends Bloc<FillSurveyEvent, FillSurveyState> {
  FillSurveyBloc(this._surveyRepository) : super(FillSurveyInitial());

  final SurveyRepository _surveyRepository;

  @override
  Stream<FillSurveyState> mapEventToState(
    FillSurveyEvent event,
  ) async* {
    if (event is LoadSurveyQuestions) {
      yield* _mapLoadSurveyQuestionsToState(event);
    }
  }

  Stream<FillSurveyState> _mapLoadSurveyQuestionsToState(
      LoadSurveyQuestions event) async* {
    yield SurveyLoading();
    try {
      final List<Question> questions =
          await _surveyRepository.loadSurvey(event.id);
      yield SurveyLoaded(questions);
    } catch (e) {
      yield ConnectionFailure();
    }
  }
}
