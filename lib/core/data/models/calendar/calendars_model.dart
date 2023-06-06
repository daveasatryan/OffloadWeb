import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendars_model.freezed.dart';

part 'calendars_model.g.dart';

@freezed
class CalendarsModel with _$CalendarsModel {
  const factory CalendarsModel({
    @JsonKey(name: 'uuid') String? uuid,
    @JsonKey(name: 'startDate') int? startDate,
    @JsonKey(name: 'endDate') int? endDate,
    @JsonKey(name: 'isRepeat') bool? isRepeat,
    @JsonKey(name: 'isBooked') bool? isBooked,
  }) = _CalendarsModel;

  factory CalendarsModel.fromJson(Map<String, Object?> json) => _$CalendarsModelFromJson(json); 
}

