import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionRepository {
  QuestionRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Future<void> uploadQuestions() async {
    _firestore.collection('surveys').doc().set({'lol': 'lolll'});
  }
}
