import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_code_model.freezed.dart';

part 'check_code_model.g.dart';

@freezed
class CheckCodeModel with _$CheckCodeModel {
  const factory CheckCodeModel({
    @JsonKey(name: 'code') String? code,
  }) = _CheckCodeModel;

  factory CheckCodeModel.fromJson(Map<String, Object?> json) => _$CheckCodeModelFromJson(json);
}
