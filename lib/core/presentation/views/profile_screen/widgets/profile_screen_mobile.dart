import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
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
import 'package:therapist_journey/core/presentation/views/profile_screen/calendar_bloc/calendar_timeline_bloc.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/calendar_bloc/calendar_timeline_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/calendar_bloc/calendar_timeline_state.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/call_confirm/confirm_call_dialog.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/profile_screen_fields_mobile_widget.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/week_days_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_send_feedback.dart';
import 'package:therapist_journey/core/presentation/widgets/user_name_widget.dart';

class ProfileScreenMobile extends StatefulWidget {
  ProfileScreenMobile({
    super.key,
    this.user,
  });
  UserModel? user;

  @override
  State<ProfileScreenMobile> createState() => _ProfileScreenMobileState();
}

class _ProfileScreenMobileState extends BaseState<ProfileScreenMobile> {
  final currentWeek = DateUtilities.nextWeek.values.toList();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.sp),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => AppRoutes.back(),
                  child: SizedBox(
                    width: sizes.width * .10,
                    child: SvgPicture.asset(
                      AppAssets.backIcon,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 144,
                        height: 144,
                        child: Consumer<UserProvider>(
                          builder: (context, value, child) =>
                              widget.user?.image != null || value.user?.image != null
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          (widget.user?.uuid == value.user?.uuid
                                                  ? value.user?.image
                                                  : widget.user?.image) ??
                                              ''),
                                      backgroundColor: Colors.transparent,
                                    )
                                  : SvgPicture.asset(AppAssets.profileEmptyIcon),
                        ),
                      ),
                      const SizedBox(height: 10),
                      UserNameWidget(
                        size: 0,
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
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.bookAonsultationText,
                style: fonts.poppinsRegular.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 15),
              BlocProvider(
                create: (context) => context.read<BlocFactory>().create<CalendarTimelineBloc>(),
                child: BlocBuilder<CalendarTimelineBloc, CalendarTimelineState>(
                  builder: (context, state) {
                    final currentTimeline0 = widget.user?.graphic
                            .firstWhereOrNull((element) => element.day.isSameDay(state.currentDay))
                            ?.weekBookList ??
                        [];
                    List<DateBookItemModel> currentTimeline =
                        widget.user?.listProfileDate(currentTimeline0) ?? [];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: colors.whiteColor),
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
                                onTap: canBeSelected
                                    ? () {
                                        context.read<CalendarTimelineBloc>().add(
                                              CalendarTimelineEvent.changeCurrentDate(
                                                currentWeek[index],
                                              ),
                                            );
                                      }
                                    : null,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: WeekDaysWidget(
                                    numberDay: DateUtilities.printDateWithLine(
                                        DateUtilities.nextWeek[index] ?? DateTime.now(),
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
                        SizedBox(
                          height: 36,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: currentTimeline.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const ConfirmCallDialog();
                                  },
                                ),
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
                                        currentTimeline[index].startDate,
                                      ),
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
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              ProfileScreenFieldsMobileWidget(
                lableText: AppStrings.bioText,
                valueText: widget.user?.bio != ''
                    ? widget.user?.bio ?? AppStrings.noBioYetText
                    : AppStrings.noBioYetText,
                showBioText: true,
              ),
              ProfileScreenFieldsMobileWidget(
                lableText: AppStrings.sessionPriceText,
                valueText: widget.user?.sessionPrice != ''
                    ? '${widget.user?.sessionPrice} ${AppStrings.fullSessionPriceValue}'
                    : AppStrings.noSessionPriceYetText,
              ),
              ProfileScreenFieldsMobileWidget(
                lableText: AppStrings.typeText,
                valueText: AppStrings.onlineText,
              ),
              ProfileScreenFieldsMobileWidget(
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
        ],
      ),
    );
  }
}
