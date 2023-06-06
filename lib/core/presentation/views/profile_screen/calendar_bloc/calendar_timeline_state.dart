import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_timeline_state.freezed.dart';

@Freezed(equal: false)
class CalendarTimelineState with _$CalendarTimelineState {
  const factory CalendarTimelineState.initial(DateTime currentDay, bool showError) =
      _$CalendarTimelineStateInital;
}
