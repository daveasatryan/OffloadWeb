import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/utilities/api/auth_api.dart';
import 'package:therapist_journey/core/data/utilities/api/content_api.dart';
import 'package:therapist_journey/core/data/utilities/api/file_upload_api.dart';
import 'package:therapist_journey/core/data/utilities/api/interceptors/logging_interceptor.dart';
import 'package:therapist_journey/core/data/utilities/api/user_api.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';

/// Api Provider
@injectable
class Api {
  /// Default constructor
  Api();

  final _dio = Dio(
    BaseOptions(
      receiveTimeout: const Duration(milliseconds: 60000),
      connectTimeout: const Duration(milliseconds: 60000),
      contentType: 'application/json',
    ),
  )
    ..interceptors.add(
      LoggingInterceptor(),
    )
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) {
          options.headers['Content-Type'] = 'application/json';
          /// setting token if exists
          final token = PreferencesManager.token;
          if (kDebugMode) {
            print('token -> $token');
          }
          if (token != null) {
            options.headers['X-API-TOKEN'] = token;
          }
          return handler.next(options);
        },
      ),
    );

  //final _baseUrl = 'https://api.offloadweb.com';
  final _baseUrl = 'https://stage-api.offloadweb.com';
  String get baseUrl =>  _baseUrl;
  AuthApi get auth => AuthApi(_dio, baseUrl: baseUrl);

  UserApi get user => UserApi(_dio, baseUrl: baseUrl);

  FileUploadApi get fileUpload => FileUploadApi(_dio, baseUrl: baseUrl);

  ContentApi get content => ContentApi(_dio, baseUrl: baseUrl);
}
