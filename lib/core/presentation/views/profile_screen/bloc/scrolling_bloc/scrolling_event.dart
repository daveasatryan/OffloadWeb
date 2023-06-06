import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrolling_event.freezed.dart';

@freezed
class ScrollingEvent with _$ScrollingEvent {
  
  const factory ScrollingEvent.initial() = ScrollingInitial;
  const factory ScrollingEvent.scrollingRight(int index) = ScrollingRight;
  const factory ScrollingEvent.scrollingLeft(int index) = ScrollingLeft;
}