

import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

User? get currentUser => _auth.currentUser;
Stream<User?> get authState => _auth.authStateChanges();
Future<String?> signUpWithEmail({
  required String email,
  required String password,
}) async {
  try {
    await _auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return null;
  } on FirebaseAuthException catch (e) {
    return e.message.toString();
  }
}

Future<String?> loginWithEmail({
  required String email,required String password
}) async{
  try {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    print('object');
    return null;
  }on FirebaseAuthException catch (e) {
    return e.message.toString();
    
  }
}