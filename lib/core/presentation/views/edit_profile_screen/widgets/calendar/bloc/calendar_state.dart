import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/models/calendar/date_book_item_model.dart';

part 'calendar_state.freezed.dart';

@Freezed(equal: false)
class CalendarState with _$CalendarState {
  const factory CalendarState.initial() = _$CalendarStateInitial;

  const factory CalendarState.loading() = _$CalendarStateLoading;

  const factory CalendarState.success() = _$CalendarStateSuccess;

  const factory CalendarState.error({
    required String msg,
    required String errorCode,
  }) = _$CalendarStateError;

  const factory CalendarState.logout({
    required String msg,
    required String errorCode,
  }) = _$CalendarStateLogout;

  const factory CalendarState.calendarDate({
    List<DateBookItemModel>? dateBooKList,
  }) = _$CalendarStateCalendarDate;
}

extension CalendarStateExt on CalendarState {
  bool buildWhen() => when(
        initial: () => false,
        loading: () => false,
        success: () => false,
        error: (_, __) => false,
        logout: (_, __) => false,
        calendarDate: (_) => true,
      );

  bool listenWhen() => !buildWhen();
}
