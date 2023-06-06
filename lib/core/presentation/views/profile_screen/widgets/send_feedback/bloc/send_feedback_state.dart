import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/enums/name_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';

part 'send_feedback_state.freezed.dart';

@freezed
class SendFeedbackState with _$SendFeedbackState {
  const factory SendFeedbackState.loading() = _$SendFeedbackStateLoading;

  factory SendFeedbackState.success() = _$SendFeedbackStateSuccess;

  const factory SendFeedbackState.error({
    required String msg,
    required String errorCode,
  }) = _$SendFeedbackStateError;

  const factory SendFeedbackState.sendFeedback({
    required ValidationEnum email,
    required NameValidation feedback,
    required ButtonValidation sendFeedbackButton,
  }) = _$SendFeedbackStateValidation;
}

extension SendFeedbackStateExt on SendFeedbackState {
  bool buildWhen() => when(
        loading: () => false,
        success: () => false,
        error: (_, __) => false,
        sendFeedback: (_, __, ___) => true,
      );

  bool listenWhen() => !buildWhen();
}
