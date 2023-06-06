import 'package:flutter/material.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';

class ConfirmedCallDialog extends StatefulWidget {
  const ConfirmedCallDialog({
    super.key,
  });

  @override
  State<ConfirmedCallDialog> createState() => _ConfirmedCallDialogState();
}

class _ConfirmedCallDialogState extends BaseState<ConfirmedCallDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.barrierColor,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: isMobile ? double.infinity : sizes.width * .21,
            maxWidth: isMobile ? double.infinity : sizes.width * .41,
            minHeight: isMobile ? double.infinity : 0.0,
          ),
          child: isMobile
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: colors.whiteColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: colors.borderColor),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 56,
                                height: 56,
                                child: Image.asset(
                                  AppAssets.raisingHandsIcon,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                AppStrings.callConfirmedText,
                                style: fonts.poppinsBold.copyWith(fontSize: 21),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                AppStrings.weEmailedYouText,
                                style: fonts.poppinsRegular.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.whatText,
                                style: fonts.poppinsMedium.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                AppStrings.consultationTimeText,
                                style: fonts.poppinsRegular.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 25),
                              Text(
                                AppStrings.whenText,
                                style: fonts.poppinsMedium.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                AppStrings.mounthDaysText,
                                style: fonts.poppinsRegular.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 25),
                              Text(
                                AppStrings.whoText,
                                style: fonts.poppinsMedium.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                AppStrings.nameHintText,
                                style: fonts.poppinsRegular.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 25),
                              Text(
                                AppStrings.whereText,
                                style: fonts.poppinsMedium.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                AppStrings.videoCallUrlText,
                                style: fonts.poppinsRegular.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Align(
                                alignment: Alignment.center,
                                child: Expanded(
                                  child: CustomButton(
                                    removeBorderColor: true,
                                    color: colors.yellowColor,
                                    isColorFilled: true,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 13,
                                          horizontal: 50,
                                        ),
                                        child: Text(
                                          AppStrings.doneText,
                                          style: fonts.poppinsMedium.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: colors.whiteColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: colors.borderColor),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 56,
                                height: 56,
                                child: Image.asset(
                                  AppAssets.raisingHandsIcon,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                AppStrings.callConfirmedText,
                                style: fonts.poppinsBold.copyWith(fontSize: 21),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                AppStrings.weEmailedYouText,
                                style: fonts.poppinsRegular.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: sizes.width * .10,
                                    child: Text(
                                      AppStrings.whatText,
                                      style: fonts.poppinsMedium.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppStrings.consultationTimeText,
                                        style: fonts.poppinsRegular.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  SizedBox(
                                    width: sizes.width * .10,
                                    child: Text(
                                      AppStrings.whenText,
                                      style: fonts.poppinsMedium.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppStrings.mounthDaysText,
                                        style: fonts.poppinsRegular.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  SizedBox(
                                    width: sizes.width * .10,
                                    child: Text(
                                      AppStrings.whoText,
                                      style: fonts.poppinsMedium.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppStrings.nameHintText,
                                        style: fonts.poppinsRegular.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  SizedBox(
                                    width: sizes.width * .10,
                                    child: Text(
                                      AppStrings.whereText,
                                      style: fonts.poppinsMedium.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppStrings.videoCallUrlText,
                                        style: fonts.poppinsRegular.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Align(
                                alignment: Alignment.center,
                                child: Expanded(
                                  child: CustomButton(
                                    removeBorderColor: true,
                                    color: colors.yellowColor,
                                    isColorFilled: true,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 13,
                                          horizontal: 50,
                                        ),
                                        child: Text(
                                          AppStrings.doneText,
                                          style: fonts.poppinsMedium.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
