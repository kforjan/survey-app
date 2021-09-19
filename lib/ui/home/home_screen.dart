import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:survey_app/blocs/survey_selection_bloc/survey_selection_bloc.dart';
import 'package:survey_app/injection_container.dart';
import 'package:survey_app/ui/create_survey/create_survey_screen.dart';
import 'package:survey_app/ui/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.user.email.toString()),
              actions: [
                IconButton(
                  onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                      .add(LogOut()),
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
            body: Column(
              children: [
                BlocProvider(
                  create: (context) =>
                      locator<SurveySelectionBloc>()..add(LoadSurveys()),
                  child: BlocBuilder<SurveySelectionBloc, SurveySelectionState>(
                    builder: (context, state) {
                      if (state is SurveysLoaded) {
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              locator<SurveySelectionBloc>().add(LoadSurveys());
                            },
                            child: ListView.builder(
                              itemCount: state.ids.length,
                              itemBuilder: (context, index) =>
                                  Text(state.titles[index]),
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CreateSurveyScreen(),
                              ),
                            );
                          },
                          child: Center(
                            child: Text('CREATE'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              ),
                            );
                          },
                          child: Center(
                            child: Text('Profile'),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
