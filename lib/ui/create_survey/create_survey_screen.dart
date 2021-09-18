import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/blocs/survey_creation_bloc/survey_creation_bloc.dart';
import 'package:survey_app/injection_container.dart' as di;
import 'package:survey_app/injection_container.dart';
import 'package:survey_app/models/question.dart';

class CreateSurveyScreen extends StatefulWidget {
  const CreateSurveyScreen({Key? key}) : super(key: key);

  @override
  State<CreateSurveyScreen> createState() => _CreateSurveyScreenState();
}

class _CreateSurveyScreenState extends State<CreateSurveyScreen> {
  TextEditingController _questionController = TextEditingController();
  TextEditingController _answer1Controller = TextEditingController();
  TextEditingController _answer2Controller = TextEditingController();
  TextEditingController _answer3Controller = TextEditingController();
  TextEditingController _answer4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<SurveyCreationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create a survey'),
        ),
        body: BlocConsumer<SurveyCreationBloc, SurveyCreationState>(
          listener: (context, state) async {
            if (state is SurveyCreationSuccessful) {
              await locator<SurveyCreationBloc>().close();
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            print(state);
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
                                context, state.questions[index]),
                      ),
                      _buildAddQustionButton(context),
                      ElevatedButton(
                        onPressed: () {
                          locator<SurveyCreationBloc>().add(FinishSurvey());
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is SurveyCreationUploading) {
              return Center(
                child: CircularProgressIndicator(),
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
        onDismissed: (direction) {
          locator<SurveyCreationBloc>().add(RemoveQuestion(question));
        },
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
                  child: Text(
                    question.question,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '1: ${question.answer1}',
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '2: ${question.answer2}',
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '3: ${question.answer3}',
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '4: ${question.answer4}',
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
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
              controller: _questionController,
              decoration: InputDecoration(
                hintText: "Enter your question here",
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAnswerTextField(context, 1, _answer1Controller),
              SizedBox(
                width: 20,
              ),
              _buildAnswerTextField(context, 2, _answer2Controller),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAnswerTextField(context, 3, _answer3Controller),
              SizedBox(
                width: 20,
              ),
              _buildAnswerTextField(context, 4, _answer4Controller),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (_questionController.text == "" ||
                  _answer1Controller.text == "" ||
                  _answer2Controller.text == "" ||
                  _answer3Controller.text == "" ||
                  _answer4Controller.text == "") {
                return;
              }
              di.locator<SurveyCreationBloc>().add(
                    AddQuestion(
                      Question(
                          question: _questionController.text,
                          answer1: _answer1Controller.text,
                          answer2: _answer2Controller.text,
                          answer3: _answer3Controller.text,
                          answer4: _answer4Controller.text),
                    ),
                  );
              _questionController.clear();
              _answer1Controller.clear();
              _answer2Controller.clear();
              _answer3Controller.clear();
              _answer4Controller.clear();
              Navigator.of(context).pop();
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

  Widget _buildAnswerTextField(BuildContext context, int answerNumber,
          TextEditingController controller) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.3,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Answer $answerNumber",
          ),
        ),
      );
}
