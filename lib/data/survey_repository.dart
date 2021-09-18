import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:survey_app/models/question.dart';

class SurveyRepository {
  SurveyRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Future<void> uploadSurvey(String title, List<Question> questions) async {
    final jsonQuestions = questions
        .map((e) => {
              'question': e.question,
              'answer1': e.answer1,
              'answer2': e.answer1,
              'answer3': e.answer1,
              'answer4': e.answer1,
            })
        .toList();
    try {
      _firestore.collection('surveys').doc().set({
        'title': title,
        'questions': jsonQuestions,
      });
    } catch (e) {
      throw e;
    }
  }
}
