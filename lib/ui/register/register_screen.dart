import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/blocs/authentication_bloc/authentication_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationFailure) {
            showDialog(
              context: context,
              builder: (cotnext) => AlertDialog(
                content: Text('Wrong e-mail or password'),
              ),
            );
          }
        },
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildEmailTextField(),
                _buildPasswordTextField(),
                _buildPasswordConfirmTextField(),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    print(_email);
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      Register(
                          email: _email,
                          password: _password,
                          confirmPassword: _confirmPassword),
                    );
                  },
                  child: Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Already have an account? Sign in here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'e-mail',
        hintText: 'example@email.com',
      ),
      onChanged: (value) => _email = value.trim(),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      controller: _emailController,
      focusNode: _emailFocusNode,
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'password',
      ),
      onChanged: (value) => _password = value.trim(),
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      obscureText: true,
      textInputAction: TextInputAction.next,
      controller: _passwordController,
      focusNode: _passwordFocusNode,
    );
  }

  TextField _buildPasswordConfirmTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'confirm password',
      ),
      onChanged: (value) => _confirmPassword = value.trim(),
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      obscureText: true,
      textInputAction: TextInputAction.done,
      controller: _confirmPasswordController,
      focusNode: _confirmPasswordFocusNode,
    );
  }
}
