import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:therapist_journey/core/data/models/auth/new_password_model.dart';
import 'package:therapist_journey/core/data/models/auth/forget_password_model.dart';
import 'package:therapist_journey/core/data/models/auth/sign_in_model.dart';
import 'package:therapist_journey/core/data/models/auth/sign_up_model.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(
    Dio dio, {
    String baseUrl,
  }) = _AuthApi;
  //SignUp
  @POST('/api/user')
  Future<HttpResponse<BaseModel<SignUpModel>>> createUser({
    @Body() required SignUpModel body,
  });
  //SignIn
  @POST('/api/user/login')
  Future<HttpResponse<BaseModel<UserModel>>> signInUser({
    @Body() required SignInModel body,
  });
  //ForgetPassword
  @POST('/api/user/password/recover')
  Future<HttpResponse<BaseModel<ForgotEmailRequestModel>>> findAccountByEmail({
    @Body() required ForgotEmailRequestModel body,
  });
  //check your code forget password
  @POST('/api/user/check/{code}')
  Future<HttpResponse<BaseModel>> checkYourCode(@Path('code') String? code);

  //check your verify code
  @POST('/api/user/confirm/{code}')
  Future<HttpResponse<BaseModel<UserModel>>> checkYourVerifyCode(@Path('code') String? code);

  //send the new Password and  the code
  @POST('/api/user/password/confirm')
  Future<HttpResponse<BaseModel<UserModel>>> resetPasswordSendCode({
    @Body() required NewPasswordModel body,
  });
  
  //logout
  @POST('/api/user/logout')
  Future<HttpResponse<BaseModel>> logout();
}
