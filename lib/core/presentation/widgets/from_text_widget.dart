import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class FromTextWidget extends BaseStatelessWidget {
  FromTextWidget({
    super.key,
    required this.color,
  });
  final Color color;

  @override
  Widget baseBuild(BuildContext context) {
    return Text(
      isMobile ? AppStrings.fromText : '${AppStrings.fromText}  ${AppStrings.perSessionText}',
      style: fonts.poppinsMedium.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w100,
        color: color,
      ),
    );
  }
}
