import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_user_event.freezed.dart';

@freezed
class CreateUserEvent with _$CreateUserEvent {
  const factory CreateUserEvent.validateEmail(String email) = ValidateEmail;
  const factory CreateUserEvent.validatePassword(String password) = ValidatePassword;
  const factory CreateUserEvent.validateCheckBox(bool checkbox) = ValidateCheckBox;
  const factory CreateUserEvent.signUp(
    String email,
    String password,
  ) = SignUp;

  const factory CreateUserEvent.validate(String email, String password, String confirmPassword) =
      Validate;
}
