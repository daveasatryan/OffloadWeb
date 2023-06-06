import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';

enum ValidationEnum {
  none,
  valid,
  empty,
  invalid;

  String? get errorMassagePassword {
    switch (this) {
      case ValidationEnum.valid:
        return null;
      case ValidationEnum.empty:
        return AppStrings.thisFieldIsRequired;
      case ValidationEnum.invalid:
        return AppStrings.invalidPasswordText;
      case ValidationEnum.none:
        return null;
    }
  }
    String? get errorMassageConfirmPassword {
    switch (this) {
      case ValidationEnum.valid:
        return null;
      case ValidationEnum.empty:
        return AppStrings.thisFieldIsRequired;
      case ValidationEnum.invalid:
        return AppStrings.invalidfield;
      case ValidationEnum.none:
        return null;
    }
  }
   String? get errorMessageEmail {
    switch (this) {
      case ValidationEnum.valid:
        return null;
      case ValidationEnum.empty:
        return AppStrings.thisFieldIsRequired;
      case ValidationEnum.invalid:
        return AppStrings.invalidEmailText;
      case ValidationEnum.none:
        return null;
    }
  }
}