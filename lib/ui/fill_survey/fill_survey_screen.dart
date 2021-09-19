import 'package:flutter/material.dart';

class FillSurveyScreen extends StatelessWidget {
  const FillSurveyScreen({
    required this.id,
    required this.title,
    Key? key,
  }) : super(key: key);

  final String id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
    );
  }
}
