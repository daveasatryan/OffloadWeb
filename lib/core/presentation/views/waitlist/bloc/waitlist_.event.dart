import 'package:freezed_annotation/freezed_annotation.dart';

part 'waitlist_.event.freezed.dart';

@freezed
class WaitlistEvent with _$WaitlistEvent {
  const factory WaitlistEvent.validateEmail(String email) = ValidateEmailWaitlist;
  const factory WaitlistEvent.validateButton(String email) = ValidateButtonWaitlist;
}
