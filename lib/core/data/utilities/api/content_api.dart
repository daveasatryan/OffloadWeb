import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_paging_model.dart';
import 'package:therapist_journey/core/data/models/send_feedback/send_feedback_model.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/models/wait_list/wait_list_model.dart';

part 'content_api.g.dart';

@RestApi()
abstract class ContentApi {
  factory ContentApi(
    Dio dio, {
    String baseUrl,
  }) = _ContentApi;

  @GET('/api/users')
  Future<HttpResponse<BaseModel<BasePagingModel<UserModel>>>> getTherapist();

  @GET('/api/user/data/{uuid}')
  Future<HttpResponse<BaseModel<UserModel>>> getTherapistItem(@Path('uuid') String uuid);

  @POST('/api/user/feedback')
  Future<HttpResponse<BaseModel>> sendFeedback({
    @Body() required SendFeedbackModel body,
  });

  @POST('/api/user/waitList')
  Future<HttpResponse<BaseModel>> waitlist({
    @Body() required WaitlistModel body,
  });
}
