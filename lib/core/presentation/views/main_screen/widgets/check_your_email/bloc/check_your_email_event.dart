import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_your_email_event.freezed.dart';

@freezed
class CheckYourEmailEvent with _$CheckYourEmailEvent {
  const factory CheckYourEmailEvent.checkYourCode(String code) = CheckYourCode;
  const factory CheckYourEmailEvent.checkYourCodeForgetPasswordButton(String code) =
      CheckYourCodeForgetPasswordButton;
  const factory CheckYourEmailEvent.checkYourVerifyCodeButton(String code) =
      CheckYourVerifyCodeButton;
}
