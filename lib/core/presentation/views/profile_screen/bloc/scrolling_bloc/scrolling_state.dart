import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrolling_state.freezed.dart';

@Freezed(
  equal: false,
)
class ScrollingState with _$ScrollingState {
  const factory ScrollingState.scrollPosition({required int index}) =
      _$ScrollingStatesSrollPosition;
}

extension ScrollingStateExt on ScrollingState {
  bool buildWhen() => when(
        scrollPosition: (_) => true,
      );

  bool listenWhen() => !buildWhen();
}
