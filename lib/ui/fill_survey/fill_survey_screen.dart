import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/blocs/fill_survey_bloc/fill_survey_bloc.dart';
import 'package:survey_app/injection_container.dart';

class FillSurveyScreen extends StatelessWidget {
  const FillSurveyScreen({
    required this.id,
    required this.title,
    Key? key,
  }) : super(key: key);

  final String id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: BlocProvider(
        create: (context) => locator<FillSurveyBloc>()
          ..add(
            LoadSurveyQuestions(id),
          ),
        child: BlocBuilder<FillSurveyBloc, FillSurveyState>(
          builder: (context, state) {
            if (state is SurveyLoaded) {
              return Text(state.questions[0].question);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
