import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fill_survey_event.dart';
part 'fill_survey_state.dart';

class FillSurveyBloc extends Bloc<FillSurveyEvent, FillSurveyState> {
  FillSurveyBloc() : super(FillSurveyInitial());

  @override
  Stream<FillSurveyState> mapEventToState(
    FillSurveyEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
