import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class DotTextWidget extends BaseStatelessWidget {
  DotTextWidget({
    super.key,
    required this.text,
    this.textStyle,
  });
  String text;
  TextStyle? textStyle;

  @override
  Widget baseBuild(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '•\t',
          style: textStyle ??
              fonts.poppinsRegular.copyWith(
                fontSize: 15,
              ),
        ),
        Expanded(
          child: Text(
            text,
            style: textStyle ??
                fonts.poppinsRegular.copyWith(
                  fontSize: 15,
                ),
          ),
        ),
      ],
    );
  }
}
