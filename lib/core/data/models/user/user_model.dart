import 'package:dart_date/dart_date.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/models/calendar/calendars_model.dart';
import 'package:therapist_journey/core/data/models/calendar/date_book_item_model.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';
import 'package:therapist_journey/core/data/utilities/date_utilities.dart';
import 'package:therapist_journey/core/data/utilities/helper.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'uuid') String? uuid,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'sessionPrice') String? sessionPrice,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'verified') bool? verified,
    @JsonKey(name: 'bio') String? bio,
    @JsonKey(name: 'certifications') String? certifications,
    @JsonKey(name: 'token') String? token,
    @JsonKey(name: 'isOnline') bool? isOnline,
    @JsonKey(name: 'calendars') List<CalendarsModel>? calendars,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) => _$UserModelFromJson(json);
}

extension UserModelExt on UserModel {
  List<WeekDayModel> get graphic {
    final nextWeek = DateUtilities.nextWeek.values;
    final result = nextWeek.map(
      (weekDay) {
        final currentDayCalendar = calendars
                ?.where((element) => (element.startDate
                            ?.let((that) => DateTime.fromMillisecondsSinceEpoch(that * 1000)) ??
                        DateTime.now())
                    .isSameDay(weekDay))
                .toList() ??
            [];
        final currentDaygraphic = currentDayCalendar.mapIndexed(
          (index, e) => DateBookItemModel(
            uuid: e.uuid,
            isBooked: e.isBooked ?? false,
            isRepeat: e.isRepeat ?? false,
            startDate:
                e.startDate?.let((that) => DateTime.fromMillisecondsSinceEpoch(that * 1000)) ??
                    DateTime.now(),
            endDate: e.endDate?.let((that) => DateTime.fromMillisecondsSinceEpoch(that * 1000)) ??
                DateTime.now(),
            startTimeList: _startTimeMinutesMap(
              DateTime.fromMillisecondsSinceEpoch(
                (currentDayCalendar.getOrNull(index - 1)?.startDate ??
                        startOfDayInSeconds(e.startDate)) *
                    1000,
              ),
            ).values.toList(),
            endTimeList: _startTimeMinutesMap(
              DateTime.fromMillisecondsSinceEpoch((e.startDate ?? 0) * 1000).add(
                const Duration(minutes: 15),
              ),
            ).values.toList(),
          ),
        );
        return WeekDayModel(
          day: weekDay,
          weekBookList: currentDaygraphic,
        );
      },
    );
    return result.toList();
  }

  Map<int, DateTime> _startTimeMinutesMap(DateTime startFrom) {
    final Map<int, DateTime> map = {};

    DateTime endTime = DateTime(startFrom.year, startFrom.month, startFrom.day, 21, 0, 0);

    int i = 0;
    while (startFrom.millisecondsSinceEpoch < endTime.millisecondsSinceEpoch) {
      map[i] = startFrom;
      startFrom = startFrom.add(const Duration(minutes: 15));
      i++;
    }
    return map;
  }

  int startOfDayInSeconds(int? seconds) {
    if (seconds == null) return 0;

    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000)
            .copyWith(hour: 6, minute: 0, second: 0, microsecond: 0)
            .millisecondsSinceEpoch ~/
        1000;
  }

  List<DateBookItemModel> listProfileDate(List<DateBookItemModel> currentTimeline) {
    for (var model in currentTimeline) {
      if (model.startDate <
          model.endDate.subtract(
            const Duration(minutes: 15),
          )) {
        currentTimeline.add(
          model.copyWith(
            uuid: null,
            isRepeat: false,
            startDate: model.startDate.add(
              const Duration(minutes: 15),
            ),
            endDate: (model.endDate),
            isBooked: false,
          ),
        );
      }
    }
    currentTimeline.sort((first, secund) => first.startDate.compareTo(secund.startDate));
    return currentTimeline;
  }
}
