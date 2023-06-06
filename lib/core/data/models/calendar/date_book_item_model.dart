import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:therapist_journey/core/data/models/calendar/calendars_model.dart';

part 'date_book_item_model.freezed.dart';

part 'date_book_item_model.g.dart';

@Freezed(
  addImplicitFinal: false,
  makeCollectionsUnmodifiable: false,
  
)
class DateBookItemModel with _$DateBookItemModel {
  factory DateBookItemModel({
    String? uuid,
    required bool isBooked,
    required bool isRepeat,
    required DateTime startDate,
    required DateTime endDate,
    required List<DateTime> startTimeList,
    required List<DateTime> endTimeList,
  }) = _DateBookItemModel;

  factory DateBookItemModel.fromJson(Map<String, Object?> json) =>
      _$DateBookItemModelFromJson(json);
}

extension DateBookItemModelExt on DateBookItemModel {
  int get startDateSeconds => startDate.millisecondsSinceEpoch ~/ 1000;
  int get endDateSeconds => endDate.millisecondsSinceEpoch ~/ 1000;

  CalendarsModel toRequestModel() => CalendarsModel(
        uuid: uuid,
        startDate: startDateSeconds,
        endDate: endDateSeconds,
        isBooked: isBooked,
        isRepeat: isRepeat,
      );
}
