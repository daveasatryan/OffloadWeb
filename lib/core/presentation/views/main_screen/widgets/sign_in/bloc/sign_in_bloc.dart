import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/models/auth/sign_in_model.dart';
import 'package:therapist_journey/core/data/usecases/auth/sign_in_usecase.dart';
import 'package:therapist_journey/core/data/utilities/app_constants.dart';
import 'package:therapist_journey/core/data/utilities/validation_utils.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/sign_in/bloc/sign_in_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/sign_in/bloc/sign_in_state.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._signInUsecase)
      : super(
          const SignInState.validation(
              email: ValidationEnum.none,
              password: ValidationEnum.none,
              signInButton: ButtonValidation.invalid),
        ) {
    on<ValidateEmail>((event, emit) {
      emailValidation = ValidationEnum.none;

      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        signInButton = ButtonValidation.valid;
      } else {
        signInButton = ButtonValidation.invalid;
      }

      emit(SignInState.validation(
          email: emailValidation, password: passwordValidation, signInButton: signInButton));
    });

    on<ValidatePassword>((event, emit) {
      passwordValidation = ValidationEnum.none;

      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        signInButton = ButtonValidation.valid;
      } else {
        signInButton = ButtonValidation.invalid;
      }

      emit(SignInState.validation(
          email: emailValidation, password: passwordValidation, signInButton: signInButton));
    });

    on<Validate>(
      (event, emit) async {
        final isEmailValid = ValidationUtils.isValidEmail(event.email);
        final isPasswordValid = ValidationUtils.isValidPassword(event.password);

        if (!isEmailValid) {
          emailValidation = ValidationEnum.invalid;
        }

        if (isEmailValid) {
          emailValidation = ValidationEnum.valid;
        }

        if (event.email.isEmpty) {
          emailValidation = ValidationEnum.empty;
        }

        if (event.password.isEmpty) {
          passwordValidation = ValidationEnum.empty;
        }

        if (isPasswordValid) {
          passwordValidation = ValidationEnum.valid;
        }

        if (!isPasswordValid) {
          passwordValidation = ValidationEnum.invalid;
        }
        if (emailValidation != ValidationEnum.valid || passwordValidation != ValidationEnum.valid) {
          emit(
            SignInState.validation(
              email: emailValidation,
              password: passwordValidation,
              signInButton: signInButton,
            ),
          );
          return;
        }
        (await _signInUsecase(
          SignInModel(
            email: event.email,
            password: event.password,
          ),
        ))
            .whenOrNull(
          success: (data) {
            emit(
              SignInState.success(
                data?.result,
              ),
            );
          },
          error: (msg, errorCode) {
            if (errorCode == AppConstants.invalidEmailCode) {
              emit(
                SignInState.validation(
                  email: emailValidation,
                  password: passwordValidation,
                  signInButton: signInButton,
                  errorText: AppStrings.weCannotFindText,
                ),
              );
              return;
            } else if (errorCode == AppConstants.invalidEmailCode) {
              emit(
                SignInState.validation(
                  email: emailValidation,
                  password: passwordValidation,
                  signInButton: signInButton,
                  errorText: AppStrings.weCannotFindText,
                ),
              );
              return;
            }
            emit(
              SignInState.error(msg: msg, errorCode: errorCode),
            );
          },
        );
      },
    );
  }

  ValidationEnum emailValidation = ValidationEnum.none;
  ValidationEnum passwordValidation = ValidationEnum.none;
  ButtonValidation signInButton = ButtonValidation.invalid;

  final SignInUsecase _signInUsecase;
}
