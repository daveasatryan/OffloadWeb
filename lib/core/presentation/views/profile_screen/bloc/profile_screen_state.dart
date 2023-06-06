import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';

part 'profile_screen_state.freezed.dart';

@freezed
class ProfileScreenState with _$ProfileScreenState {
  const factory ProfileScreenState.loading() = _$ProfileScreenStateLoading;

  const factory ProfileScreenState.success() = _$ProfileScreenStateSuccess;

  const factory ProfileScreenState.error({
    required String msg,
    required String errorCode,
  }) = _$ProfileScreenStateError;

  const factory ProfileScreenState.logout() = _$ProfileScreenStateLogout;

  const factory ProfileScreenState.getUser({
    UserModel? user,
  }) = _$ProfileScreenStateGetUser;
}

extension ProfileScreenStateExt on ProfileScreenState {
  bool buildWhen() => when(
        loading: () => false,
        success: () => false,
        error: (_, __) => false,
        logout: () => false,
        getUser: (_) => true,
      );

  bool listenWhen() => !buildWhen();
}
