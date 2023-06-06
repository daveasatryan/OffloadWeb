import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.loading() = _$SplashStateLoading;

  const factory SplashState.isLogin({
    UserModel? userModel,
  }) = _$SplashStateIsLogin;
}
