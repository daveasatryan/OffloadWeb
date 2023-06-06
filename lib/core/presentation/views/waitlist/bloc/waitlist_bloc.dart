import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/models/wait_list/wait_list_model.dart';
import 'package:therapist_journey/core/data/usecases/content/wait_list_usecase.dart';
import 'package:therapist_journey/core/data/utilities/validation_utils.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/bloc/waitlist_.event.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/bloc/waitlist_.state.dart';

@injectable
class WaitlistBloc extends Bloc<WaitlistEvent, WaitlistState> {
  WaitlistBloc(this._waitlistUsecase)
      : super(const WaitlistState.validation(
          emailValidation: ValidationEnum.none,
          buttonValidation: ButtonValidation.invalid,
          changeWidget: false,
        )) {
    on<ValidateEmailWaitlist>(
      (event, emit) {
        emailValidation = ValidationEnum.none;
        if (event.email.isNotEmpty) {
          button = ButtonValidation.valid;
        } else {
          button = ButtonValidation.invalid;
        }
        emit(
          WaitlistState.validation(
            emailValidation: emailValidation,
            buttonValidation: button,
            changeWidget: false,
          ),
        );
      },
    );

    on<ValidateButtonWaitlist>(
      (event, emit) async {
        final isEmailValid = ValidationUtils.isValidEmail(event.email);

        if (!isEmailValid) {
          emailValidation = ValidationEnum.invalid;
        }
        
        if (isEmailValid) {
          emailValidation = ValidationEnum.valid;
        }

        if (event.email.isEmpty) {
          emailValidation = ValidationEnum.empty;
        }

        if (emailValidation != ValidationEnum.valid) {
          emit(
            WaitlistState.validation(
              emailValidation: emailValidation,
              buttonValidation: button,
              changeWidget: false,
            ),
          );
          return;
        }

        (await _waitlistUsecase(WaitlistModel(
          email: event.email,
          isTherapist: true,
        )))
            .whenOrNull(
          success: (data) {
            emit(
              WaitlistState.validation(
                emailValidation: emailValidation,
                buttonValidation: button,
                changeWidget: true,
              ),
            );
          },
          error: (msg, errorCode) {
            emit(
              WaitlistState.error(msg: msg, errorCode: errorCode),
            );
          },
        );
      },
    );
  }
  ValidationEnum emailValidation = ValidationEnum.none;
  ButtonValidation button = ButtonValidation.invalid;

  final WaitlistUsecase _waitlistUsecase;
}
