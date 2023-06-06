import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// App logger interceptor
class LoggingInterceptor extends PrettyDioLogger {
  /// Default constructor
  LoggingInterceptor()
      : super(
    requestBody: true,
    requestHeader: true,
    responseHeader: true,
    responseBody: false,
    error: true,
    compact: false,
  );
}
