import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/models/auth/forget_password_model.dart';
import 'package:therapist_journey/core/data/usecases/auth/forget_password_usecase.dart';
import 'package:therapist_journey/core/data/utilities/app_constants.dart';
import 'package:therapist_journey/core/data/utilities/validation_utils.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/forget_password/bloc/forget_password_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/forget_password/bloc/forget_password_state.dart';

@injectable
class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc(this._forgetPasswordUsecase)
      : super(const ForgetPasswordState.validation(
            emailValidation: ValidationEnum.none, buttonValidation: ButtonValidation.invalid)) {
    on<ValidateEmail>((event, emit) {
      emailValidation = ValidationEnum.none;
      if (event.email.isNotEmpty) {
        buttonValidation = ButtonValidation.valid;
      } else {
        buttonValidation = ButtonValidation.invalid;
      }

      emit(ForgetPasswordState.validation(
        emailValidation: emailValidation,
        buttonValidation: buttonValidation,
      ));
    });

    on<ForgetPasswordButton>((event, emit) async {
      final isValidEmail = ValidationUtils.isValidEmail(event.email);

      if (!isValidEmail) {
        emailValidation = ValidationEnum.invalid;
      }

      if (isValidEmail) {
        emailValidation = ValidationEnum.valid;
      }

      if (event.email.isEmpty) {
        emailValidation = ValidationEnum.empty;
      }

      if (emailValidation != ValidationEnum.valid) {
        emit(ForgetPasswordState.validation(
          emailValidation: emailValidation,
          buttonValidation: buttonValidation,
        ));
        return;
      }
      (await _forgetPasswordUsecase(
        ForgotEmailRequestModel(
          email: event.email,
        ),
      ))
          .whenOrNull(
              success: (data) => emit(
                    const ForgetPasswordState.success(),
                  ),
              error: (msg, errorCode) {
                if (errorCode == AppConstants.invalidEmailCode) {
                  emit(
                    ForgetPasswordState.validation(
                      emailValidation: emailValidation,
                      buttonValidation: buttonValidation,
                      errorText: AppStrings.weCannotFindText,
                    ),
                  );
                  return;
                }
                emit(
                  ForgetPasswordState.error(msg: msg, errorCode: errorCode),
                );
              });
    });
  }

  ValidationEnum emailValidation = ValidationEnum.none;
  ButtonValidation buttonValidation = ButtonValidation.invalid;
  final ForgetPasswordUsecase _forgetPasswordUsecase;
}
