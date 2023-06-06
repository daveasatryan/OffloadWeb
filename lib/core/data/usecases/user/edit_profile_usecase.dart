import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/repositories/user_repository.dart';

@injectable
class EditProfileUsecase {
  EditProfileUsecase({
    required this.repository,
  });

  final UserRepository repository;

  Future<BaseResponse<BaseModel<UserModel>>> call(UserModel body) => repository.editProfile(body);
}
