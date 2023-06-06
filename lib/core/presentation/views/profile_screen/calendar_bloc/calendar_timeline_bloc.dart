import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/calendar_bloc/calendar_timeline_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/calendar_bloc/calendar_timeline_state.dart';

@injectable
class CalendarTimelineBloc extends Bloc<CalendarTimelineEvent, CalendarTimelineState> {
  CalendarTimelineBloc() : super(CalendarTimelineState.initial(DateTime.now(), false)) {
    on<ChangeCurrentDate>((event, emit) {
      bool showError = false;
      if (PreferencesManager.user == null) {
        showError = true;
      } else {
        showError = false;
      }
      emit(CalendarTimelineState.initial(event.date, showError));
    });

    on<ChangeCurrentDate>((event, emit) {
      bool showError = false;
      if (PreferencesManager.user == null) {
        showError = true;
      } else {
        showError = false;
      }
      emit(CalendarTimelineState.initial(event.date, showError));
    });
  }
}
