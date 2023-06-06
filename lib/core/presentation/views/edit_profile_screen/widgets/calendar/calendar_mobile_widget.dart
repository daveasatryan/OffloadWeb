import 'package:flutter/material.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/week_days_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class CalendarMobileWidget extends BaseStatelessWidget {
  CalendarMobileWidget({
    super.key,
    required this.weekDayList,
  });

  final List<WeekDayModel> weekDayList;

  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 25,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colors.whisperColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.consultationAvailabilityText,
            style: fonts.poppinsBold.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.configureTimes,
            style: fonts.poppinsRegular.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 25),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: weekDayList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: WeekDaysWidget(
                      weekDay: weekDayList[index],
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
