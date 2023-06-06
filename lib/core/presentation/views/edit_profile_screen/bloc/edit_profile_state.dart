import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';

part 'edit_profile_state.freezed.dart';

@Freezed(
  equal: false,
)
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.loading() = _$EditProfileStateLoading;

  const factory EditProfileState.success({UserModel? user}) = _$EditProfileStateSuccess;

  const factory EditProfileState.successUploadImage({UserModel? user}) =
      _$EditProfileStateSuccessUploadImage;

  const factory EditProfileState.successCalendar({UserModel? user}) =
      _$EditProfileStatSsuccessCalendar;

  const factory EditProfileState.initial() = _$EditProfileStateInitial;

  const factory EditProfileState.error({
    required String msg,
    required String errorCode,
  }) = _$EditProfileStateError;

  const factory EditProfileState.logout({
    required String msg,
    required String errorCode,
  }) = _$EditProfileStateLogout;

  const factory EditProfileState.userData({
    UserModel? user,
    List<WeekDayModel>? weekDayList,
  }) = _$EditProfileStateUserData;
}

extension EditProfileStateExt on EditProfileState {
  bool buildWhen() => when(
        loading: () => false,
        initial: () => false,
        success: (_) => false,
        successUploadImage: (_) => false,
        successCalendar: (_) => false,
        error: (_, __) => false,
        logout: (_, __) => false,
        userData: (_, __) => true,
      );

  bool listenWhen() => !buildWhen();
}
