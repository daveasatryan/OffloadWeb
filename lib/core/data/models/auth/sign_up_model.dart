import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_model.freezed.dart';

part 'sign_up_model.g.dart';

@freezed
class SignUpModel with _$SignUpModel {
  const factory SignUpModel({
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
  }) = _SignUpModel;

factory SignUpModel.fromJson(Map<String, Object?> json) => _$SignUpModelFromJson(json);
}
