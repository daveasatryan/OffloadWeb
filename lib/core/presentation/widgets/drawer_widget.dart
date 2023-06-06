import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_send_feedback.dart';

class DrawerWidget extends BaseStatelessWidget {
  DrawerWidget({
    super.key,
  });

  @override
  Widget baseBuild(BuildContext context) {
    return Drawer(
      backgroundColor: colors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.sp,
          vertical: 25.sp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppAssets.mobileMenuIcon,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.offloadText,
                        style: fonts.poppinsBold.copyWith(
                          fontSize: 30.sp,
                        ),
                      ),
                      SizedBox(width: 5.sp),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: colors.whisperColor,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 5.sp,
                          horizontal: 20.sp,
                        ),
                        child: Text(
                          AppStrings.betaText,
                          style: fonts.poppinsBold.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 70.sp),
            Column(
              children: [
                CustomSendFeedback(),
                SizedBox(height: 10.sp),
                Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    return userProvider.user == null
                        ? SizedBox(
                            child: CustomButton(
                              removeBorderColor: true,
                              color: colors.yellowColor,
                              isColorFilled: false,
                              onTap: () {},
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.sp),
                                  child: Text(
                                    AppStrings.joinAsATherapistText,
                                    style: fonts.poppinsMedium.copyWith(fontSize: 13.sp),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox();
                  },
                )
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.getInTouchText,
                  style: fonts.poppinsBold.copyWith(
                    fontSize: 11.sp,
                    color: colors.drawerTouchColor,
                  ),
                ),
                SizedBox(height: 10.sp),
                Text(
                  PreferencesManager.user?.email ?? '',
                  style: fonts.poppinsMedium.copyWith(
                    fontSize: 11.sp,
                    color: colors.lableColor,
                  ),
                ),
                SizedBox(height: 70.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
