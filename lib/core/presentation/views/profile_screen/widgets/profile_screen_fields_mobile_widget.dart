import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class ProfileScreenFieldsMobileWidget extends BaseStatelessWidget {
  ProfileScreenFieldsMobileWidget({
    super.key,
    required this.lableText,
    required this.valueText,
    this.showBioText = false,
    this.showButtonBorder = false,
  });

  final String lableText;
  final String valueText;
  final bool? showBioText;
  final bool? showButtonBorder;
  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 25,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: colors.whisperColor,
          ),
          bottom: showButtonBorder == true
              ? BorderSide(
                  width: 1,
                  color: colors.whisperColor,
                )
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lableText,
            style: fonts.poppinsMedium.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 10),
          showBioText == true
              ? ReadMoreText(
                  valueText,
                  trimCollapsedText: AppStrings.moreText,
                  trimExpandedText: AppStrings.lessText,
                  trimLines: 2,
                  style: fonts.poppinsLight.copyWith(fontSize: 15),
                  moreStyle: fonts.poppinsBold.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  lessStyle: fonts.poppinsBold.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  valueText,
                  style: fonts.poppinsLight.copyWith(fontSize: 15),
                ),
        ],
      ),
    );
  }
}
