import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/models/calendar/date_book_item_model.dart';
import 'package:therapist_journey/core/data/utilities/date_utilities.dart';

part 'week_day_model.freezed.dart';

part 'week_day_model.g.dart';

@Freezed(
  addImplicitFinal: false,
  makeCollectionsUnmodifiable: false,
)
class WeekDayModel with _$WeekDayModel {
  factory WeekDayModel({
    required DateTime day,
    required List<DateBookItemModel> weekBookList,
  }) = _WeekDayModel;

  factory WeekDayModel.fromJson(Map<String, Object?> json) => _$WeekDayModelFromJson(json);
}

extension WeekDayModelExt on WeekDayModel {
  String get dayName => DateUtilities.printWeekName(day);
}
