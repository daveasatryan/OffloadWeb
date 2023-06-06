import 'package:flutter/material.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/week_days_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class CalendarDesktopWidget extends BaseStatelessWidget {
  CalendarDesktopWidget({
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: sizes.width * .20,
            child: Text(
              AppStrings.consultationAvailabilityText,
              style: fonts.poppinsBold.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: sizes.width * .40,
              maxWidth: sizes.width * .45,
            ),
            child: SizedBox(
              child: Column(
                children: [
                  Text(
                    AppStrings.configureTimes,
                    style: fonts.poppinsRegular.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 20),
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
            ),
          ),
        ],
      ),
    );
  }
}
