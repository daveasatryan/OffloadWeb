import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/models/auth/new_password_model.dart';
import 'package:therapist_journey/core/data/usecases/auth/new_password_usecase.dart';
import 'package:therapist_journey/core/data/utilities/validation_utils.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/new_password/bloc/new_password_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/new_password/bloc/new_password_state.dart';

@injectable
class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  NewPasswordBloc(this._newPasswordUsecase)
      : super(const NewPasswordState.validation(
            passwordValidation: ValidationEnum.none,
            confirmPasswordValidation: ValidationEnum.none,
            buttonValidation: ButtonValidation.invalid)) {
    on<ValidateNewPassword>((event, emit) {
      passwordValidation = ValidationEnum.none;

      if (event.password.isNotEmpty && event.confirmNassword.isNotEmpty) {
        buttonValidation = ButtonValidation.valid;
      } else {
        buttonValidation = ButtonValidation.invalid;
      }
      emit(NewPasswordState.validation(
        passwordValidation: passwordValidation,
        confirmPasswordValidation: confirmPasswordValidation,
        buttonValidation: buttonValidation,
      ));
    });

    on<ValidateConfirmNewPassword>((event, emit) {
      confirmPasswordValidation = ValidationEnum.none;

      if (event.password.isNotEmpty && event.confirmNassword.isNotEmpty) {
        buttonValidation = ButtonValidation.valid;
      } else {
        buttonValidation = ButtonValidation.invalid;
      }
      emit(NewPasswordState.validation(
        passwordValidation: passwordValidation,
        confirmPasswordValidation: confirmPasswordValidation,
        buttonValidation: buttonValidation,
      ));
    });

    on<ValidateButton>((event, emit) async {
      final isPassword = ValidationUtils.isValidPassword(event.password);

      if (!isPassword) {
        passwordValidation = ValidationEnum.invalid;
      }

      if (isPassword) {
        passwordValidation = ValidationEnum.valid;
      }

      if (event.password.isEmpty) {
        passwordValidation = ValidationEnum.empty;
      }

      if (event.confirmNassword.isEmpty) {
        confirmPasswordValidation = ValidationEnum.empty;
      }

      if (event.password != event.confirmNassword || event.confirmNassword.isEmpty) {
        confirmPasswordValidation = ValidationEnum.invalid;
      }

      if (event.password == event.confirmNassword || event.confirmNassword.isEmpty) {
        confirmPasswordValidation = ValidationEnum.valid;
      }

      if (passwordValidation != ValidationEnum.valid ||
          confirmPasswordValidation != ValidationEnum.valid) {
        emit(NewPasswordState.validation(
          passwordValidation: passwordValidation,
          confirmPasswordValidation: confirmPasswordValidation,
          buttonValidation: buttonValidation,
        ));
        return;
      }
      (await _newPasswordUsecase(
        NewPasswordModel(
          code: event.code,
          password: event.password,
        ),
      ))
          .whenOrNull(
        success: (data) {
          emit(
            NewPasswordState.success(
              data?.result,
            ),
          );
        },
        error: (msg, errorCode) => emit(
          NewPasswordState.error(
            msg: msg,
            errorCode: errorCode,
          ),
        ),
      );
    });
  }

  ValidationEnum passwordValidation = ValidationEnum.none;
  ValidationEnum confirmPasswordValidation = ValidationEnum.none;
  ButtonValidation buttonValidation = ButtonValidation.invalid;
  final NewPasswordUsecase _newPasswordUsecase;
}
