import './form_validator.dart';

enum PasswordValidationError { empty, short }

class PasswordValidator extends FormValidator<String, PasswordValidationError> {
  const PasswordValidator.pure([String value = ""]) : super.pure(value);
  const PasswordValidator.dirty([String value = ""]) : super.dirty(value);

  @override
  PasswordValidationError? validate() {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.length < _minLength) {
      return PasswordValidationError.short;
    }
    return null;
  }

  static String? getErrorMessage(PasswordValidationError? error) {
    if (error == PasswordValidationError.empty) {
      return 'Empty password';
    } else if (error == PasswordValidationError.short) {
      return 'Password too short';
    }
    return null;
  }
}

const _minLength = 6;
