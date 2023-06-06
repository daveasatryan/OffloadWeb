import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class CustomCloseWidget extends BaseStatelessWidget {
  CustomCloseWidget({
    super.key,
    this.iconColor,
  });
  Color? iconColor;
  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.fromBorderSide(
          BorderSide(color: colors.inputTextfieldColor, width: 2),
        ),
      ),
      child: SvgPicture.asset(
        AppAssets.closeIcon,
        colorFilter: ColorFilter.mode(iconColor ?? colors.blackOpacityColor, BlendMode.srcIn),
      ),
    );
  }
}
