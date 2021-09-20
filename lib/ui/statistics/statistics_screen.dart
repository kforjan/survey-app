import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/blocs/statistics_bloc/statistics_bloc.dart';
import 'package:survey_app/injection_container.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({
    Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);

  final String id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title + ' - results'),
      ),
      body: BlocProvider(
        create: (context) => locator<StatisticsBloc>()..add(LoadStatistics(id)),
        child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            if (state is NoStatisticsFound) {
              return Center(
                child: Text(
                  'There are no results yet!\n You can be the first one to fill this survey!',
                  textAlign: TextAlign.center,
                ),
              );
            }
            if (state is StatisticsLoaded) {
              return ListView.builder(
                  itemCount: state.answerStatistics.length,
                  itemBuilder: (context, index) {
                    double percentage1 = (state
                            .answerStatistics[index.toString()]['nAnswers1']) /
                        (state.answerStatistics[index.toString()]['nAnswers1'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers2'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers3'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers4']) *
                        100;
                    double percentage2 = (state
                            .answerStatistics[index.toString()]['nAnswers2']) /
                        (state.answerStatistics[index.toString()]['nAnswers1'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers2'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers3'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers4']) *
                        100;
                    double percentage3 = (state
                            .answerStatistics[index.toString()]['nAnswers3']) /
                        (state.answerStatistics[index.toString()]['nAnswers1'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers2'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers3'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers4']) *
                        100;
                    double percentage4 = (state
                            .answerStatistics[index.toString()]['nAnswers4']) /
                        (state.answerStatistics[index.toString()]['nAnswers1'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers2'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers3'] +
                            state.answerStatistics[index.toString()]
                                ['nAnswers4']) *
                        100;
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              state.questions[index].question,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                                '${state.questions[index].answer1}: ${percentage1.toStringAsFixed(2)}%'),
                            Text(
                                '${state.questions[index].answer2}: ${percentage2.toStringAsFixed(2)}%'),
                            Text(
                                '${state.questions[index].answer3}: ${percentage3.toStringAsFixed(2)}%'),
                            Text(
                                '${state.questions[index].answer4}: ${percentage4.toStringAsFixed(2)}%'),
                          ],
                        ),
                      ),
                    );
                  });
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
