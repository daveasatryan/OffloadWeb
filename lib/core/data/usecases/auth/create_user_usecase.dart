import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/models/auth/sign_up_model.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/repositories/auth_repository.dart';

@injectable
class CreateUserUsecase {
  CreateUserUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  Future<BaseResponse<BaseModel<dynamic>>> call(SignUpModel body) => repository.createUser(body);
}
