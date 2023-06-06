import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/models/send_feedback/send_feedback_model.dart';
import 'package:therapist_journey/core/data/repositories/content_repository.dart';

@injectable
class SendFeedbackUsecase {
  SendFeedbackUsecase({
    required this.repository,
  });

  final ContentRepository repository;

  Future<BaseResponse<BaseModel>> call(SendFeedbackModel sendFeedbackModel) => repository.sendFeedback( sendFeedbackModel);
}
