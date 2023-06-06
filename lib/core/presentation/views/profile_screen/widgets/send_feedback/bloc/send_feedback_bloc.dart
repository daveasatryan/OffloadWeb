import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/enums/name_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/models/send_feedback/send_feedback_model.dart';
import 'package:therapist_journey/core/data/usecases/content/send_feedback_usecase.dart';
import 'package:therapist_journey/core/data/utilities/app_constants.dart';
import 'package:therapist_journey/core/data/utilities/validation_utils.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/send_feedback/bloc/send_feedback_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/send_feedback/bloc/send_feedback_state.dart';

@injectable
class SendFeedbackBloc extends Bloc<SendFeedbackEvent, SendFeedbackState> {
  SendFeedbackBloc(this._sendFeedbackUsecase)
      : super(
          const SendFeedbackState.sendFeedback(
            email: ValidationEnum.none,
            feedback: NameValidation.none,
            sendFeedbackButton: ButtonValidation.invalid,
          ),
        ) {
    on<ValidateEmailFeedback>((event, emit) {
      emailValidation = ValidationEnum.none;

      emit(SendFeedbackState.sendFeedback(
          email: emailValidation,
          feedback: sendFeedbackValidation,
          sendFeedbackButton: sendFeedbackButton));
    });
    on<ValidateFeedback>((event, emit) {
      sendFeedbackValidation = NameValidation.none;

      if (event.feedback.isNotEmpty) {
        sendFeedbackButton = ButtonValidation.valid;
      } else {
        sendFeedbackButton = ButtonValidation.invalid;
      }
      emit(SendFeedbackState.sendFeedback(
          email: emailValidation,
          feedback: sendFeedbackValidation,
          sendFeedbackButton: sendFeedbackButton));
    });
    on<ValidateSend>(
      (event, emit) async {
        final isEmailValid = ValidationUtils.isValidEmail(event.email);

        if (!isEmailValid) {
          emailValidation = ValidationEnum.invalid;
        } else {
          emailValidation = ValidationEnum.valid;
        }

        if (event.feedback.isEmpty) {
          sendFeedbackValidation = NameValidation.empty;
        } else {
          sendFeedbackValidation = NameValidation.valid;
        }

        if (sendFeedbackValidation != NameValidation.valid) {
          emit(
            SendFeedbackState.sendFeedback(
              email: emailValidation,
              feedback: sendFeedbackValidation,
              sendFeedbackButton: sendFeedbackButton,
            ),
          );
          return;
        }
        (await _sendFeedbackUsecase(
          SendFeedbackModel(
            email: event.email,
            feedback: event.feedback,
          ),
        ))
            .whenOrNull(
          success: (data) {
            emit(
              SendFeedbackState.success(),
            );
          },
          error: (msg, errorCode) {
            if (errorCode == AppConstants.invalidEmailCode) {
              emit(
                SendFeedbackState.sendFeedback(
                  email: emailValidation,
                  feedback: sendFeedbackValidation,
                  sendFeedbackButton: sendFeedbackButton,
                ),
              );
              return;
            } else if (errorCode == AppConstants.invalidEmailCode) {
              emit(
                SendFeedbackState.sendFeedback(
                  email: emailValidation,
                  feedback: sendFeedbackValidation,
                  sendFeedbackButton: sendFeedbackButton,
                ),
              );
              return;
            }
            emit(
              SendFeedbackState.error(msg: msg, errorCode: errorCode),
            );
          },
        );
      },
    );
  }

  ValidationEnum emailValidation = ValidationEnum.none;
  NameValidation sendFeedbackValidation = NameValidation.none;
  ButtonValidation sendFeedbackButton = ButtonValidation.invalid;
  final SendFeedbackUsecase _sendFeedbackUsecase;
}
