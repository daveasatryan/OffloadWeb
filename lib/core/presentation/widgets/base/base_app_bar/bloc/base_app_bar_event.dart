import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_app_bar_event.freezed.dart';

@freezed
class BaseAppBarEvent with _$BaseAppBarEvent {
   const factory BaseAppBarEvent.logoutUser() = Logout;
}