import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/widgets/join_therapist_dialog/bloc/join_therapist_dialog_bloc.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/widgets/join_therapist_dialog/bloc/join_therapist_dialog_event.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/widgets/join_therapist_dialog/bloc/join_therapist_dialog_state.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_svg_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_text_filed.dart';

class JoinTherapistDialog extends StatefulWidget {
  const JoinTherapistDialog({
    super.key,
  });

  @override
  State<JoinTherapistDialog> createState() => _JoinTherapistDialogState();
}

class _JoinTherapistDialogState extends BaseState<JoinTherapistDialog> {
  Timer? _debounce;
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return isMobile
        ? const SizedBox()
        : Material(
            color: colors.barrierColor,
            child: BlocProvider(
              create: (context) => context.read<BlocFactory>().create<JoinTherapistDialogBloc>(),
              child: BlocConsumer<JoinTherapistDialogBloc, JoinTherapistDialogState>(
                buildWhen: (previous, current) => current.buildWhen(),
                listenWhen: (previous, current) => current.listenWhen(),
                listener: (context, state) {
                  state.whenOrNull(
                    success: () => Navigator.pop(context),
                    loading: () => showLoading(context),
                    error: (msg, code) => showErrorDialog(context, msg: msg),
                  );
                },
                builder: (context, state) => state.maybeWhen(
                  orElse: () => Container(),
                  validation: (email, button) {
                    hideLoading(context);
                    return Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: sizes.width * .24,
                          maxWidth: sizes.width * .45,
                          minHeight: 0.0,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 30,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              color: colors.whiteColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          AppStrings.addYourEmailToText,
                                          style: fonts.poppinsSemiBold.copyWith(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
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
                                const SizedBox(height: 35),
                                CustomTextField(
                                  errorText: email.errorMessageEmail,
                                  onChanged: (value) => onChangeEmail(value, context),
                                  controller: emailController,
                                  hint: AppStrings.yourEmailText,
                                  showBorders: false,
                                  fillColor: colors.inputTextfieldColor,
                                  hintStyle: fonts.poppinsRegular.copyWith(fontSize: 15),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        removeBorderColor: true,
                                        color: colors.yellowColor,
                                        isColorFilled: true,
                                        onTap: () {
                                          context.read<JoinTherapistDialogBloc>().add(
                                                JoinTherapistDialogEvent.validate(
                                                  emailController.text,
                                                ),
                                              );
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 13,
                                              horizontal: 20,
                                            ),
                                            child: Text(
                                              AppStrings.joinWaitlistText,
                                              style: fonts.poppinsSemiBold.copyWith(
                                                fontSize: 15,
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
                    );
                  },
                ),
              ),
            ),
          );
  }

  void onChangeEmail(String value, BuildContext context) {
    if (_debounce?.isActive == true) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<JoinTherapistDialogBloc>().add(
              JoinTherapistDialogEvent.validateEmail(value),
            );
      },
    );
  }
}
