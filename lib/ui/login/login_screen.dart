import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEmailTextField(),
              _buildPasswordTextField(),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Sign in'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Don\'t have an account? Register here'),
              ),
            ],
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
        helperText: '',
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
      textInputAction: TextInputAction.done,
      controller: _passwordController,
      focusNode: _passwordFocusNode,
    );
  }
}
