import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrolling_state.freezed.dart';

@freezed
class ScrollingState with _$ScrollingState {
  const factory ScrollingState.scrolling({
    required int indexItem,
  }) = _$ScrollingStateScrolling;
}

extension ScrollingStateExt on ScrollingState {
  bool buildWhen() => when(
        scrolling: (_) => false,
      );

  bool listenWhen() => !buildWhen();
}
