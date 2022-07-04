import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

const _minPasswordLength = 6;

class EmailPasswordAuth {
  /// Return informative message from given error code
  ///
  /// * Error Codes: [ invalid-email, user-disabled, user-not-found, wrong-password ]
  ///
  /// Error codes are from FirebaseAuthException
  static String getErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Not a valid email format';
      case 'user-not-found':
        continue invalidCredentials;
      case 'user-disabled':
        return 'It seems that this user has been disabled';
      invalidCredentials:
      case 'wrong-password':
        return "Check your email/password and try again";
      // Register errors
      case "weak-password":
        return "Password is too weak";
      case "email-already-in-use":
        return "Email already in use";

      default:
        return "Having issues resolving authentication";
    }
  }

  static List<String> validate({
    required String email,
    required String password,
    String? confirmPassword,
  }) {
    List<String> requirements = [];
    if (!GetUtils.isEmail(email)) {
      requirements.add("Please enter a valid email");
    }
    if (password.length < _minPasswordLength) {
      requirements.add("Password must be at least 6 characters");
    }
    if (confirmPassword != null) {
      if (confirmPassword != password) {
        requirements.add("Password and Confirm Password does not match");
      }
    }

    return requirements;
  }

  static Future<String?> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return await Future.delayed(const Duration(seconds: 1)).then((value) {
        return getErrorMessage(e.code);
      });
    }
    return null;
  }

  static Future<String?> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return await Future.delayed(const Duration(seconds: 1)).then((value) {
        return getErrorMessage(e.code);
      });
    }
    return null;
  }
}
