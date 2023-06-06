import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/name_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/enums/sign_up_checkbox_validation.dart';
import 'package:therapist_journey/core/data/utilities/validation_utils.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/call_confirm/bloc/call_confirm_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/call_confirm/bloc/call_confirm_state.dart';

@injectable
class CallConfirmBloc extends Bloc<CallConfirmBlocEvent, CallConfirmBlocState> {
  CallConfirmBloc()
      : super(const CallConfirmBlocState.validation(
            emailValidation: ValidationEnum.none,
            nameValidation: NameValidation.none,
            checkboxValidation: SignUpCheckboxValidation.none,
            buttonValidation: ButtonValidation.invalid)) {
    on<ValidateEmailEvent>(
      (event, emit) {
        emailValidation = ValidationEnum.none;
        emit(CallConfirmBlocState.validation(
          emailValidation: emailValidation,
          nameValidation: nameValidation,
          checkboxValidation: checkboxValidation,
          buttonValidation: buttonValidation,
        ));
      },
    );
    on<ValidateNameEvent>(
      (event, emit) {
        nameValidation = NameValidation.none;
        emit(
          CallConfirmBlocState.validation(
            emailValidation: emailValidation,
            nameValidation: nameValidation,
            checkboxValidation: checkboxValidation,
            buttonValidation: buttonValidation,
          ),
        );
      },
    );

    on<ValidateCheckBoxEvent>(
      (event, emit) {
        if (event.checkbox == true) {
          buttonValidation = ButtonValidation.valid;
        } else {
          buttonValidation = ButtonValidation.invalid;
        }

        emit(
          CallConfirmBlocState.validation(
            emailValidation: emailValidation,
            nameValidation: nameValidation,
            checkboxValidation: checkboxValidation,
            buttonValidation: buttonValidation,
          ),
        );
      },
    );
    on<ValidateButtonEvent>(
      (event, emit) async {
        final isEmail = ValidationUtils.isValidEmail(event.email);
        if (event.name.isEmpty) {
          nameValidation = NameValidation.empty;
        }
        if (event.name.isNotEmpty) {
          emailValidation = ValidationEnum.valid;
        }
        if (!isEmail) {
          emailValidation = ValidationEnum.invalid;
        }
        if (isEmail) {
          emailValidation = ValidationEnum.valid;
        }
        if (event.email.isEmpty) {
          emailValidation = ValidationEnum.empty;
        }
        if (emailValidation != ValidationEnum.valid && nameValidation != NameValidation.valid) {
          emit(
            CallConfirmBlocState.validation(
              emailValidation: emailValidation,
              nameValidation: nameValidation,
              checkboxValidation: checkboxValidation,
              buttonValidation: buttonValidation,
            ),
          );
          return;
        }
      },
    );
  }

  ValidationEnum emailValidation = ValidationEnum.none;
  NameValidation nameValidation = NameValidation.none;
  ButtonValidation buttonValidation = ButtonValidation.invalid;
  SignUpCheckboxValidation checkboxValidation = SignUpCheckboxValidation.none;
}
