import 'package:form_validators/form_validators.dart';

enum NameValidationError { empty, short, invalid }

class NameValidator extends FormzInput<String, NameValidationError> {
  static const _minLength = 3;

  const NameValidator.pure() : super.pure('');
  const NameValidator.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.empty;
    } else if (value.length < _minLength) {
      return NameValidationError.short;
    } else if (!_regex.hasMatch(value)) {
      return NameValidationError.invalid;
    }
    return null;
  }

  static String? getErrorMessage(NameValidationError? error) {
    if (error == NameValidationError.empty) {
      return 'Empty name';
    } else if (error == NameValidationError.short) {
      return 'Name too short';
    } else if (error == NameValidationError.invalid) {
      return 'Invalid name';
    }
    return null;
  }
}

final _regex = RegExp(r'^[A-Za-z]+$');
