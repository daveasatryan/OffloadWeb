import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/models/wait_list/wait_list_model.dart';
import 'package:therapist_journey/core/data/repositories/content_repository.dart';

@injectable
class WaitlistUsecase {
  WaitlistUsecase({
    required this.repository,
  });

  final ContentRepository repository;

  Future<BaseResponse<BaseModel>> call(WaitlistModel body) => repository.waitlist(body);
}
