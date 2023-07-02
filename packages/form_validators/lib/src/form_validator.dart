enum FormSubmissionStatus { init, progress, failure, success }

abstract class FormValidator<T, E extends Enum> {
  final T value;
  final bool _errorPresent;

  const FormValidator.pure(this.value) : _errorPresent = false;
  const FormValidator.dirty(this.value) : _errorPresent = true;

  E? get error => _errorPresent ? validate() : null;

  E? validate();

  /// Returns true if all validators are valid, false otherwise
  static bool validateAll(List<FormValidator> validators) {
    for (final validator in validators) {
      if (validator.validate() != null) return false;
    }
    return true;
  }
}
