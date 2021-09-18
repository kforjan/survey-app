import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:survey_app/models/question.dart';

part 'survey_creation_event.dart';
part 'survey_creation_state.dart';

class SurveyCreationBloc
    extends Bloc<SurveyCreationEvent, SurveyCreationState> {
  SurveyCreationBloc() : super(SurveyCreationInitial());

  @override
  Stream<SurveyCreationState> mapEventToState(
    SurveyCreationEvent event,
  ) async* {
    if (event is AddQuestion) {
      yield* _mapAddQuestionToState(event, state);
    }
  }

  Stream<SurveyCreationState> _mapAddQuestionToState(
      AddQuestion event, SurveyCreationState prevState) async* {
    if (prevState is SurveyCreationInitial) {
      final newQuestions = [...prevState.questions, event.question];
      yield SurveyCreationInitial(questions: newQuestions);
    }
  }
}
