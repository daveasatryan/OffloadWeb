import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/enums/sign_up_checkbox_validation.dart';
import 'package:therapist_journey/core/data/models/auth/sign_up_model.dart';
import 'package:therapist_journey/core/data/usecases/auth/create_user_usecase.dart';
import 'package:therapist_journey/core/data/utilities/validation_utils.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/create_account/bloc/create_user_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/create_account/bloc/create_user_state.dart';

@injectable
class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  CreateUserBloc(this._createUserUsecase)
      : super(const CreateUserState.validation(
            emailValidation: ValidationEnum.none,
            passwordValidation: ValidationEnum.none,
            signUpCheckboxValidation: SignUpCheckboxValidation.none,
            signUpButton: ButtonValidation.invalid)) {
    on<ValidateEmail>(
      (event, emit) async {
        emailValidation = ValidationEnum.none;

        emit(CreateUserState.validation(
            emailValidation: emailValidation,
            passwordValidation: passwordValidation,
            signUpCheckboxValidation: signUpCheckboxValidation,
            signUpButton: signInButtonValidation));
      },
    );
    on<ValidatePassword>(
      (event, emit) async {
        passwordValidation = ValidationEnum.none;
        emit(
          CreateUserState.validation(
              emailValidation: emailValidation,
              passwordValidation: passwordValidation,
              signUpCheckboxValidation: signUpCheckboxValidation,
              signUpButton: signInButtonValidation),
        );
      },
    );

    on<ValidateCheckBox>(
      (event, emit) {
        if (event.checkbox == true) {
          signUpCheckboxValidation = SignUpCheckboxValidation.valid;
          signInButtonValidation = ButtonValidation.valid;
        } else {
          signInButtonValidation = ButtonValidation.invalid;
          signUpCheckboxValidation = SignUpCheckboxValidation.invalid;
        }

        emit(
          CreateUserState.validation(
            emailValidation: emailValidation,
            passwordValidation: passwordValidation,
            signUpCheckboxValidation: signUpCheckboxValidation,
            signUpButton: signInButtonValidation,
          ),
        );
      },
    );

    on<Validate>(
      (event, emit) async {
        final isEmailValid = ValidationUtils.isValidEmail(event.email);
        final isPassword = ValidationUtils.isValidPassword(event.password);
        if (!isEmailValid) {
          emailValidation = ValidationEnum.invalid;
        }

        if (isEmailValid) {
          emailValidation = ValidationEnum.valid;
        }

        if (event.email.isEmpty) {
          emailValidation = ValidationEnum.empty;
        }

        if (!isPassword) {
          passwordValidation = ValidationEnum.invalid;
        }

        if (isPassword) {
          passwordValidation = ValidationEnum.valid;
        }
        
        if (event.password.isEmpty) {
          passwordValidation = ValidationEnum.empty;
        }

        if (emailValidation != ValidationEnum.valid ||
            passwordValidation != ValidationEnum.valid ||
            signUpCheckboxValidation != SignUpCheckboxValidation.valid) {
          emit(
            CreateUserState.validation(
              emailValidation: emailValidation,
              passwordValidation: passwordValidation,
              signUpCheckboxValidation: signUpCheckboxValidation,
              signUpButton: signInButtonValidation,
            ),
          );
          return;
        }

        (await _createUserUsecase(
          SignUpModel(
            email: event.email,
            password: event.password,
          ),
        ))
            .whenOrNull(
          success: (data) => emit(
            const CreateUserState.success(),
          ),
          error: (msg, errorCode) => emit(
            CreateUserState.error(msg: msg, errorCode: errorCode),
          ),
        );
      },
    );
  }
  ValidationEnum emailValidation = ValidationEnum.none;
  ValidationEnum passwordValidation = ValidationEnum.none;
  ButtonValidation signInButtonValidation = ButtonValidation.invalid;
  SignUpCheckboxValidation signUpCheckboxValidation = SignUpCheckboxValidation.none;

  final CreateUserUsecase _createUserUsecase;
}
