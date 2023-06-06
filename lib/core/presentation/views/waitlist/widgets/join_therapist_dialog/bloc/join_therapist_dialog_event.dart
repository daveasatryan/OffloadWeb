import 'package:freezed_annotation/freezed_annotation.dart';

part 'join_therapist_dialog_event.freezed.dart';

@freezed
class JoinTherapistDialogEvent with _$JoinTherapistDialogEvent {
  const factory JoinTherapistDialogEvent.validateEmail(String email) = ValidateEmailJoin;
  const factory JoinTherapistDialogEvent.validate(String email) = ValidateJoin;
}
