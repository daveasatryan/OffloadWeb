import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';

part 'join_therapist_dialog_state.freezed.dart';

@freezed
class JoinTherapistDialogState with _$JoinTherapistDialogState {
  const factory JoinTherapistDialogState.loading() = _$JoinTherapistDialogStateLoading;

  factory JoinTherapistDialogState.success() = _$JoinTherapistDialogStateSuccess;

  const factory JoinTherapistDialogState.error({
    required String msg,
    required String errorCode,
  }) = _$JoinTherapistDialogStateError;

  const factory JoinTherapistDialogState.validation({
    required ValidationEnum email,
    required ButtonValidation joinButton,
  }) = _$JoinTherapistDialogStateValidationEmailPassword;
}

extension JoinTherapistDialogStateExt on JoinTherapistDialogState {
  bool buildWhen() => when(
        loading: () => false,
        success: () => false,
        error: (_, __) => false,
        validation: (_, __) => true,
      );

  bool listenWhen() => !buildWhen();
}
