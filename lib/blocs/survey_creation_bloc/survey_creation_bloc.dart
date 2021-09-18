import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:survey_app/data/survey_repository.dart';
import 'package:survey_app/models/question.dart';

part 'survey_creation_event.dart';
part 'survey_creation_state.dart';

class SurveyCreationBloc
    extends Bloc<SurveyCreationEvent, SurveyCreationState> {
  SurveyCreationBloc(this._questionsRepository)
      : super(SurveyCreationInitial());

  final SurveyRepository _questionsRepository;

  @override
  Stream<SurveyCreationState> mapEventToState(
    SurveyCreationEvent event,
  ) async* {
    if (event is AddQuestion) {
      yield* _mapAddQuestionToState(event, state);
    }
    if (event is RemoveQuestion) {
      yield* _mapRemoveQuestionToState(event, state);
    }
    if (event is FinishSurvey) {
      yield* _mapFinishSurveyToState(event, state);
    }
  }

  Stream<SurveyCreationState> _mapAddQuestionToState(
      AddQuestion event, SurveyCreationState prevState) async* {
    if (prevState is SurveyCreationInitial) {
      final newQuestions = [...prevState.questions, event.question];
      yield SurveyCreationInitial(questions: newQuestions);
    }
  }

  Stream<SurveyCreationState> _mapRemoveQuestionToState(
      RemoveQuestion event, SurveyCreationState prevState) async* {
    if (prevState is SurveyCreationInitial) {
      final newQuestions = prevState.questions;
      newQuestions.removeWhere((element) =>
          (element.question == event.question.question &&
              element.answer1 == event.question.answer1 &&
              element.answer2 == event.question.answer2 &&
              element.answer3 == event.question.answer3 &&
              element.answer4 == event.question.answer4));
      yield SurveyCreationInitial(questions: newQuestions);
    }
  }

  Stream<SurveyCreationState> _mapFinishSurveyToState(
      FinishSurvey event, SurveyCreationState state) async* {
    if (state is SurveyCreationInitial) {
      try {
        yield SurveyCreationUploading();
        await _questionsRepository.uploadSurvey(event.title, state.questions);
        yield SurveyCreationInitial();
      } catch (e) {
        throw e;
      }
    }
  }
}
