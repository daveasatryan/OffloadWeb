import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/enums/sign_up_checkbox_validation.dart';

part 'create_user_state.freezed.dart';

@freezed
class CreateUserState with _$CreateUserState {
  const factory CreateUserState.loading() = _$CreateUserStateLoading;

  const factory CreateUserState.success() = _$CreateUserStateSuccess;

  const factory CreateUserState.error({
    required String msg,
    required String errorCode,
  }) = _$CreateUserStateError;

  const factory CreateUserState.validation({
    required ValidationEnum emailValidation,
    required ValidationEnum passwordValidation,
    required SignUpCheckboxValidation signUpCheckboxValidation,
    required ButtonValidation signUpButton,
  }) = _$CreateUserValidation;
}

extension CreateUserStateExt on CreateUserState {
  bool buildWhen() => when(
        loading: () => false,
        success: () => false,
        error: (_, __) => false,
        validation: (_, __, ___, ____) => true,
      );

  bool listenWhen() => !buildWhen();
}
