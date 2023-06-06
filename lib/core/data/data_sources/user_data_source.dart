import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/data_sources/base_data_source.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/models/calendar/calendar_editing_model.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/utilities/api/api.dart';
import 'package:therapist_journey/core/data/utilities/api/file_upload_api.dart';
import 'package:therapist_journey/core/data/utilities/api/user_api.dart';

@injectable
class UserDataSource with BaseDataSource {
  UserDataSource(Api api) {
    this.api = api.user;
    fileApi = api.fileUpload;
  }

  late final UserApi api;
  late final FileUploadApi fileApi;

  Future<BaseResponse<BaseModel<UserModel>>> getUser() => getResult(
        () => api.getUser(),
      );

  Future<BaseResponse<BaseModel<UserModel>>> editProfile(UserModel userModel) => getResult(
        () => api.editProifle(body: userModel),
      );

  Future<BaseResponse<BaseModel<UserModel>>> uploadImage(List<int> bytes, String fileName) =>
      getResult(
        () => fileApi.uploadFile(bytes: bytes, fileName: fileName),
      );

  Future<BaseResponse<BaseModel<UserModel>>> calendar(
          CalendarEditingModel calendarDate) =>
      getResult(
        () => api.calendar(body: calendarDate),
      );
}
