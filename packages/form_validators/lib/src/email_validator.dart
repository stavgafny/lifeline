import './form_validator.dart';

enum EmailValidationError { empty, invalid }

class EmailValidator extends FormValidator<String, EmailValidationError> {
  const EmailValidator.pure([String value = ""]) : super.pure(value);
  const EmailValidator.dirty([String value = ""]) : super.dirty(value);

  @override
  EmailValidationError? validate() {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    } else if (!_regex.hasMatch(value)) {
      return EmailValidationError.invalid;
    }
    return null;
  }

  static String? getErrorMessage(EmailValidationError? error) {
    if (error == EmailValidationError.empty) {
      return 'Empty email';
    } else if (error == EmailValidationError.invalid) {
      return 'Invalid email';
    }
    return null;
  }
}

final _regex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
