import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

/// Base Response Model
@Freezed(genericArgumentFactories: true)
class BaseResponse<T> with _$BaseResponse<T> {
  const BaseResponse._();

  /// if success from response
  const factory BaseResponse.success({
    @JsonKey(name: 'data') T? data,
  }) = BaseResponseSuccess;

  /// if error from response
  const factory BaseResponse.error({
    @JsonKey(name: 'message') required String message,
    @JsonKey(name: 'errorCode') required String errorCode,
  }) = BaseResponseError;

  /// if logout from response
  const factory BaseResponse.logout({
    @JsonKey(name: 'message') required String message,
    @JsonKey(name: 'errorCode') required String errorCode,
  }) = BaseResponseLogout;

  /// From json
  factory BaseResponse.fromJson(
          Map<String, Object?> json, T Function(Object?) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);
}
