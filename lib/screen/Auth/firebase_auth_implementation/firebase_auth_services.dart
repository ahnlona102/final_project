import 'package:firebase_auth/firebase_auth.dart';
import 'package:IntelliHome/global/common/toast.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // SIGN UP FUNCTION
  Future<User?> signUpWithEmailAndPassword(
      String email,
      String password,
      ) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'Email đã tồn tại.');
      } else {
        showToast(message: 'Có lỗi đã xảy ra: ${e.code}');
      }
    }
    return null;
  }

  // LOGIN FUNCTION
  Future<User?> signInWithEmailAndPassword(
      String email,
      String password,
      ) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Sai email hoặc password.');
      } else {
        showToast(message: 'Có lỗi đã xảy ra: ${e.code}');
      }
    }
    return null;
  }
}