import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_screen_event.freezed.dart';

@freezed
class SplashScreenEvent with _$SplashScreenEvent {
  const factory SplashScreenEvent.getUser() = GetUser;
}