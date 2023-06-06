import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_app_bar_state.freezed.dart';

@freezed
class BaseAppBarState with _$BaseAppBarState {
  const factory BaseAppBarState.loading() = _$BaseAppBarStateLoading;

  const factory BaseAppBarState.error({
    required String msg,
    required String errorCode,
  }) = _$BaseAppBarStateError;

  const factory BaseAppBarState.logout() = _$BaseAppBarStateLogout;
const factory BaseAppBarState.initial() = _$BaseAppBarStateInitial;

}
extension BaseAppBarStateExt on BaseAppBarState {
  bool buildWhen() => when(
    loading: () => false,
    error: (_, __) => false,
    logout: () => false,
    initial: () => true,
    );

  bool listenWhen() => !buildWhen();
}
