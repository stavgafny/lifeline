import './form_validator.dart';

enum NameValidationError { empty, short, long, invalid }

class NameValidator extends FormValidator<String, NameValidationError> {
  const NameValidator([String value = "", bool needsValidation = false])
      : super(value, needsValidation);

  @override
  NameValidationError? validate() {
    if (value.isEmpty) {
      return NameValidationError.empty;
    } else if (value.length < _minLength) {
      return NameValidationError.short;
    } else if (value.length > _maxLength) {
      return NameValidationError.long;
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
    } else if (error == NameValidationError.long) {
      return 'Name too long';
    } else if (error == NameValidationError.invalid) {
      return 'Invalid name';
    }
    return null;
  }
}

const _minLength = 3;
const _maxLength = 20;
final _regex = RegExp(r'^[A-Za-z]+( [A-Za-z]+)?$');
