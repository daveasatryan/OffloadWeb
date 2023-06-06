import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class MenuItem extends BaseStatelessWidget {
  MenuItem({
    super.key,
  });

  @override
  Widget baseBuild(BuildContext context) {
    return SizedBox(
      child: Text(
        '9:30',
        style: fonts.poppinsRegular.copyWith(
          fontSize: 13,
        ),
      ),
    );
  }
}
