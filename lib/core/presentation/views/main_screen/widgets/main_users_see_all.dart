import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class MainUsersSeeAll extends BaseStatelessWidget {
  MainUsersSeeAll({
    super.key,
    required this.title,
  });
  String title;
  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: fonts.poppinsMedium,
          ),
          Row(
            children: [
              Text(
                AppStrings.seeMoreText,
                style: fonts.poppinsRegular,
              ),
              SvgPicture.asset(AppAssets.lesAllIcon)
            ],
          )
        ],
      ),
    );
  }
}
