import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:therapist_journey/core/data/models/calendar/date_book_item_model.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/data/utilities/date_utilities.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/scrollingBloc.dart/scrolling_bloc.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/scrollingBloc.dart/scrolling_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/scrollingBloc.dart/scrolling_state.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/calendar_bloc/calendar_timeline_bloc.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/calendar_bloc/calendar_timeline_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/calendar_bloc/calendar_timeline_state.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/call_confirm/confirm_call_dialog.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/profile_screen_fields_desktop_widget.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/week_days_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_send_feedback.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_svg_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/user_name_widget.dart';

class ProfileScreenDesktop extends StatefulWidget {
  ProfileScreenDesktop({
    super.key,
    this.user,
  });
  UserModel? user;

  @override
  State<ProfileScreenDesktop> createState() => _ProfileScreenDesktopState();
}

class _ProfileScreenDesktopState extends BaseState<ProfileScreenDesktop> {
  final currentWeek = DateUtilities.nextWeek.values.toList();
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  int indexFirstItem = 0;
  int indexLastItem = 0;
  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(() {
      indexFirstItem = itemPositionsListener.itemPositions.value.first.index;
      indexLastItem = itemPositionsListener.itemPositions.value.last.index;
    });
  }

  @override
  void dispose() {
    itemPositionsListener.itemPositions.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          InkWell(
            onTap: () => AppRoutes.back(),
            child: SvgPicture.asset(
              AppAssets.backIcon,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 185,
                  height: 185,
                  child: Consumer<UserProvider>(
                    builder: (context, value, child) =>
                        widget.user?.image != null || value.user?.image != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage((widget.user?.uuid == value.user?.uuid
                                        ? value.user?.image
                                        : widget.user?.image) ??
                                    ''),
                                backgroundColor: Colors.transparent,
                              )
                            : SvgPicture.asset(AppAssets.profileEmptyIcon),
                  ),
                ),
                const SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserNameWidget(
                      size: 24,
                      name: widget.user?.firstName != ''
                          ? widget.user?.firstName ?? AppStrings.noNameYetText
                          : AppStrings.noNameYetText,
                    ),
                    const SizedBox(height: 10),
                    widget.user?.uuid == PreferencesManager.user?.uuid
                        ? CustomButton(
                            removeBorderColor: true,
                            isColorFilled: false,
                            onTap: () => Get.rootDelegate.toNamed(AppRoutes.editProfileRoute),
                            color: colors.yellowColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 30,
                              ),
                              child: Text(
                                AppStrings.editProfileText,
                                style: fonts.poppinsBold.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 25.sp),
          Text(
            AppStrings.bookAFreeText,
            style: fonts.poppinsMedium.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          BlocProvider(
            create: (context) => context.read<BlocFactory>().create<CalendarTimelineBloc>(),
            child: BlocBuilder<CalendarTimelineBloc, CalendarTimelineState>(
              builder: (context, state) {
                final currentTimeline = widget.user?.graphic
                        .firstWhereOrNull((element) => element.day.isSameDay(state.currentDay))
                        ?.weekBookList ??
                    [];
                List<DateBookItemModel> currentTimelineList =
                    widget.user?.listProfileDate(currentTimeline) ?? [];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 48,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: currentWeek.length,
                        itemBuilder: (context, index) {
                          final canBeSelected = widget.user?.graphic
                                  .firstWhere(
                                      (element) => element.day.isSameDay(currentWeek[index]))
                                  .weekBookList
                                  .any((element) => element.isBooked == false) ??
                              false;
                          final isSelected = currentWeek[index].isSameDay(state.currentDay);
                          final weekDay = widget.user?.graphic[index].day ?? DateTime.now();

                          return InkWell(
                            onTap: canBeSelected == true
                                ? () {
                                    context.read<CalendarTimelineBloc>().add(
                                        CalendarTimelineEvent.changeCurrentDate(
                                            currentWeek[index]));
                                  }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: WeekDaysWidget(
                                numberDay: DateUtilities.printDateWithLine(
                                    widget.user?.graphic[index].day ?? DateTime.now(),
                                    pattern: 'dd'),
                                weekDay: weekDay,
                                isSelected: isSelected,
                                canBeSelected: canBeSelected,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    BlocProvider(
                      create: (context) => context.read<BlocFactory>().create<ScrollingBloc>(),
                      child: BlocBuilder<ScrollingBloc, ScrollingState>(
                        builder: (context, stateScroll) {
                          return Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: currentTimelineList.isNotEmpty
                                        ? () {
                                            if (indexFirstItem > 0) {
                                              _scrollController.scrollTo(
                                                index: indexFirstItem - 1,
                                                curve: Curves.linear,
                                                duration: const Duration(milliseconds: 300),
                                              );
                                              context
                                                  .read<ScrollingBloc>()
                                                  .add(ScrollingEvent.left(indexFirstItem));
                                            }
                                          }
                                        : null,
                                    child: CustomSvgWidget(
                                      icon: AppAssets.leftContainerIcon,
                                      iconColor: stateScroll.indexItem == 0
                                          ? colors.inputTextfieldColor
                                          : colors.blackOpacityColor,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: SizedBox(
                                      height: 36,
                                      child: ScrollablePositionedList.builder(
                                        itemScrollController: _scrollController,
                                        itemPositionsListener: itemPositionsListener,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: currentTimelineList.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: PreferencesManager.user == null
                                                ? () => showDialog<void>(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return const ConfirmCallDialog();
                                                      },
                                                    )
                                                : () {
                                                    //todo call event for showing error
                                                  },
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 10),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                    color: colors.yellowColor),
                                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                                child: Text(
                                                  DateUtilities.printMinutesName(
                                                    currentTimelineList[index].startDate,
                                                  ).toLowerCase(),
                                                  style: fonts.poppinsMedium.copyWith(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: currentTimelineList.isNotEmpty
                                        ? () {
                                            if (indexLastItem != currentTimelineList.length) {
                                              _scrollController.scrollTo(
                                                index: indexFirstItem + 1,
                                                curve: Curves.linear,
                                                duration: const Duration(milliseconds: 300),
                                              );
                                              context
                                                  .read<ScrollingBloc>()
                                                  .add(ScrollingEvent.right(indexLastItem));
                                            }
                                          }
                                        : null,
                                    child: CustomSvgWidget(
                                      icon: AppAssets.rightContainerIcon,
                                      iconColor: stateScroll.indexItem == currentTimelineList.length
                                          ? colors.inputTextfieldColor
                                          : colors.blackOpacityColor,
                                    ),
                                  ),
                                ],
                              ),
                              state.showError
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            AppAssets.errorStateIcon,
                                            width: 15,
                                            height: 15,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                AppStrings.holdOn,
                                                style: fonts.poppinsRegular.copyWith(
                                                  color: colors.errorTextColor,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          ProfileScreenFieldsDesktopWidget(
            lableText: AppStrings.bioText,
            valueText: widget.user?.bio != ''
                ? widget.user?.bio ?? AppStrings.noBioYetText
                : AppStrings.noBioYetText,
            showBioText: true,
          ),
          ProfileScreenFieldsDesktopWidget(
            lableText: AppStrings.sessionPriceText,
            valueText: widget.user?.sessionPrice != ''
                ? '${widget.user?.sessionPrice} ${AppStrings.fullSessionPriceValue}'
                : AppStrings.noSessionPriceYetText,
          ),
          ProfileScreenFieldsDesktopWidget(
            lableText: AppStrings.typeText,
            valueText: AppStrings.onlineText,
          ),
          ProfileScreenFieldsDesktopWidget(
            lableText: AppStrings.certificationsText,
            valueText: widget.user?.certifications != ''
                ? widget.user?.certifications ?? AppStrings.noCertificationAddedYetText
                : AppStrings.noCertificationAddedYetText,
            showButtonBorder: true,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
              bottom: 25,
            ),
            child: Center(
              child: CustomSendFeedback(),
            ),
          ),
        ],
      ),
    );
  }
}
