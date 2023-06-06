import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/models/wait_list/wait_list_model.dart';
import 'package:therapist_journey/core/data/usecases/content/wait_list_usecase.dart';
import 'package:therapist_journey/core/data/utilities/validation_utils.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/widgets/join_therapist_dialog/bloc/join_therapist_dialog_event.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/widgets/join_therapist_dialog/bloc/join_therapist_dialog_state.dart';

@injectable
class JoinTherapistDialogBloc extends Bloc<JoinTherapistDialogEvent, JoinTherapistDialogState> {
  JoinTherapistDialogBloc(this._waitlistUsecase)
      : super(
          const JoinTherapistDialogState.validation(
              email: ValidationEnum.none, joinButton: ButtonValidation.invalid),
        ) {
    on<ValidateEmailJoin>((event, emit) {
      emailValidation = ValidationEnum.none;
      if (event.email.isNotEmpty) {
        joinButton = ButtonValidation.valid;
      } else {
        joinButton = ButtonValidation.invalid;
      }

      emit(
        JoinTherapistDialogState.validation(email: emailValidation, joinButton: joinButton),
      );
    });

    on<ValidateJoin>(
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
            JoinTherapistDialogState.validation(
              email: emailValidation,
              joinButton: joinButton,
            ),
          );
          return;
        }

        (await _waitlistUsecase(WaitlistModel(
          email: event.email,
          isTherapist: false,
        )))
            .whenOrNull(
          success: (data) {
            emit(
              JoinTherapistDialogState.success(),
            );
          },
          error: (msg, errorCode) {
            emit(
              JoinTherapistDialogState.error(msg: msg, errorCode: errorCode),
            );
          },
        );
      },
    );
  }

  ValidationEnum emailValidation = ValidationEnum.none;
  ButtonValidation joinButton = ButtonValidation.invalid;
  final WaitlistUsecase _waitlistUsecase;
}
