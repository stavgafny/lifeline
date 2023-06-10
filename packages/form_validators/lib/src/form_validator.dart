abstract class FormValidator<T, E extends Enum> {
  final T value;
  final bool _needsToValidate;

  const FormValidator.pure(this.value) : _needsToValidate = false;
  const FormValidator.dirty(this.value) : _needsToValidate = true;

  E? get error => _needsToValidate ? validate() : null;

  E? validate();

  /// Returns true if all validators are valid, false otherwise
  static bool validateAll(List<FormValidator> validators) {
    for (final validator in validators) {
      if (validator.validate() != null) return false;
    }
    return true;
  }
}
