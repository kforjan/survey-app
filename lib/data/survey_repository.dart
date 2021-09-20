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
              'answer2': e.answer2,
              'answer3': e.answer3,
              'answer4': e.answer4,
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
    final List<dynamic> questionsAsMaps = queryQuestion.data()!['questions'];
    print(questionsAsMaps);
    final questions = questionsAsMaps
        .map(
          (e) => Question(
            question: e['question'],
            answer1: e['answer1'],
            answer2: e['answer2'],
            answer3: e['answer3'],
            answer4: e['answer4'],
          ),
        )
        .toList();
    return questions;
  }

  Future<Map<String, dynamic>?> loadAnswerStatistics(String id) async {
    final queryAnswerStats =
        await _firestore.collection('surveys').doc(id).get();

    try {
      final Map<String, dynamic> answerStats =
          Map.from(queryAnswerStats.data()!['answers']);
      return answerStats;
    } catch (e) {
      return null;
    }
  }

  Future<void> uploadSurveyAnswers(String id, List<int> answers) async {
    for (int i = 0; i < answers.length; i++) {
      if (answers[i] == 1) {
        await _firestore.collection('surveys').doc(id).set(
          {
            'answers': {
              i.toString(): {
                'nAnswers1': FieldValue.increment(1),
                'nAnswers2': FieldValue.increment(0),
                'nAnswers3': FieldValue.increment(0),
                'nAnswers4': FieldValue.increment(0),
              },
            },
          },
          SetOptions(merge: true),
        );
      }
      if (answers[i] == 2) {
        await _firestore.collection('surveys').doc(id).set(
          {
            'answers': {
              i.toString(): {
                'nAnswers1': FieldValue.increment(0),
                'nAnswers2': FieldValue.increment(1),
                'nAnswers3': FieldValue.increment(0),
                'nAnswers4': FieldValue.increment(0),
              }
            },
          },
          SetOptions(merge: true),
        );
      }
      if (answers[i] == 3) {
        await _firestore.collection('surveys').doc(id).set(
          {
            'answers': {
              i.toString(): {
                'nAnswers1': FieldValue.increment(0),
                'nAnswers2': FieldValue.increment(0),
                'nAnswers3': FieldValue.increment(1),
                'nAnswers4': FieldValue.increment(0),
              }
            },
          },
          SetOptions(merge: true),
        );
      }
      if (answers[i] == 4) {
        await _firestore.collection('surveys').doc(id).set(
          {
            'answers': {
              i.toString(): {
                'nAnswers1': FieldValue.increment(0),
                'nAnswers2': FieldValue.increment(0),
                'nAnswers3': FieldValue.increment(0),
                'nAnswers4': FieldValue.increment(1),
              }
            },
          },
          SetOptions(merge: true),
        );
      }
    }
  }
}
