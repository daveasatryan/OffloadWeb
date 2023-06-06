import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_confirm_event.freezed.dart';

@freezed
class CallConfirmBlocEvent with _$CallConfirmBlocEvent {
  const factory CallConfirmBlocEvent.validateCallConfirmEmail(String email) = ValidateEmailEvent;
  const factory CallConfirmBlocEvent.validateCallConfirName(String name) = ValidateNameEvent;
  const factory CallConfirmBlocEvent.validateCheckBox(bool checkbox) = ValidateCheckBoxEvent;

  const factory CallConfirmBlocEvent.validateButton(String name, String email, String notes) =
      ValidateButtonEvent;
}
