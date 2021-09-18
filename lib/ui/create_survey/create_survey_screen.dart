import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/blocs/survey_creation_bloc/survey_creation_bloc.dart';
import 'package:survey_app/injection_container.dart' as di;
import 'package:survey_app/models/question.dart';

class CreateSurveyScreen extends StatefulWidget {
  const CreateSurveyScreen({Key? key}) : super(key: key);

  @override
  State<CreateSurveyScreen> createState() => _CreateSurveyScreenState();
}

class _CreateSurveyScreenState extends State<CreateSurveyScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<SurveyCreationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create a survey'),
        ),
        body: BlocConsumer<SurveyCreationBloc, SurveyCreationState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SurveyCreationInitial) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.questions.length,
                        itemBuilder: (context, index) =>
                            _buildQuestionDisplayCard(
                                context,
                                Question(
                                    question: 'question',
                                    answer1: 'answer1',
                                    answer2: 'answer2',
                                    answer3: 'answer3',
                                    answer4: 'answer4')),
                      ),
                      _buildAddQustionButton(context)
                    ],
                  ),
                ),
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

  Widget _buildQuestionDisplayCard(BuildContext context, Question question) =>
      Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Warning"),
                content: const Text(
                    "Are you sure you wish to delete this question?"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text(
                        "DELETE",
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("CANCEL"),
                  ),
                ],
              );
            },
          );
        },
        background: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 35.0),
            child: Container(
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ),
        child: Container(
          width: double.infinity,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(question.question),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(question.answer1),
                    SizedBox(
                      width: 20,
                    ),
                    Text(question.answer2),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(question.answer3),
                    SizedBox(
                      width: 20,
                    ),
                    Text(question.answer4),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildCreateQuestionCard(BuildContext context) {
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
          ElevatedButton(
            onPressed: () {
              print('lda');
              di.locator<SurveyCreationBloc>().add(
                    AddQuestion(
                      Question(
                          question: 'question',
                          answer1: 'answer1',
                          answer2: 'answer2',
                          answer3: 'answer3',
                          answer4: 'answer4'),
                    ),
                  );
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Widget _buildAddQustionButton(BuildContext context) => Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 80,
          margin: EdgeInsets.only(left: 40),
          child: Center(
            child: ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: _buildCreateQuestionCard(context),
                  ),
                );
              },
              leading: Icon(
                Icons.add,
                color: Colors.black,
              ),
              title: Text('New question'),
            ),
          ),
        ),
      );

  Widget _buildAnswerTextField(BuildContext context, int answerNumber) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.3,
        child: TextField(
          decoration: InputDecoration(
            hintText: "Answer $answerNumber",
          ),
        ),
      );
}
