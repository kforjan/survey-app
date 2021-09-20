import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/blocs/fill_survey_bloc/fill_survey_bloc.dart';
import 'package:survey_app/injection_container.dart';
import 'package:survey_app/models/question.dart';

class FillSurveyScreen extends StatefulWidget {
  const FillSurveyScreen({
    required this.id,
    required this.title,
    Key? key,
  }) : super(key: key);

  final String id;
  final String title;

  @override
  State<FillSurveyScreen> createState() => _FillSurveyScreenState();
}

class _FillSurveyScreenState extends State<FillSurveyScreen> {
  final List<int> answers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
      ),
      body: BlocProvider(
        create: (context) => locator<FillSurveyBloc>()
          ..add(
            LoadSurveyQuestions(widget.id),
          ),
        child: BlocConsumer<FillSurveyBloc, FillSurveyState>(
          listener: (context, state) {
            if (state is SurveyLoaded) {
              state.questions.forEach((element) {
                answers.add(1);
              });
            }
          },
          builder: (context, state) {
            if (state is SurveyLoaded) {
              return Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: ListView.builder(
                      itemCount: state.questions.length,
                      itemBuilder: (context, index) => _surveyQuestionCard(
                        context: context,
                        index: index,
                        question: state.questions[index],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          locator<FillSurveyBloc>().add(
                            FinishSurveyFill(
                              id: widget.id,
                              surveyAnswers: answers,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
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

  Widget _surveyQuestionCard({
    required BuildContext context,
    required Question question,
    required int index,
  }) {
    return Card(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                question.question,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: RadioListTile<int>(
                value: 1,
                groupValue: answers[index],
                onChanged: (value) {
                  setState(() {
                    answers[index] = value!;
                  });
                },
                title: Text(question.answer1),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: RadioListTile<int>(
                value: 2,
                groupValue: answers[index],
                onChanged: (value) {
                  setState(() {
                    answers[index] = value!;
                  });
                },
                title: Text(question.answer1),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: RadioListTile<int>(
                value: 3,
                groupValue: answers[index],
                onChanged: (value) {
                  setState(() {
                    answers[index] = value!;
                  });
                },
                title: Text(question.answer1),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: RadioListTile<int>(
                value: 4,
                groupValue: answers[index],
                onChanged: (value) {
                  setState(() {
                    answers[index] = value!;
                  });
                },
                title: Text(question.answer1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
