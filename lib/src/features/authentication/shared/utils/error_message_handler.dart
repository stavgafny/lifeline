enum ErrorCode {
  invalidEmail,
  wrongPassword,
  emailAlreadyExists,
  userNotFound,
  userDisabled,
  weakPassword,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class ErrorMessageHandler {
  static ErrorCode getErrorCode(String exceptionMessage) {
    switch (exceptionMessage) {
      case "invalid-email":
        return ErrorCode.invalidEmail;

      case "wrong-password":
        return ErrorCode.wrongPassword;

      case "email-already-in-use":
        return ErrorCode.emailAlreadyExists;

      case "user-not-found":
        return ErrorCode.userNotFound;

      case "user-disabled":
        return ErrorCode.userDisabled;

      case "weak-password":
        return ErrorCode.weakPassword;

      case "operation-not-allowed":
        return ErrorCode.operationNotAllowed;

      case "too-many-requests":
        return ErrorCode.tooManyRequests;

      default:
        return ErrorCode.undefined;
    }
  }

  static String generateErrorMessage(ErrorCode code) {
    switch (code) {
      case ErrorCode.invalidEmail:
        return "Oops! Email went rogue. Let's try something more email-ish!";

      case ErrorCode.wrongPassword:
        return "Oops! Looks like password or username are playing hide-and-seek";

      case ErrorCode.emailAlreadyExists:
        return "Another user with this email already exists. maybe it's your evil twin. Spooky";

      case ErrorCode.userNotFound:
        return "Oops! Username not found. Our digital detective is still scratching their head";

      case ErrorCode.userDisabled:
        return "Uh-oh! User temporarily on a break. We miss their digital charm and wit!";

      case ErrorCode.weakPassword:
        return "Uh-oh! Weak password alert! Let's beef it up!";

      case ErrorCode.operationNotAllowed:
        return "Uh-oh! Looks like that operation is a no-go. Our digital bouncers won't let it through";

      case ErrorCode.tooManyRequests:
        return "Whoa! Pump the brakes. Our servers need a breather. You're too speedy!";

      case ErrorCode.undefined:
        return "Something weird happend here";
    }
  }
}
