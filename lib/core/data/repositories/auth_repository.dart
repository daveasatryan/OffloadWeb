import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/data_sources/auth_data_source.dart';
import 'package:therapist_journey/core/data/models/auth/new_password_model.dart';
import 'package:therapist_journey/core/data/models/auth/forget_password_model.dart';
import 'package:therapist_journey/core/data/models/auth/sign_in_model.dart';
import 'package:therapist_journey/core/data/models/auth/sign_up_model.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';

@injectable
class AuthRepository {
  AuthRepository(this.dataSource);

  final AuthDataSource dataSource;

  Future<BaseResponse<BaseModel<SignUpModel>>> createUser(SignUpModel body) =>
      dataSource.createUser(body);

  Future<BaseResponse<BaseModel<UserModel>>> signIn(SignInModel body) => dataSource.signIn(body);

  Future<BaseResponse<BaseModel<ForgotEmailRequestModel>>> findAccountByEmail(
          ForgotEmailRequestModel body) =>
      dataSource.findAccountByEmail(body);

  Future<BaseResponse<BaseModel<UserModel>>> resetPasswordSendCode(NewPasswordModel body) =>
      dataSource.resetPasswordSendCode(body);

  Future<BaseResponse<BaseModel>> checkYourCode(String code) => dataSource.checkYourCode(code);

  Future<BaseResponse<BaseModel<UserModel>>> checkYourVerifyCode(String code) =>
      dataSource.checkYourVerifyCode(code);
  Future<BaseResponse<BaseModel>> logout() => dataSource.logout();
}
