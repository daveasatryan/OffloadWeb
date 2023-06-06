import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/data_sources/content_data_source.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_paging_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/models/send_feedback/send_feedback_model.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/models/wait_list/wait_list_model.dart';

@injectable
class ContentRepository {
  ContentRepository(this.contentDataSource);

  final ContentDataSource contentDataSource;

  Future<BaseResponse<BaseModel<BasePagingModel<UserModel>>>> getTherapist() =>
      contentDataSource.getTherapist();

  Future<BaseResponse<BaseModel<UserModel>>> getTherapistItem(String uuid) =>
      contentDataSource.getTherapistItem(uuid);

  Future<BaseResponse<BaseModel>> sendFeedback(SendFeedbackModel body) => contentDataSource.sendFeedback(body);
  Future<BaseResponse<BaseModel>> waitlist(WaitlistModel body) => contentDataSource.waitlist( body);
}
