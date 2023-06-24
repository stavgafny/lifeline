enum AuthError {
  invalidEmail(
    code: "invalid-email",
    message: "Oops! Email went rogue. Let's try something more email-ish!",
  ),
  wrongPassword(
    code: "wrong-password",
    message: "Oops! Looks like password or username are playing hide-and-seek",
  ),
  emailAlreadyExists(
    code: "email-already-in-use",
    message:
        "Another user with this email already exists. maybe it's your evil twin. Spooky",
  ),
  userNotFound(
    code: "user-not-found",
    message:
        "Oops! Username not found. Our digital detective is still scratching their head",
  ),
  userDisabled(
    code: "user-disabled",
    message:
        "Uh-oh! User temporarily on a break. We miss their digital charm and wit!",
  ),
  weakPassword(
    code: "weak-password",
    message: "Uh-oh! Weak password alert! Let's beef it up!",
  ),
  operationNotAllowed(
    code: "operation-not-allowed",
    message:
        "Uh-oh! Looks like that operation is a no-go. Our digital bouncers won't let it through",
  ),
  tooManyRequests(
    code: "too-many-requests",
    message:
        "Whoa! Pump the brakes. Our servers need a breather. You're too speedy!",
  ),
  undefined(
    code: "undefined",
    message: "Something weird happend here",
  );

  const AuthError({required this.code, required this.message});
  final String code;
  final String message;
}

class AuthErrorHandler {
  static AuthError getErrorFromCode(String errorCode) {
    final idx = AuthError.values.map((e) => e.code).toList().indexOf(errorCode);
    return idx != -1 ? AuthError.values[idx] : AuthError.undefined;
  }
}
