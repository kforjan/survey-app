import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/blocs/authentication_bloc/authentication_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LogOut());
          },
          child: Text('Log out'),
        ),
      ),
    );
  }
}
