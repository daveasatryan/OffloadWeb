import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_bloc.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_event.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/calendar/calendar_desktop_widget.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/edit_profile_screen_fields_desktop_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_send_feedback.dart';

class EditProfileScreenDesktop extends BaseStatelessWidget {
  EditProfileScreenDesktop({
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
  UserModel? user;
  List<WeekDayModel> weekDayList;
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
                      horizontal: 20,
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
          EditProfileScreenFieldsDesktopWidget(
            lableText: AppStrings.profilePhotoText,
            isPhotoFiled: true,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditProfileScreenFieldsDesktopWidget(
                lableText: AppStrings.nameLableText,
                controller: nameController,
                initialValue: user?.firstName ?? '',
                hint: AppStrings.nameHintText,
              ),
              CalendarDesktopWidget(
                weekDayList: weekDayList,
              ),
              EditProfileScreenFieldsDesktopWidget(
                lableText: AppStrings.sessionPriceText,
                controller: sessionPriceController,
                initialValue: user?.sessionPrice,
                isSessionPriceField: true,
                hint: AppStrings.sessionPriceHint,
              ),
              EditProfileScreenFieldsDesktopWidget(
                lableText: AppStrings.bioText,
                controller: bioController,
                initialValue: user?.bio,
                isBioField: true,
                hint: AppStrings.bioHint,
              ),
              EditProfileScreenFieldsDesktopWidget(
                lableText: AppStrings.certificationsText,
                controller: certificationController,
                initialValue: user?.certifications,
                hint: AppStrings.certificationsHint,
              ),
              EditProfileScreenFieldsDesktopWidget(
                showUnderBorder: true,
                lableText: AppStrings.locationText,
                controller: locationController,
                //todo initialValue
                initialValue: '',
                hint: AppStrings.locationHint,
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
          )
        ],
      ),
    );
  }
}
