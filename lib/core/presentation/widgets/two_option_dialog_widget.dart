import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/styles/app_styles.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';

class TwoOptionDialogWidget extends BaseStatelessWidget {
  TwoOptionDialogWidget({
    super.key,
    required this.msg,
    this.title,
    this.positiveButtonText,
    this.positiveButtonClick,
    this.negativeButtonText,
    this.negativeButtonClick,
  });

  final String? title;
  final String msg;
  final String? positiveButtonText;
  final VoidCallback? positiveButtonClick;
  final String? negativeButtonText;
  final VoidCallback? negativeButtonClick;

  @override
  Widget baseBuild(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: .4,
            maxWidth: .6,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: colors.black45,
                    offset: const Offset(1.0, 1.0),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 10)
              ],
              borderRadius: BorderRadius.circular(
                AppStyles.cornerRadius10,
              ),
            ),
            width: .7,
            padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: title != null,
                  child: Text(
                    title ?? '',
                    style: fonts.ralewayStyle28,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  msg,
                  style: fonts.ralewayStyle16,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                FractionallySizedBox(
                  widthFactor: .53,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                          isColorFilled: false,
                          onTap: () {
                            Navigator.pop(context);
                            negativeButtonClick?.call();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13.5),
                            child: Center(
                              child: Text(
                                negativeButtonText ?? AppStrings.noText,
                                style: fonts.ralewayStyle14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          isColorFilled: true,
                          onTap: () {
                            Navigator.pop(context, true);
                            positiveButtonClick?.call();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13.5),
                            child: Center(
                              child: Text(
                                positiveButtonText ?? AppStrings.yesText,
                                style: fonts.ralewayStyle14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
