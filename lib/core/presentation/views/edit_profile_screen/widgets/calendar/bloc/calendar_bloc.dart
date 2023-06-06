import 'package:bloc/bloc.dart';
import 'package:dart_date/dart_date.dart';
import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/models/calendar/date_book_item_model.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';
import 'package:therapist_journey/core/data/utilities/helper.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/bloc/calendar_event.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/bloc/calendar_state.dart';

@injectable
class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const CalendarState.initial()) {
    on<Initial>(
      (event, emit) {
        dayModel = event.weekDay;
        emit(
          CalendarState.calendarDate(
            dateBooKList: List.from(dateBookList),
          ),
        );
      },
    );
    on<CalendarBookMeeting>(
      (event, emit) {
        event.dateBookItem.isRepeat = !event.dateBookItem.isRepeat;
        emit(
          CalendarState.calendarDate(
            dateBooKList: List.from(dateBookList),
          ),
        );
      },
    );

    on<CalendarDeleteTime>(
      (event, emit) {
        if (event.dateBookItem.uuid?.isNotNullOrEmpty() == true) {
          event.deletedUuidList.add(event.dateBookItem.uuid ?? '');
        }

        dayModel.weekBookList.remove(event.dateBookItem);
        emit(
          CalendarState.calendarDate(
            dateBooKList: List.from(dateBookList),
          ),
        );
      },
    );

    on<CalendarAddTime>(
      (event, emit) {
        if (dateBookList.isEmpty) {
          final start = initialStartTime;
          final end = initialStartTime.add(const Duration(minutes: 15));
          dateBookList.add(
            DateBookItemModel(
              isBooked: false,
              isRepeat: false,
              startDate: start,
              endDate: end,
              startTimeList: List.from(startTimeMinutesMap(start).values.toList()),
              endTimeList: List.from(startTimeMinutesMap(end).values.toList()),
            ),
          );
        } else {
          final lastItem = dateBookList.last;
          final start = lastItem.endDate;
          final end = lastItem.endDate.add(const Duration(minutes: 15));
          dateBookList.add(
            DateBookItemModel(
              isBooked: false,
              isRepeat: false,
              startDate: start,
              endDate: end,
              startTimeList: List.from(startTimeMinutesMap(start).values.toList()),
              endTimeList: List.from(startTimeMinutesMap(end).values.toList()),
            ),
          );
        }

        emit(
          CalendarState.calendarDate(
            dateBooKList: List.from(dateBookList),
          ),
        );
      },
    );
    on<StartTime>(
      (event, emit) {
        selectStartDate(event.dateBookItem, event.date);
        emit(
          CalendarState.calendarDate(
            dateBooKList: List.from(dateBookList),
          ),
        );
      },
    );

    on<EndTime>(
      (event, emit) {
        selectEndDate(event.dateBookItem, event.date);

        emit(
          CalendarState.calendarDate(
            dateBooKList: List.from(dateBookList),
          ),
        );
      },
    );
  }

  void selectStartDate(DateBookItemModel model, DateTime time) {
    model.startDate = time;
    if (model.startDate < model.endDate) return;
    selectEndDate(model, time.add(const Duration(minutes: 15)));
  }

  void selectEndDate(DateBookItemModel model, DateTime time) {
    model.endDate = time;
    model.endTimeList = List.from(
        startTimeMinutesMap(model.startDate.add(const Duration(minutes: 15))).values.toList());
    final nextItem = dateBookList.getOrNull(dateBookList.indexOf(model) + 1);

    if (nextItem == null) return;
    if (nextItem.startDate >= model.endDate) return;

    nextItem.startTimeList = startTimeMinutesMap(time).values.toList();
    selectStartDate(nextItem, time);
  }

  List<DateBookItemModel> get dateBookList => dayModel.weekBookList;
  List<String> calendarUuidsList = [];
  late WeekDayModel dayModel;

  DateTime get initialStartTime =>
      DateTime(dayModel.day.year, dayModel.day.month, dayModel.day.day, 6, 0, 0);

  Map<int, DateTime> startTimeMinutesMap(DateTime startFrom) {
    final Map<int, DateTime> map = {};

    DateTime endTime = DateTime(startFrom.year, startFrom.month, startFrom.day, 21, 0, 0);

    int i = 0;
    while (startFrom.millisecondsSinceEpoch < endTime.millisecondsSinceEpoch) {
      map[i] = startFrom;
      startFrom = startFrom.add(const Duration(milliseconds: 900000));
      i++;
    }
    return map;
  }
}
