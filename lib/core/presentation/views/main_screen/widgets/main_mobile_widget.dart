import 'package:flutter/material.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/main_users_list_widget.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/create_account/create_account_services_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class MainMobileWidget extends BaseStatelessWidget {
  MainMobileWidget({super.key, required this.userList});

  final List<UserModel>? userList;
  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Text(
              AppStrings.aMentalHealthText,
              textAlign: TextAlign.center,
              style: fonts.poppinsBold.copyWith(fontSize: 34),
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: sizes.width * .66,
              child: CreateAccountServicesWidget(
                text: AppStrings.findTheRightText,
                icon: AppAssets.raisingHandsIcon,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: sizes.width * .66,
              child: CreateAccountServicesWidget(
                text: AppStrings.allTherapistsOfferText,
                icon: AppAssets.smilingFaceIcon,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: sizes.width * .66,
              child: CreateAccountServicesWidget(
                text: AppStrings.youChooseTheTherapistText,
                icon: AppAssets.handsIcon,
              ),
            ),
            const SizedBox(height: 70),
            Text(
              AppStrings.meetTherapistsText,
              style: fonts.poppinsMedium.copyWith(fontSize: 17),
            ),
            const SizedBox(height: 40),
            MainUsersListlWidget(
              usersList: userList ?? [],
            ),
          ],
        ),
      ),
    );
  }
}
