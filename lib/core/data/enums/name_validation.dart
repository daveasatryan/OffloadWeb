import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';

enum NameValidation {
  none,
  valid,
  empty;

  String? get errorMessage {
    switch (this) {
      case NameValidation.valid:
        return null;
      case NameValidation.empty:
        return AppStrings.thisFieldIsRequired;
      case NameValidation.none:
        return null;
    }
  }
}
