import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:survey_app/data/survey_repository.dart';
import 'package:survey_app/models/question.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc(this._surveyRepository) : super(StatisticsInitial());

  SurveyRepository _surveyRepository;

  @override
  Stream<StatisticsState> mapEventToState(
    StatisticsEvent event,
  ) async* {
    if (event is LoadStatistics) {
      yield* _mapLoadStatisticsToState(event);
    }
  }

  Stream<StatisticsState> _mapLoadStatisticsToState(
      LoadStatistics event) async* {
    yield StatisticsLoading();
    try {
      final asnwerStatsInternalHashMap =
          await _surveyRepository.loadAnswerStatistics(event.id);
      final questions = await _surveyRepository.loadSurvey(event.id);
      if (asnwerStatsInternalHashMap == null) {
        yield NoStatisticsFound();
        return;
      }
      final answerStats = Map<String, dynamic>.from(asnwerStatsInternalHashMap);
      yield StatisticsLoaded(
        answerStatistics: answerStats,
        questions: questions,
      );
    } catch (e) {
      yield ConnectionFailure();
    }
  }
}
