abstract class FormValidator<T, E extends Enum> {
  final T value;
  final bool needsValidation;

  const FormValidator(this.value, [this.needsValidation = false]);

  E? get error => needsValidation ? validate() : null;

  E? validate();

  /// Returns true if all validators are valid, false otherwise
  static bool validateAll(List<FormValidator> validators) {
    for (final validator in validators) {
      if (validator.validate() != null) return false;
    }
    return true;
  }
}
