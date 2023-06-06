import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/models/calendar/calendars_model.dart';

part 'calendar_editing_model.freezed.dart';

part 'calendar_editing_model.g.dart';

@freezed
class CalendarEditingModel with _$CalendarEditingModel {
  const factory CalendarEditingModel({
    @JsonKey(name: 'calendars') List<CalendarsModel>? calendars,
    @JsonKey(name: 'deletedCalendarUuids') List<String>? deletedCalendarUuids,
  }) = _CalendarEditingModel;

  factory CalendarEditingModel.fromJson(Map<String, Object?> json) =>
      _$CalendarEditingModelFromJson(json);
}
