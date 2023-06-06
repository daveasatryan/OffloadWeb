enum CodeValidation {
  valid,
  empty,
  invalid;

  String? get errorMassage {
    switch (this) {
      case CodeValidation.valid:
        return null;
      case CodeValidation.empty:
        return 'required field';
      case CodeValidation.invalid:
        return 'required field';
    }
  }
}
