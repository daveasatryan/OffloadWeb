import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';

part 'waitlist_.state.freezed.dart';

@freezed
class WaitlistState with _$WaitlistState {
  const factory WaitlistState.loading() = _$WaitlistStateLoading;

  const factory WaitlistState.success() = _$WaitlistStateSuccess;

  const factory WaitlistState.error({
    required String msg,
    required String errorCode,
  }) = _$WaitlistStateError;

  const factory WaitlistState.logout({
    required String msg,
    required String errorCode,
  }) = _$WaitlistStateLogout;

  const factory WaitlistState.validation({
    required ValidationEnum emailValidation,
    required ButtonValidation buttonValidation,
    bool? changeWidget,
  }) = _$WaitlistStateValidate;
}

extension WaitlistStateExt on WaitlistState {
  bool buildWhen() => when(
        loading: () => false,
        success: () => false,
        error: (_, __) => false,
        logout: (_, __) => false,
        validation: (_, __, ___) => true,
      );

  bool listenWhen() => !buildWhen();
}
