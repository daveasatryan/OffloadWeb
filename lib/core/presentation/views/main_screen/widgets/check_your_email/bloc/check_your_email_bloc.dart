import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/code_validoation.dart';
import 'package:therapist_journey/core/data/usecases/auth/check_code_new_password_usecase.dart';
import 'package:therapist_journey/core/data/usecases/auth/check_verify_code_email_usecase.dart';
import 'package:therapist_journey/core/data/utilities/app_constants.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/check_your_email/bloc/check_your_email_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/check_your_email/bloc/check_your_email_state.dart';

@injectable
class CheckYourEmailBloc extends Bloc<CheckYourEmailEvent, CheckYourEmailState> {
  CheckYourEmailBloc(this._checkYourCodeUsecase, this._checkYourVerifyCodeUsecase)
      : super(const CheckYourEmailState.validation(
            buttonValidation: ButtonValidation.invalid, codeValidoation: CodeValidation.empty)) {
    on<CheckYourCode>((event, emit) {
      if (event.code.isEmpty) {
        codeValidation = CodeValidation.empty;
        buttonValidation = ButtonValidation.invalid;
      } else if (event.code.length == 5) {
        buttonValidation = ButtonValidation.valid;
        codeValidation = CodeValidation.valid;
      } else {
        codeValidation = CodeValidation.invalid;
        buttonValidation = ButtonValidation.invalid;
      }

      emit(CheckYourEmailState.validation(
        codeValidoation: codeValidation,
        buttonValidation: buttonValidation,
      ));
    });

    on<CheckYourCodeForgetPasswordButton>(
      (event, emit) async {
        if (codeValidation != CodeValidation.valid) {
          emit(CheckYourEmailState.validation(
            codeValidoation: codeValidation,
            buttonValidation: buttonValidation,
          ));
          return;
        }
        (await _checkYourCodeUsecase(
          event.code,
        ))
            .whenOrNull(
          success: (data) => emit(
            const CheckYourEmailState.success(),
          ),
          error: (msg, errorCode) {
            if (errorCode == AppConstants.invalidEmailCode) {
              emit(
                CheckYourEmailState.validation(
                  codeValidoation: codeValidation,
                  buttonValidation: buttonValidation,
                  errorText: AppStrings.weCannotFindText,
                ),
              );
              return;
            }
            emit(
              CheckYourEmailState.error(
                msg: msg,
                errorCode: errorCode,
              ),
            );
          },
        );
      },
    );

    on<CheckYourVerifyCodeButton>(
      (event, emit) async {
        if (codeValidation != CodeValidation.valid) {
          emit(CheckYourEmailState.validation(
            codeValidoation: codeValidation,
            buttonValidation: buttonValidation,
          ));
          return;
        }
        (await _checkYourVerifyCodeUsecase(
          event.code,
        ))
            .whenOrNull(
          success: (data) {
            emit(
              CheckYourEmailState.success(
                userModel: data?.result,
              ),
            );
          },
          error: (msg, errorCode) {
            if (errorCode == AppConstants.invalidEmailCode) {
              emit(
                CheckYourEmailState.validation(
                  codeValidoation: codeValidation,
                  buttonValidation: buttonValidation,
                  errorText: AppStrings.weCannotFindText,
                ),
              );
              return;
            }
            emit(
              CheckYourEmailState.error(msg: msg, errorCode: errorCode),
            );
          },
        );
      },
    );
  }

  ButtonValidation buttonValidation = ButtonValidation.invalid;
  CodeValidation codeValidation = CodeValidation.empty;
  final CheckYourCodeUsecase _checkYourCodeUsecase;
  final CheckYourVerifyCodeUsecase _checkYourVerifyCodeUsecase;
}
