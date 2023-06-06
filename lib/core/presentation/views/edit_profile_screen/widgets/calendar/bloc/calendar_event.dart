import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/models/calendar/date_book_item_model.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';

part 'calendar_event.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.initial(WeekDayModel weekDay) = Initial;

  const factory CalendarEvent.dateCalendar(
    DateTime startTime,
    DateTime endTime,
  ) = DateCalendar;

  const factory CalendarEvent.calendarDeleteTime(
    DateBookItemModel dateBookItem,
    List<String> deletedUuidList,
  ) = CalendarDeleteTime;

  const factory CalendarEvent.calendarBookMeeting(
    DateBookItemModel dateBookItem,
  ) = CalendarBookMeeting;

  const factory CalendarEvent.calendarAddTime(
    WeekDayModel weekDay,
  ) = CalendarAddTime;

  const factory CalendarEvent.startTime(
    DateBookItemModel dateBookItem,
    DateTime date,
  ) = StartTime;

  const factory CalendarEvent.endTime(
    DateBookItemModel dateBookItem,
    DateTime date,
  ) = EndTime;
}
