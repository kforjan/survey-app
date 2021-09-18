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
    );
  }

  Widget _buildQuestionCard(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [],
        ),
      ),
    );
  }

  Widget _buildAddQustionCard(BuildContext context) => Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
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
}
