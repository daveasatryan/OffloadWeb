import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/scrollingBloc.dart/scrolling_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/scrollingBloc.dart/scrolling_state.dart';

@injectable
class ScrollingBloc extends Bloc<ScrollingEvent, ScrollingState> {
  ScrollingBloc() : super(const ScrollingState.scrolling(indexItem: 0)) {
    on<Right>((event, emit) => emit(ScrollingState.scrolling(indexItem: event.indexItem + 1)));
    on<Left>((event, emit) => emit(ScrollingState.scrolling(indexItem: event.indexItem - 1)));
  }
}
