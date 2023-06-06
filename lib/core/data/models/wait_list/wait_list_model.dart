import 'package:freezed_annotation/freezed_annotation.dart';

part 'wait_list_model.freezed.dart';

part 'wait_list_model.g.dart';

@freezed
class WaitlistModel with _$WaitlistModel {
  const factory WaitlistModel({
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'isTherapist') bool? isTherapist,
   
  }) = _WaitlistModel;

  factory WaitlistModel.fromJson(Map<String, Object?> json) => _$WaitlistModelFromJson(json);
}

