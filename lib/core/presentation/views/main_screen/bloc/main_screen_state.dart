import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/models/base/base_paging_model.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';

part 'main_screen_state.freezed.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState.loading() = _$MainScreenStateLoading;

  const factory MainScreenState.success() = _$MainScreenStateSuccess;

  const factory MainScreenState.error({
    required String msg,
    required String errorCode,
  }) = _$MainScreenStateError;

  const factory MainScreenState.logout({
    required String msg,
    required String errorCode,
  }) = _$MainScreenStateLogout;

  const factory MainScreenState.getTherapist({
    BasePagingModel<UserModel>? usersList,
  }) = _$MainScreenStateGetUserList;
}

extension MainScreenStateExt on MainScreenState {
  bool buildWhen() => when(
        loading: () => false,
        success: () => false,
        error: (_, __) => false,
        logout: (_, __) => false,
        getTherapist: (_) => true,
      );

  bool listenWhen() => !buildWhen();
}
