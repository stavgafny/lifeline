import './form_validator.dart';

enum PasswordValidationError { empty, short }

class PasswordValidator extends FormValidator<String, PasswordValidationError> {
  const PasswordValidator.pure([String value = ""]) : super.pure(value);
  const PasswordValidator.dirty([String value = ""]) : super.dirty(value);

  @override
  PasswordValidationError? validate() {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value.length < _minLength) return PasswordValidationError.short;
    return null;
  }

  static String? getErrorMessage(PasswordValidationError? error) {
    switch (error) {
      case null:
        return null;
      case PasswordValidationError.empty:
        return 'Empty password';
      case PasswordValidationError.short:
        return 'Password too short';
    }
  }
}

const _minLength = 6;
