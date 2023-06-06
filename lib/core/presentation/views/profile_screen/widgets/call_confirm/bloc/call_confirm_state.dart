import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/name_validation.dart';
import 'package:therapist_journey/core/data/enums/sign_up_checkbox_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';

part 'call_confirm_state.freezed.dart';

@freezed
class CallConfirmBlocState with _$CallConfirmBlocState {
  const factory CallConfirmBlocState.loading() = _$CallConfirmBlocStateLoading;

  const factory CallConfirmBlocState.success() = _$CallConfirmBlocStateSuccess;

  const factory CallConfirmBlocState.error({
    required String msg,
    required String errorCode,
  }) = _$CallConfirmBlocStateError;

  const factory CallConfirmBlocState.validation(
      {required ValidationEnum emailValidation,
      required NameValidation nameValidation,
      required SignUpCheckboxValidation checkboxValidation,
      required ButtonValidation buttonValidation}) = _$CallConfirmBlocStateValidate;
}

extension CallConfirmBlocStateExt on CallConfirmBlocState {
  bool buildWhen() => when(
        loading: () => false,
        success: () => true,
        error: (_, __) => false,
        validation: (_, __, ___, _____) => true,
      );

  bool listenWhen() => !buildWhen();
}
