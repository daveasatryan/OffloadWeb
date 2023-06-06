import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/data_sources/base_data_source.dart';
import 'package:therapist_journey/core/data/models/auth/new_password_model.dart';
import 'package:therapist_journey/core/data/models/auth/forget_password_model.dart';
import 'package:therapist_journey/core/data/models/auth/sign_in_model.dart';
import 'package:therapist_journey/core/data/models/auth/sign_up_model.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/utilities/api/api.dart';
import 'package:therapist_journey/core/data/utilities/api/auth_api.dart';

@injectable
class AuthDataSource with BaseDataSource {
  AuthDataSource(Api api) {
    this.api = api.auth;
  }

  late final AuthApi api;

  Future<BaseResponse<BaseModel<SignUpModel>>> createUser(SignUpModel body) =>
      getResult(() => api.createUser(body: body));

  Future<BaseResponse<BaseModel<UserModel>>> signIn(SignInModel body) =>
      getResult(() => api.signInUser(body: body));

  Future<BaseResponse<BaseModel<ForgotEmailRequestModel>>> findAccountByEmail(
          ForgotEmailRequestModel body) =>
      getResult(() => api.findAccountByEmail(body: body));

  Future<BaseResponse<BaseModel<UserModel>>> resetPasswordSendCode(NewPasswordModel body) =>
      getResult(() => api.resetPasswordSendCode(body: body));

  Future<BaseResponse<BaseModel>> checkYourCode(String code) =>
      getResult(() => api.checkYourCode(code));

  Future<BaseResponse<BaseModel<UserModel>>> checkYourVerifyCode(String code) =>
      getResult(() => api.checkYourVerifyCode(code));

  Future<BaseResponse<BaseModel>> logout() => getResult(
        () => api.logout(),
      );
}
