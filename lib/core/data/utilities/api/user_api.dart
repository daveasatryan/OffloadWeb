import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/calendar/calendar_editing_model.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(
    Dio dio, {
    String baseUrl,
  }) = _UserApi;

  @GET('/api/user')
  Future<HttpResponse<BaseModel<UserModel>>> getUser();

  @PUT('/api/user')
  Future<HttpResponse<BaseModel<UserModel>>> editProifle({
    @Body() required UserModel body,
  });

  @POST('/api/user/calendar')
  Future<HttpResponse<BaseModel<UserModel>>> calendar({
    @Body() required CalendarEditingModel body,
  });
}
