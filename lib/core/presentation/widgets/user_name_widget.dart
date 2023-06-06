import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class UserNameWidget extends BaseStatelessWidget {
  UserNameWidget({
    super.key,
    required this.size,
    required this.name,
  });
  String name;
  double size;

  @override
  Widget baseBuild(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: isMobile ? null : sizes.width * .25,
          child: Text(
            name,
            style: fonts.poppinsBold.copyWith(
              fontSize: isMobile ? 14 : size,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        ),
      ],
    );
  }
}
