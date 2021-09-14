import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:survey_app/injection_container.dart' as di;
import 'package:survey_app/ui/home/home_screen.dart';
import 'package:survey_app/ui/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey App',
      home: BlocProvider(
        create: (context) =>
            di.locator<AuthenticationBloc>()..add(CheckExistingAuth()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            print(state);
            if (state is AuthenticationFailure) {
              print('login');
              return LoginScreen();
            } else if (state is AuthenticationSuccess) {
              print('home');
              return HomeScreen();
            } else {
              print('else');
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
