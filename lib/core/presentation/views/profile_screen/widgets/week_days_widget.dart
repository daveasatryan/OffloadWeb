import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:therapist_journey/core/data/utilities/date_utilities.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class WeekDaysWidget extends BaseStatelessWidget {
  WeekDaysWidget({
    super.key,
    required this.numberDay,
    required this.weekDay,
    required this.isSelected,
    required this.canBeSelected,
  });
  DateTime weekDay;
  String numberDay;
  bool isSelected;
  bool canBeSelected;

  @override
  Widget baseBuild(BuildContext context) {
    final isToday = weekDay.isSameDay(DateTime.now());
    return Container(
      width: 42,
      decoration: BoxDecoration(
        color: isSelected
            ? colors.yellowColor
            : canBeSelected
                ? colors.canBeSelectedColor
                : colors.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                isToday ? 'TODAY' : DateUtilities.printDateWithLine(weekDay, pattern: 'EEE'),
                style: fonts.poppinsMedium.copyWith(fontSize: 11),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 5),
            child: Text(
              numberDay,
              style: fonts.poppinsMedium,
            ),
          ),
          isToday
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '.',
                    style: fonts.poppinsMedium.copyWith(fontSize: 20),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
