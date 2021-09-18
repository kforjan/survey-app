import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:survey_app/data/survey_repository.dart';

part 'survey_selection_event.dart';
part 'survey_selection_state.dart';

class SurveySelectionBloc
    extends Bloc<SurveySelectionEvent, SurveySelectionState> {
  SurveySelectionBloc(this._surveyRepository) : super(SurveySelectionInitial());

  SurveyRepository _surveyRepository;

  @override
  Stream<SurveySelectionState> mapEventToState(
    SurveySelectionEvent event,
  ) async* {
    if (event is LoadSurveys) {
      yield* _mapLoadSurveysToState();
    }
  }

  Stream<SurveySelectionState> _mapLoadSurveysToState() async* {
    yield SurveysLoading();
    final ids = await _surveyRepository.loadSurveyIds();
    final titles = await _surveyRepository.loadTitles(ids);
    yield SurveysLoaded(
      titles: titles,
      ids: ids,
    );
  }
}
