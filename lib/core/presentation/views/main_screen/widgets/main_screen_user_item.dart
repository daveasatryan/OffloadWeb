import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/user_name_widget.dart';

class MainScreenUserItem extends BaseStatelessWidget {
  MainScreenUserItem({
    super.key,
    required this.user,
  });
  UserModel? user;
  @override
  Widget baseBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: colors.whisperColor),
              ),
            ),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 262 / 278,
                  child: image,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: UserNameWidget(
                    size: 18,
                    name: user?.firstName ?? '',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        removeBorderColor: true,
                        color: colors.yellowColor,
                        isColorFilled: true,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: AppStrings.dateFreeText,
                                  style: fonts.poppinsBold.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: ' - ${AppStrings.freeConsultationText}',
                                  style: fonts.poppinsSemi.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: colors.whisperColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: () => Get.rootDelegate.toNamed(
                          AppRoutes.toTerapist(user?.uuid),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          child: Text(
                            AppStrings.seeMoreText,
                            style: fonts.poppinsBold.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get image {
    if (user?.image == null) {
      return SvgPicture.asset(AppAssets.profileEmptyIcon);
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(user?.image ?? ''),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }
}
