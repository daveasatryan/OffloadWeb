import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_password_event.freezed.dart';

@freezed
class NewPasswordEvent with _$NewPasswordEvent {
  const factory NewPasswordEvent.validateNewPassword(String password, String confirmNassword) = ValidateNewPassword;
  const factory NewPasswordEvent.validateConfirmNewPassword(String confirmNassword,String password) =
      ValidateConfirmNewPassword;
  const factory NewPasswordEvent.validateButton(
      String password, String confirmNassword, String code) = ValidateButton;
}
