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

  Future<List<String>> loadSurveyIds() async {
    final queryIds = await _firestore.collection('surveys').get();
    final ids = queryIds.docs.map((e) => e.id).toList();
    return ids;
  }

  Future<List<String>> loadTitles(List<String> ids) async {
    final List<String> titles = [];
    for (int i = 0; i < ids.length; i++) {
      final queryTitle =
          await _firestore.collection('surveys').doc(ids[i]).get();
      final title = queryTitle.data()!['title'];
      titles.add(title);
    }
    return titles;
  }

  Future<List<Question>> loadSurvey(String id) async {
    final queryQuestion = await _firestore.collection('surveys').doc(id).get();
    queryQuestion.data();
    final questions = queryQuestion.data()!['questions'];
    print(questions);
    return []; //TODO fix
  }
}
