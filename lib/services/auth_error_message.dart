/// More informative message about erorr to corresponding authentication exception
class AuthErrorMessage {
  /// Return informative message from given error code
  ///
  /// * Error Codes: [ invalid-email, user-disabled, user-not-found, wrong-password ]
  ///
  /// Error codes are from FirebaseAuthException
  static String emailPassword(String code) {
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
}
