import 'package:form_validators/form_validators.dart';

enum PasswordValidationError { empty, short }

class PasswordValidator extends FormzInput<String, PasswordValidationError> {
  static const _minLength = 6;

  const PasswordValidator.pure() : super.pure('');
  const PasswordValidator.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
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
