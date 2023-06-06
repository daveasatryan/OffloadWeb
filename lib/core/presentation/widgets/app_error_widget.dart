import 'dart:async';

import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/styles/app_styles.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';

class AppErrorWidget extends StatefulWidget {
  AppErrorWidget({
    super.key,
    required this.message,
    this.title,
    this.buttonText,
    this.showButton,
    this.onPressed,
  });

  final String? title;
  final String message;
  final String? buttonText;
  final bool? showButton;
  Function()? onPressed;

  @override
  State<AppErrorWidget> createState() => _AppErrorWidgetState();
}

class _AppErrorWidgetState extends BaseState<AppErrorWidget> {
  AppStrings get appStrings => AppStrings();
  @override
  Widget build(BuildContext context) {
    if (widget.showButton == false) {
      Timer(const Duration(seconds: 8), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    }
    return Material(
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: sizes.width * .4,
            maxWidth: sizes.width * .6,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black45,
                    offset: Offset(1.0, 1.0),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 10)
              ],
              borderRadius: BorderRadius.circular(
                AppStyles.cornerRadius10,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title ?? AppStrings.errorText,
                  style: fonts.poppinsBold.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.message,
                  style: fonts.poppinsMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                (widget.showButton ?? true)
                    ? CustomButton(
                        isColorFilled: true,
                        onTap: () {
                          Navigator.pop(context);
                          widget.onPressed?.call();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 24,
                          ),
                          child: Text(
                            widget.buttonText ?? AppStrings.closeText,
                            style: fonts.poppinsBold.copyWith(fontSize: 16),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
