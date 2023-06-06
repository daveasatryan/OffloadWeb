import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/privacy_policy/widgets/text_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends BaseState<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteColor,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : sizes.width * .6,
            minWidth: isMobile ? double.infinity : sizes.width * .6,
            minHeight: isMobile ? double.infinity : 0.0,
          ),
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  InkWell(
                    onTap: () => AppRoutes.back(),
                    child: SvgPicture.asset(
                      AppAssets.backIcon,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextWidget(
                    header: AppStrings.privacyPolicyText,
                    text: AppStrings.thankYouForVisiting,
                    footerText: AppStrings.lastUpdated,
                    headerStyle: fonts.poppinsBold.copyWith(
                      color: colors.black,
                      fontSize: 17,
                    ),
                  ),
                  TextWidget(
                    header: AppStrings.dataCollection,
                    text: AppStrings.weCollectYourEmail,
                  ),
                  TextWidget(
                    header: AppStrings.dataProtection,
                    text: AppStrings.weTakeAppropriate,
                  ),
                  TextWidget(
                    header: AppStrings.internationalDataTransfers,
                    text: AppStrings.weMayTransferYour,
                  ),
                  TextWidget(
                    header: AppStrings.dataRetention,
                    text: AppStrings.weWillOnlyRetain,
                  ),
                  TextWidget(
                    header: AppStrings.yourRights,
                    text: AppStrings.underTheGdpr,
                    pointsList: const [
                      AppStrings.theRightToAccess,
                      AppStrings.theRightToRectify,
                      AppStrings.theRightToErasure,
                      AppStrings.theRightToRestrict,
                      AppStrings.theRightToData,
                      AppStrings.theRightToObject,
                    ],
                    footerText: AppStrings.toExerciseYour,
                  ),
                  TextWidget(
                    header: AppStrings.dataBreaches,
                    text: AppStrings.weHaveProcedures,
                  ),
                  TextWidget(
                    header: AppStrings.ageRestrictions,
                    text: AppStrings.ourProductWaitlist,
                  ),
                  TextWidget(
                    header: AppStrings.updatesToOur,
                    text: AppStrings.weMayUpdateThis,
                  ),
                  TextWidget(
                    header: AppStrings.concatUs,
                    text: AppStrings.ifYouHaveAnyQuestions,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
