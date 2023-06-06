
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';

enum ButtonValidation { valid, invalid;
 String? get errorMassage {

    switch (this) {
      case ButtonValidation.valid:
        return null;
      case ButtonValidation.invalid:
        return AppStrings.inputErrorText;
    }
  }
 }