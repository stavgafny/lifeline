import 'package:form_validators/form_validators.dart';

enum EmailValidationError { empty, invalid }

class EmailValidator extends FormzInput<String, EmailValidationError> {
  const EmailValidator.pure() : super.pure('');
  const EmailValidator.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
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
