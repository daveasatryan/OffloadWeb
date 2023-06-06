import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/bloc/calendar_event.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/date_book_item/date_book_item.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class WeekDaysDesktopWidget extends BaseStatelessWidget {
  WeekDaysDesktopWidget({
    super.key,
    required this.weekDay,
  });

  final WeekDayModel weekDay;
  @override
  Widget baseBuild(BuildContext context) {
    final isToday = weekDay.day.isSameDay(DateTime.now());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              isToday ? 'TODAY' : weekDay.dayName.toUpperCase(),
              style: fonts.poppinsMedium.copyWith(fontSize: 13),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weekDay.weekBookList.length,
            itemBuilder: (context, indexItem) {
              return DateBookItem(
                index: indexItem,
                weekBook: weekDay.weekBookList[indexItem],
              );
            },
          ),
        ),
        const SizedBox(width: 50),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(5),
              color: colors.yellowColor,
            ),
            child: InkWell(
              onTap: () => context.read<CalendarBloc>().add(
                    CalendarEvent.calendarAddTime(weekDay),
                  ),
              child: Image.asset(
                AppAssets.addIcon,
                width: 11,
                height: 11,
              ),
            ),
          ),
        )
      ],
    );
  }
}
