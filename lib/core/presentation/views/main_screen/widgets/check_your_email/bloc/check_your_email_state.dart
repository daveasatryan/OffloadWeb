import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/code_validoation.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';

part 'check_your_email_state.freezed.dart';

@freezed
class CheckYourEmailState with _$CheckYourEmailState {
  const factory CheckYourEmailState.loading() = _$CheckYourEmailStateLoading;

  const factory CheckYourEmailState.success({UserModel? userModel}) = _$CheckYourEmailStateSuccess;

  const factory CheckYourEmailState.error({
    required String msg,
    required String errorCode,
  }) = _$CheckYourEmailStateError;

  const factory CheckYourEmailState.validation({
    required CodeValidation codeValidoation,
    required ButtonValidation buttonValidation,
    String? errorText,
  }) = _$CheckYourEmailStateValidate;
}

extension CheckYourEmailStateExt on CheckYourEmailState {
  bool buildWhen() => when(
        loading: () => false,
        success: (_) => false,
        error: (_, __) => false,
        validation: (_, __, ___) => true,
      );

  bool listenWhen() => !buildWhen();
}
