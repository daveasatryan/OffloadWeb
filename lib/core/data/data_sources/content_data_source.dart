import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/data_sources/base_data_source.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_paging_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/models/send_feedback/send_feedback_model.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/models/wait_list/wait_list_model.dart';
import 'package:therapist_journey/core/data/utilities/api/api.dart';
import 'package:therapist_journey/core/data/utilities/api/content_api.dart';

@injectable
class ContentDataSource with BaseDataSource {
  ContentDataSource(Api api) {
    this.api = api.content;
  }

  late final ContentApi api;

  Future<BaseResponse<BaseModel<BasePagingModel<UserModel>>>> getTherapist() => getResult(
        () => api.getTherapist(),
      );

  Future<BaseResponse<BaseModel<UserModel>>> getTherapistItem(String uuid) => getResult(
        () => api.getTherapistItem(uuid),
      );

  Future<BaseResponse<BaseModel>> sendFeedback(SendFeedbackModel sendFeedbackModel) => getResult(
        () => api.sendFeedback(body: sendFeedbackModel),
      );

  Future<BaseResponse<BaseModel>> waitlist(WaitlistModel body) => getResult(
        () => api.waitlist(body: body),
      );
}
