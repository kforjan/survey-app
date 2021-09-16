import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  UserRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Future<bool> get isSignedIn async {
    final currentUser = _firebaseAuth.currentUser;

    return currentUser != null;
  }

  Future<UserCredential> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> register(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<User?> get currentUser async {
    return _firebaseAuth.currentUser;
  }
}
