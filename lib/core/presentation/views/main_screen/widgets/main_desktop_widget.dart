import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/main_users_list_widget.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/create_account/create_account_services_widget.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/send_feedback/send_feedback_dialog.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';

class MainDesktopWidget extends StatefulWidget {
  const MainDesktopWidget({super.key, required this.userList});

  final List<UserModel>? userList;
  @override
  State<MainDesktopWidget> createState() => _MainDesktopWidgetState();
}

class _MainDesktopWidgetState extends BaseState<MainDesktopWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: sizes.width * .43,
                maxWidth: sizes.width * .53,
              ),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 80),
                    Center(
                      child: Text(
                        AppStrings.aMentalHealthText,
                        textAlign: TextAlign.center,
                        style: fonts.poppinsBold.copyWith(fontSize: 34),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: CreateAccountServicesWidget(
                            text: AppStrings.findTheRightText,
                            icon: AppAssets.raisingHandsIcon,
                          ),
                        ),
                        Expanded(
                          child: CreateAccountServicesWidget(
                            text: AppStrings.allTherapistsOfferText,
                            icon: AppAssets.smilingFaceIcon,
                          ),
                        ),
                        Expanded(
                          child: CreateAccountServicesWidget(
                            text: AppStrings.youChooseTheTherapistText,
                            icon: AppAssets.handsIcon,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                    Text(
                      AppStrings.meetTherapistsText,
                      style: fonts.poppinsMedium.copyWith(fontSize: 19),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(),
                  child: SizedBox(
                    width: sizes.width * .17,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        CustomButton(
                          isColorFilled: false,
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return const SendFeedbackDialog();
                              },
                            );
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 10,
                              ),
                              child: Text(
                                AppStrings.sendFeedbackText,
                                style: fonts.poppinsMedium.copyWith(fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                            return userProvider.user == null
                                ? SizedBox(
                                    child: CustomButton(
                                      removeBorderColor: true,
                                      color: colors.yellowColor,
                                      isColorFilled: false,
                                      onTap: () {
                                        Get.rootDelegate.toNamed(AppRoutes.profileRoute);
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          child: Text(
                                            AppStrings.joinAsATherapistText,
                                            style: fonts.poppinsMedium.copyWith(fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox();
                          },
                        ),
                        const SizedBox(height: 40),
                        Text(
                          AppStrings.getInTouchText,
                          style: fonts.poppinsBold.copyWith(
                            fontSize: 11,
                            color: colors.lableColor,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          PreferencesManager.user?.email ?? '',
                          style: fonts.poppinsMedium.copyWith(
                            fontSize: 11,
                            color: colors.lableColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                SizedBox(
                  width: sizes.width * .39,
                  child: MainUsersListlWidget(usersList: widget.userList ?? []),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
