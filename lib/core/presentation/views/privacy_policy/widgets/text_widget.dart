import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/privacy_policy/widgets/dote_text.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class TextWidget extends BaseStatelessWidget {
  TextWidget({
    super.key,
    required this.header,
    required this.text,
    this.footerText,
    this.pointsList,
    this.headerStyle,
    this.textStyle,
  });
  final String header;
  final String text;
  List<String>? pointsList;

  final String? footerText;
  final TextStyle? headerStyle;
  final TextStyle? textStyle;

  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: headerStyle ??
                fonts.poppinsBold.copyWith(
                  color: colors.black,
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            text,
            style: textStyle ??
                fonts.poppinsRegular.copyWith(
                  fontSize: 15,
                ),
          ),
          pointsList != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: pointsList?.length,
                        itemBuilder: (context, index) {
                          return DotTextWidget(
                            text: pointsList?[index] ?? '',
                          );
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          footerText != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    footerText ?? '',
                    style: textStyle ??
                        fonts.poppinsRegular.copyWith(
                          fontSize: 15,
                        ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
