import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/bloc/calendar_event.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/bloc/calendar_state.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/week_days_desktop_widget.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/week_days_mobile_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class WeekDaysWidget extends BaseStatelessWidget {
  WeekDaysWidget({super.key, required this.weekDay});
  WeekDayModel weekDay;
  @override
  Widget baseBuild(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          context.read<BlocFactory>().create<CalendarBloc>()..add(CalendarEvent.initial(weekDay)),
      child: BlocConsumer<CalendarBloc, CalendarState>(
        buildWhen: (previous, current) => current.buildWhen(),
        listenWhen: (previous, current) => current.listenWhen(),
        listener: (context, state) => state.whenOrNull(
          success: () {
            return null;
          },
          loading: () => showLoading(context),
          error: (msg, code) => showErrorDialog(context, msg: msg),
        ),
        builder: (context, state) => state.maybeWhen(
          orElse: () => Container(),
          calendarDate: (dateBookList) {
            hideLoading(context);
            return isMobile
                ? WeekDaysMobildeWidget(
                    weekDay: weekDay,
                  )
                : WeekDaysDesktopWidget(
                    weekDay: weekDay,
                  );
          },
        ),
      ),
    );
  }
}
