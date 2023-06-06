import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';
import 'package:therapist_journey/core/data/models/base/base_model.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';

class FileUploadApi {
  final Dio dio;
  final String baseUrl;

  FileUploadApi(this.dio, {required this.baseUrl});

  Future<HttpResponse<BaseModel<UserModel>>> uploadFile(
      {required List<int> bytes, required String fileName}) async {
    FormData formData = FormData.fromMap({
      'image':
          MultipartFile.fromBytes(bytes, filename: fileName, contentType: MediaType('image', 'jpg'))
    });

    final result = await dio.post('$baseUrl/api/user/image', data: formData);
    final value = BaseModel<UserModel>.fromJson(
      result.data!,
      (user) => UserModel.fromJson(user as Map<String, Object?>),
    );
    final httpResponse = HttpResponse(value, result);
    return httpResponse;
  }
}
