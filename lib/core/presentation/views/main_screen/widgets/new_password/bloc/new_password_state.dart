import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';

part 'new_password_state.freezed.dart';

@freezed
class NewPasswordState with _$NewPasswordState {
  const factory NewPasswordState.loading() = _$NewPasswordStateLoading;

  const factory NewPasswordState.success(UserModel? userModel) = _$NewPasswordStateSuccess;

  const factory NewPasswordState.error({
    required String msg,
    required String errorCode,
  }) = _$NewPasswordStateError;

  const factory NewPasswordState.validation(
      {required ValidationEnum passwordValidation,
      required ValidationEnum confirmPasswordValidation,
      required ButtonValidation buttonValidation}) = _$NewPasswordStateValidate;
}

extension NewPasswordStateExt on NewPasswordState {
  bool buildWhen() => when(
        loading: () => false,
        success: (_) => false,
        error: (_, __) => false,
        validation: (_, __, ___) => true,
      );

  bool listenWhen() => !buildWhen();
}
