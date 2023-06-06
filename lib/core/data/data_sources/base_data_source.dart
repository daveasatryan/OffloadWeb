import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/base/base_response.dart';
import 'package:therapist_journey/core/data/utilities/log/logger_service.dart';
import 'package:retrofit/retrofit.dart';

mixin BaseDataSource {
  Future<BaseResponse<BaseModel<T>>> getResult<T>(
    Future<HttpResponse<BaseModel<T>>> Function() call,
  ) async {
    try {
      final response = await call.call();

      final statusCode = response.response.statusCode ?? -1;
      if (statusCode == -1) {
        return const BaseResponse.error(
          message: 'Unknown Error',
          errorCode: 'UNKNOWN_ERROR',
        );
      }
      if (statusCode >= 200 && statusCode < 300) {
        final body = response.data;
        if (body.status) {
          return BaseResponse.success(data: body);
        } else if (body.errorCode == 'USER_UNAUTHORIZED') {
          return BaseResponse.logout(
            message: body.message ?? '',
            errorCode: body.errorCode ?? '',
          );
        } else {
          return BaseResponse.error(
            message: body.message ?? '',
            errorCode: body.errorCode ?? '',
          );
        }
      } else {
        return BaseResponse.error(
          message: response.response.statusMessage ?? 'Unknown Error',
          errorCode: 'SERVER_ERROR',
        );
      }
    } catch (e, s) {
      LoggerService().d('Error is $e, stack $s');
      return BaseResponse.error(
        message: e.toString(),
        errorCode: 'UNKNOWN_ERROR',
      );
    }
  }
}
