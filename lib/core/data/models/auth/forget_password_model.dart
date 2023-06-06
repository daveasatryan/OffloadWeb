import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_model.freezed.dart';

part 'forget_password_model.g.dart';

@freezed
class ForgotEmailRequestModel with _$ForgotEmailRequestModel {
  const factory ForgotEmailRequestModel({
    @JsonKey(name: 'email') String? email,
  }) = _ForgotEmailRequestModel;

  factory ForgotEmailRequestModel.fromJson(Map<String, Object?> json) => _$ForgotEmailRequestModelFromJson(json);
}
