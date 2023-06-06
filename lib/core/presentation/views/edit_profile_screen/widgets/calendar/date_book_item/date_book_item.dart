import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:therapist_journey/core/data/models/calendar/date_book_item_model.dart';
import 'package:therapist_journey/core/data/utilities/date_utilities.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_bloc.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/bloc/calendar_event.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_drop_down_widget.dart';

class DateBookItem extends BaseStatelessWidget {
  final DateBookItemModel weekBook;
  final int index;
  DateBookItem({
    super.key,
    required this.index,
    required this.weekBook,
  });
  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: CustomDropDown<DateTime>(
              value: weekBook.startDate,
              color: colors.black,
              borderWidth: 2,
              borderRadius: 5,
              style: fonts.poppinsRegular.copyWith(fontSize: 13),
              borderColor: colors.popupbBorderColor,
              showDropDownIcon: false,
              onChanged: (onChange) {},
              items: weekBook.startTimeList
                  .map(
                    (item) => DropdownMenuItem<DateTime>(
                      onTap: () {
                        context.read<CalendarBloc>().add(
                              CalendarEvent.startTime(weekBook, item),
                            );
                      },
                      value: item,
                      child: Text(
                        DateUtilities.printMinutesName(item).toLowerCase(),
                        style: fonts.poppinsRegular.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '-',
            style: fonts.poppinsRegular.copyWith(
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: CustomDropDown<DateTime>(
              value: weekBook.endDate,
              color: colors.black,
              borderWidth: 2,
              borderRadius: 5,
              style: fonts.poppinsRegular.copyWith(fontSize: 13),
              borderColor: colors.popupbBorderColor,
              showDropDownIcon: false,
              onChanged: (onChange) {},
              items: weekBook.endTimeList
                  .map(
                    (item) => DropdownMenuItem<DateTime>(
                      onTap: () => context.read<CalendarBloc>().add(
                            CalendarEvent.endTime(weekBook, item),
                          ),
                      value: item,
                      child: Text(
                        DateUtilities.printMinutesName(item).toLowerCase(),
                        style: fonts.poppinsRegular.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          InkWell(
            onTap: () {
              context.read<CalendarBloc>().add(
                    CalendarEvent.calendarBookMeeting(weekBook),
                  );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                weekBook.isRepeat == true
                    ? AppAssets.changeItemEnableIcon
                    : AppAssets.changeItemDisableIcon,
                width: 17,
                height: 17,
              ),
            ),
          ),
          isMobile
              ? Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: InkWell(
                        onTap: () {
                          context.read<CalendarBloc>().add(
                                CalendarEvent.calendarDeleteTime(
                                    weekBook, context.read<EditProfileBloc>().calendarUuidsList),
                              );
                        },
                        child: SvgPicture.asset(
                          AppAssets.deleteIcon,
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {
                      context.read<CalendarBloc>().add(
                            CalendarEvent.calendarDeleteTime(
                              weekBook,
                              context.read<EditProfileBloc>().calendarUuidsList,
                            ),
                          );
                    },
                    child: SvgPicture.asset(
                      AppAssets.deleteIcon,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
