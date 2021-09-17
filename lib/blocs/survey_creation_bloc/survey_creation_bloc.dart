import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'survey_creation_event.dart';
part 'survey_creation_state.dart';

class SurveyCreationBloc extends Bloc<SurveyCreationEvent, SurveyCreationState> {
  SurveyCreationBloc() : super(SurveyCreationInitial());

  @override
  Stream<SurveyCreationState> mapEventToState(
    SurveyCreationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
