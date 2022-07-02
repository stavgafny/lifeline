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
      default:
        return "Having issues resolving authentication";
    }
  }

  static List<String> validate(
      {required String email, required String password}) {
    List<String> requirements = [];
    if (!GetUtils.isEmail(email)) {
      requirements.add("Please enter a valid email");
    }
    if (password.length < _minPasswordLength) {
      requirements.add("Password must be at least 6 characters");
    }

    return requirements;
  }
}
