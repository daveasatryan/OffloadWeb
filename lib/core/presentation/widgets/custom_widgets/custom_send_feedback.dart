import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/send_feedback/send_feedback_dialog.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';

class CustomSendFeedback extends BaseStatelessWidget {
  CustomSendFeedback({
    super.key,
  });

  @override
  Widget baseBuild(BuildContext context) {
    return SizedBox(
      width: isMobile ? sizes.width * .56 : sizes.width * .17,
      child: CustomButton(
        isColorFilled: false,
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return const SendFeedbackDialog();
            },
          );
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10,
            ),
            child: Text(
              AppStrings.sendFeedbackText,
              style: fonts.poppinsMedium.copyWith(fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }
}
