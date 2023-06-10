import './form_validator.dart';

enum NameValidationError { empty, short, long, invalid }

class NameValidator extends FormValidator<String, NameValidationError> {
  const NameValidator.pure([String value = ""]) : super.pure(value);
  const NameValidator.dirty([String value = ""]) : super.dirty(value);

  @override
  NameValidationError? validate() {
    if (value.isEmpty) return NameValidationError.empty;
    if (value.length < _minLength) return NameValidationError.short;
    if (value.length > _maxLength) return NameValidationError.long;
    if (!_regex.hasMatch(value)) return NameValidationError.invalid;

    return null;
  }

  static String? getErrorMessage(NameValidationError? error) {
    switch (error) {
      case null:
        return null;
      case NameValidationError.empty:
        return 'Empty name';
      case NameValidationError.short:
        return 'Name too short';
      case NameValidationError.long:
        return 'Name too long';
      case NameValidationError.invalid:
        return 'Invalid name';
    }
  }
}

const _minLength = 3;
const _maxLength = 20;
final _regex = RegExp(r'^[A-Za-z]+( [A-Za-z]+)?$');
