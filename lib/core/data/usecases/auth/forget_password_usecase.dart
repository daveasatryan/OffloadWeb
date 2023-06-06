import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/models/auth/forget_password_model.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/repositories/auth_repository.dart';

@injectable
class ForgetPasswordUsecase {
  ForgetPasswordUsecase({
    required this.repository,
  });

  final AuthRepository repository;

  Future<BaseResponse<BaseModel<dynamic>>> call(ForgotEmailRequestModel body) =>
      repository.findAccountByEmail(body);
}
