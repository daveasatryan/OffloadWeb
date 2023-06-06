import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/send_feedback/bloc/send_feedback_bloc.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/send_feedback/bloc/send_feedback_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/send_feedback/bloc/send_feedback_state.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_svg_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_text_filed.dart';

class SendFeedbackDialog extends StatefulWidget {
  const SendFeedbackDialog({
    super.key,
  });

  @override
  State<SendFeedbackDialog> createState() => _SendFeedbackDialogState();
}

class _SendFeedbackDialogState extends BaseState<SendFeedbackDialog> {
  Timer? debounce;
  final emailController = TextEditingController();
  final feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.barrierColor,
      child: BlocProvider(
        create: (context) => context.read<BlocFactory>().create<SendFeedbackBloc>(),
        child: BlocConsumer<SendFeedbackBloc, SendFeedbackState>(
          buildWhen: (previous, current) => current.buildWhen(),
          listenWhen: (previous, current) => current.listenWhen(),
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                Navigator.pop(context);
              },
              loading: () => showLoading(context),
              error: (msg, code) => showErrorDialog(context, msg: msg),
            );
          },
          builder: (context, state) => state.maybeWhen(
            orElse: () => Container(),
            sendFeedback: (email, feedback, button) {
              hideLoading(context);
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: isMobile ? double.infinity : sizes.width * .24,
                    maxWidth: isMobile ? double.infinity : sizes.width * .45,
                    minHeight: isMobile ? double.infinity : 0.0,
                  ),
                  child: isMobile
                      ? Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: colors.whiteColor,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.sendFeedbackText,
                                      style: fonts.poppinsBold.copyWith(fontSize: 28),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: CustomSvgWidget(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  AppStrings.thanksForTryingOffloadText,
                                  style: fonts.poppinsRegular.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(height: 50),
                                Text(
                                  AppStrings.feedbackText,
                                  style: fonts.poppinsBold.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: feedbackController,
                                  errorText: feedback.errorMessage,
                                  contentPaddingVertical: 15,
                                  minLines: 6,
                                  maxLength: null,
                                  maxLines: 7,
                                  onChanged: (value) => onChangeFeedback(value, context),
                                  hint: AppStrings.yourFeedbackText,
                                  showBorders: true,
                                  fillColor: colors.whiteColor,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  AppStrings.emailOptionalText,
                                  style: fonts.poppinsBold.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: emailController,
                                  onChanged: (value) => onChangeEmail(value, context),
                                  errorText: email.errorMessageEmail,
                                  hint: AppStrings.yourEmailText,
                                  showBorders: true,
                                  fillColor: colors.whiteColor,
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        removeBorderColor: true,
                                        color: button == ButtonValidation.valid
                                            ? colors.yellowColor
                                            : colors.inputTextfieldColor,
                                        isColorFilled: true,
                                        onTap: button == ButtonValidation.valid
                                            ? () {
                                                context.read<SendFeedbackBloc>().add(
                                                      SendFeedbackEvent.validate(
                                                        emailController.text,
                                                        feedbackController.text,
                                                      ),
                                                    );
                                              }
                                            : () {},
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 13,
                                              horizontal: 20,
                                            ),
                                            child: Text(
                                              AppStrings.sendText,
                                              style: fonts.poppinsBold.copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              color: colors.whiteColor,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 30,
                              ),
                              decoration: BoxDecoration(
                                color: colors.whiteColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: CustomSvgWidget(),
                                    ),
                                  ),
                                  Text(
                                    AppStrings.sendFeedbackText,
                                    style: fonts.poppinsBold.copyWith(fontSize: 28),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    AppStrings.thanksForTryingOffloadText,
                                    style: fonts.poppinsRegular.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(height: 45),
                                  Text(
                                    AppStrings.feedbackText,
                                    style: fonts.poppinsBold.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    controller: feedbackController,
                                    onChanged: (value) => onChangeFeedback(value, context),
                                    errorText: feedback.errorMessage,
                                    contentPaddingVertical: 15,
                                    minLines: 6,
                                    maxLength: null,
                                    maxLines: 7,
                                    hint: AppStrings.yourFeedbackText,
                                    showBorders: true,
                                    fillColor: colors.whiteColor,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    AppStrings.emailOptionalText,
                                    style: fonts.poppinsBold.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    errorText: email.errorMessageEmail,
                                    controller: emailController,
                                    onChanged: (value) => onChangeEmail(value, context),
                                    hint: AppStrings.yourEmailText,
                                    showBorders: true,
                                    fillColor: colors.whiteColor,
                                  ),
                                  const SizedBox(height: 40),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          removeBorderColor: true,
                                          color: button == ButtonValidation.valid
                                              ? colors.yellowColor
                                              : colors.inputTextfieldColor,
                                          isColorFilled: true,
                                          onTap: button == ButtonValidation.valid
                                              ? () {
                                                  context.read<SendFeedbackBloc>().add(
                                                        SendFeedbackEvent.validate(
                                                          emailController.text,
                                                          feedbackController.text,
                                                        ),
                                                      );
                                                }
                                              : () {},
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 13,
                                                horizontal: 20,
                                              ),
                                              child: Text(
                                                AppStrings.sendText,
                                                style: fonts.poppinsBold.copyWith(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onChangeEmail(String value, BuildContext context) {
    if (debounce?.isActive == true) debounce?.cancel();
    debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<SendFeedbackBloc>().add(
              SendFeedbackEvent.validateEmail(value),
            );
      },
    );
  }

  void onChangeFeedback(String value, BuildContext context) {
    if (debounce?.isActive == true) debounce!.cancel();
    debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<SendFeedbackBloc>().add(
              SendFeedbackEvent.validatFeedback(value),
            );
      },
    );
  }
}
