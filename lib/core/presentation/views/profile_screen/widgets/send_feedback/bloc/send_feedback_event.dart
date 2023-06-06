import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_feedback_event.freezed.dart';

@freezed
class SendFeedbackEvent with _$SendFeedbackEvent {
  const factory SendFeedbackEvent.validateEmail(String email) = ValidateEmailFeedback;
  const factory SendFeedbackEvent.validatFeedback(String feedback) = ValidateFeedback;
  const factory SendFeedbackEvent.validate(String email, String feedback) = ValidateSend;
}
