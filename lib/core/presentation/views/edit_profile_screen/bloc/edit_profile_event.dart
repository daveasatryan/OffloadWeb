import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';

part 'edit_profile_event.freezed.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent.getUserEditInitial(UserModel userModel) = GetUserEditInitial;
  const factory EditProfileEvent.editUserData({
    required String uuid,
    required String name,
    required List<WeekDayModel> weekDayList,
    required String sessionPrice,
    required String bio,
    required String certifications,
  }) = EditUserData;
  const factory EditProfileEvent.uploadImage() = UploadImage;
}
