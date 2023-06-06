import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';

part 'forget_password_state.freezed.dart';

@freezed
class ForgetPasswordState with _$ForgetPasswordState {
  const factory ForgetPasswordState.loading() = _$ForgetPasswordStateLoading;

  const factory ForgetPasswordState.success() = _$ForgetPasswordStateSuccess;

  const factory ForgetPasswordState.error({
    required String msg,
    required String errorCode,
  }) = _$ForgetPasswordStateError;

  const factory ForgetPasswordState.logout({
    required String msg,
    required String errorCode,
  }) = _$ForgetPasswordStateLogout;

  const factory ForgetPasswordState.validation({
    required ValidationEnum emailValidation,
    required ButtonValidation buttonValidation,
    String? errorText,
  }) = _$ForgetPasswordStateValidate;
}

extension ForgetPasswordStateExt on ForgetPasswordState {
  bool buildWhen() => when(
        loading: () => false,
        success: () => false,
        error: (_, __) => false,
        logout: (_, __) => false,
        validation: (_, __, ___) => true,
      );

  bool listenWhen() => !buildWhen();
}
