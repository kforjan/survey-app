import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/blocs/survey_creation_bloc/survey_creation_bloc.dart';
import 'package:survey_app/injection_container.dart' as di;

class CreateSurveyScreen extends StatelessWidget {
  const CreateSurveyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<SurveyCreationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create a survey'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) => _buildQuestionCard(context),
                ),
                _buildAddQustionCard(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your question here",
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAnswerTextField(context, 1),
              SizedBox(
                width: 20,
              ),
              _buildAnswerTextField(context, 2),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAnswerTextField(context, 3),
              SizedBox(
                width: 20,
              ),
              _buildAnswerTextField(context, 4),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildAddQustionCard(BuildContext context) => Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 80,
          margin: EdgeInsets.only(left: 40),
          child: Center(
            child: ListTile(
              leading: Icon(
                Icons.add,
                color: Colors.black,
              ),
              title: Text('Add another question'),
            ),
          ),
        ),
      );

  Widget _buildAnswerTextField(BuildContext context, int answerNumber) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.35,
        child: TextField(
          decoration: InputDecoration(
            hintText: "Answer $answerNumber",
          ),
        ),
      );
}
