import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/blocs/authentication_bloc/authentication_bloc.dart';

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
                Expanded(
                  child: Container(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: InkWell(
                          onTap: () {},
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
                          onTap: () {},
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
