import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_feedback_model.freezed.dart';

part 'send_feedback_model.g.dart';

@freezed
class SendFeedbackModel with _$SendFeedbackModel {
  const factory SendFeedbackModel({
    @JsonKey(name: 'feedback') String? feedback,
    @JsonKey(name: 'email') String? email,
   
  }) = _SendFeedbackModel;

  factory SendFeedbackModel.fromJson(Map<String, Object?> json) => _$SendFeedbackModelFromJson(json);
}

