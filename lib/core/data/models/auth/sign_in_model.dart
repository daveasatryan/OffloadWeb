import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_model.freezed.dart';

part 'sign_in_model.g.dart';

@freezed
class SignInModel with _$SignInModel {
  const factory SignInModel({
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
  }) = _SignInModel;

  factory SignInModel.fromJson(Map<String, Object?> json) => _$SignInModelFromJson(json);
}
