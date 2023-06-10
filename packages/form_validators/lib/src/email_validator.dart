import './form_validator.dart';

enum EmailValidationError { empty, missingAt, missingDot, invalid }

class EmailValidator extends FormValidator<String, EmailValidationError> {
  const EmailValidator.pure([String value = ""]) : super.pure(value);
  const EmailValidator.dirty([String value = ""]) : super.dirty(value);

  @override
  EmailValidationError? validate() {
    if (value.isEmpty) return EmailValidationError.empty;
    if (!value.contains('@')) return EmailValidationError.missingAt;
    if (!value.contains('.')) return EmailValidationError.missingDot;
    if (!_regex.hasMatch(value)) return EmailValidationError.invalid;

    return null;
  }

  static String? getErrorMessage(EmailValidationError? error) {
    switch (error) {
      case null:
        return null;
      case EmailValidationError.empty:
        return "Empty email";
      case EmailValidationError.missingAt:
        return "Missing '@'";
      case EmailValidationError.missingDot:
        return "Missing dot";
      case EmailValidationError.invalid:
        return "Invalid email";
    }
  }
}

final _regex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
