import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrolling_event.freezed.dart';

@freezed
class ScrollingEvent with _$ScrollingEvent {
  const factory ScrollingEvent.initial(int indexItem) = Initial;
  const factory ScrollingEvent.right(int indexItem) = Right;
  const factory ScrollingEvent.left(int indexItem) = Left;
}
