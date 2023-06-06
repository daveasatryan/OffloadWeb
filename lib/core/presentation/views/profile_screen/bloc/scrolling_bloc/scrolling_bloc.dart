import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/scrolling_bloc/scrolling_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/scrolling_bloc/scrolling_state.dart';

@injectable
class ScrollingBloc extends Bloc<ScrollingEvent, ScrollingState> {
  ScrollingBloc() : super(const ScrollingState.scrollPosition(index: 1)) {
      on<ScrollingLeft>((event, emit) {
      print(event.index);
      emit(ScrollingState.scrollPosition(index: event.index >0 ?event.index - 1:0));
    });

    on<ScrollingRight>((event, emit) {
      print(event.index);
      
      emit(ScrollingState.scrollPosition(index: event.index + 1));
    });

  
  }
}
