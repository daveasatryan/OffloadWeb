import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_timeline_event.freezed.dart';

@freezed
class CalendarTimelineEvent with _$CalendarTimelineEvent {
  const factory CalendarTimelineEvent.changeCurrentDate(DateTime date) = ChangeCurrentDate;
  const factory CalendarTimelineEvent.showError(bool showError) = ShowError;
}
