import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/repositories/content_repository.dart';

@injectable
class GetTherapistItemUsecase {
  GetTherapistItemUsecase({
    required this.repository,
  });

  final ContentRepository repository;

  Future<BaseResponse<BaseModel<UserModel>>> call(String uuid) => repository.getTherapistItem(uuid);
}
