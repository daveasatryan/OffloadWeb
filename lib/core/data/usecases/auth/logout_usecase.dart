import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/repositories/auth_repository.dart';

@injectable
class LogoutUsecase {
  LogoutUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  Future<BaseResponse<BaseModel>> call() => repository.logout();
}
