import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_screen_state.freezed.dart';

@freezed
class SplashScreenState with _$SplashScreenState {
  const factory SplashScreenState.loading() = _$SplashScreenStateLoading;

  const factory SplashScreenState.success() = _$SplashScreenStateSuccess;

  const factory SplashScreenState.error({
    required String msg,
    required String errorCode,
  }) = _$SplashScreenStateError;

  const factory SplashScreenState.logout({
    required String msg,
    required String errorCode,
  }) = _$SplashScreenStateLogout;
}

extension SplashScreenStateExt on SplashScreenState {
  bool buildWhen() => when(
        loading: () => false,
        success: () => true,
        error: (_, __) => false,
        logout: (_, __) => false,
      );

  bool listenWhen() => !buildWhen();
}