import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/data_sources/content_data_source.dart';
import 'package:therapist_journey/core/data/data_sources/user_data_source.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';

@injectable
class UserRepository {
  UserRepository(this.dataSource, this.contentDataSource);

  final UserDataSource dataSource;
  final ContentDataSource contentDataSource;

  Future<BaseResponse<BaseModel<UserModel>>> getUser() => dataSource.getUser();

  Future<BaseResponse<BaseModel<UserModel>>> editProfile(userModel) =>
      dataSource.editProfile(userModel);

  Future<BaseResponse<BaseModel<UserModel>>> uploadImage(List<int> bytes, String fileName) =>
      dataSource.uploadImage(bytes, fileName);

  Future<BaseResponse<BaseModel<UserModel>>> calendar(calendarDate) =>
      dataSource.calendar(calendarDate);
}
