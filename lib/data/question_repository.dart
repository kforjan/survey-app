import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionRepository {
  QuestionRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Future<void> uploadQuestions() async {
    try {
      _firestore.collection('surveys').doc('s').set({'lol': 'lolll'});
    } catch (e) {
      throw e;
    }
  }
}
