import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_bloc.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_event.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/calendar_mobile_widget.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/edit_profile_screen_fields_mobile_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_send_feedback.dart';

class EditProfileScreenMobile extends BaseStatelessWidget {
  EditProfileScreenMobile({
    super.key,
    this.user,
    required this.weekDayList,
    required this.nameController,
    required this.sessionPriceController,
    required this.bioController,
    required this.certificationController,
    required this.locationController,
  });

  final TextEditingController nameController;
  final TextEditingController sessionPriceController;
  final TextEditingController bioController;
  final TextEditingController certificationController;
  final TextEditingController locationController;
  List<WeekDayModel> weekDayList;
  UserModel? user;

  @override
  Widget baseBuild(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.only(bottom: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.editProfileText,
                  style: fonts.poppinsBold.copyWith(fontSize: 30),
                ),
                CustomButton(
                  removeBorderColor: true,
                  isColorFilled: false,
                  onTap: () => context.read<EditProfileBloc>().add(
                        EditProfileEvent.editUserData(
                          uuid: user?.uuid ?? '',
                          name: nameController.text,
                          sessionPrice: sessionPriceController.text,
                          bio: bioController.text,
                          certifications: certificationController.text,
                          weekDayList: weekDayList,
                        ),
                      ),
                  color: colors.yellowColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 34,
                    ),
                    child: Text(
                      AppStrings.saveText,
                      style: fonts.poppinsBold.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          EditProfileScreenFieldsMobileWidget(
            lableText: AppStrings.profilePhotoText,
            isPhotoField: true,
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditProfileScreenFieldsMobileWidget(
                  lableText: AppStrings.nameLableText,
                  controller: nameController,
                  hint: AppStrings.nameHintText,
                  initialValue: user?.firstName ?? '',
                ),
                CalendarMobileWidget(weekDayList: weekDayList),
                EditProfileScreenFieldsMobileWidget(
                  lableText: AppStrings.sessionPriceText,
                  controller: sessionPriceController,
                  hint: AppStrings.sessionPriceHint,
                  initialValue: user?.sessionPrice ?? '',
                  isSessionPriceField: true,
                ),
                EditProfileScreenFieldsMobileWidget(
                  lableText: AppStrings.bioText,
                  controller: bioController,
                  hint: AppStrings.bioHint,
                  initialValue: user?.bio ?? '',
                  isBioField: true,
                ),
                EditProfileScreenFieldsMobileWidget(
                  lableText: AppStrings.certificationsText,
                  controller: certificationController,
                  hint: AppStrings.certificationsHint,
                  initialValue: user?.certifications ?? '',
                ),
                EditProfileScreenFieldsMobileWidget(
                  lableText: AppStrings.locationText,
                  controller: locationController,
                  hint: AppStrings.locationHint,
                  //todo initialValue
                  initialValue: '',
                  showUnderBorder: true,
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
          )
        ],
      ),
    );
  }
}
