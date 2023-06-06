enum SignUpCheckboxValidation {
  none,
  valid,
  invalid;
  String? get errorMassage {
    switch (this) {
      case SignUpCheckboxValidation.valid:
        return null;
      case SignUpCheckboxValidation.invalid:
        return 'invalid';
      case SignUpCheckboxValidation.none:
        return null;
    }
  }
}
