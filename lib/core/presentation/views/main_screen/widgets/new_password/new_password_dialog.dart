import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/new_password/bloc/new_password_bloc.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/new_password/bloc/new_password_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/new_password/bloc/new_password_state.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/sign_in/sign_in_dialog.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_svg_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_text_filed.dart';

class NewPasswordDialog extends StatefulWidget {
  NewPasswordDialog({
    required this.code,
    super.key,
  });
  String code;
  @override
  State<NewPasswordDialog> createState() => _NewPasswordDialogState();
}

class _NewPasswordDialogState extends BaseState<NewPasswordDialog> {
  Timer? debounce;
  final newPasswordController = TextEditingController();
  final confirmnNewPasswordController = TextEditingController();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.barrierColor,
      child: BlocProvider(
        create: (context) => context.read<BlocFactory>().create<NewPasswordBloc>(),
        child: BlocConsumer<NewPasswordBloc, NewPasswordState>(
          buildWhen: (previous, current) => current.buildWhen(),
          listenWhen: (previous, current) => current.listenWhen(),
          listener: (context, state) {
            state.whenOrNull(
              success: (user) {
                context.read<UserProvider>().user = user;
                Navigator.pop(context);
              },
              loading: () => showLoading(context),
              error: (msg, code) => showErrorDialog(context, msg: msg),
            );
          },
          builder: (context, state) => state.maybeWhen(
            orElse: () => Container(),
            validation: (newPassword, confirmNewpassword, button) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppStrings.resetPasswordText,
                                        style: fonts.poppinsBold.copyWith(fontSize: 28),
                                      ),
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
                                const SizedBox(height: 45),
                                Text(
                                  AppStrings.newPasswordText,
                                  style: fonts.poppinsBold.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  togglePasswordVisibility: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  onChanged: (value) => onChangeNewPassword(value, context),
                                  errorText: newPassword.errorMassagePassword,
                                  controller: newPasswordController,
                                  isPasswordField: true,
                                  hidePassword: hidePassword,
                                  hint: AppStrings.mustbe8Text,
                                  showBorders: true,
                                  fillColor: colors.whiteColor,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  AppStrings.confirmNewPasswordText,
                                  style: fonts.poppinsBold.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  togglePasswordVisibility: () {
                                    setState(() {
                                      hideConfirmPassword = !hideConfirmPassword;
                                    });
                                  },
                                  onChanged: (value) => onChangeConfirmNewPassword(value, context),
                                  errorText: confirmNewpassword.errorMassageConfirmPassword,
                                  controller: confirmnNewPasswordController,
                                  isPasswordField: true,
                                  hidePassword: hideConfirmPassword,
                                  hint: AppStrings.repeatPasswordText,
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
                                        enabled: true,
                                        onTap: button == ButtonValidation.valid
                                            ? () {
                                                context.read<NewPasswordBloc>().add(
                                                      NewPasswordEvent.validateButton(
                                                          newPasswordController.text,
                                                          confirmnNewPasswordController.text,
                                                          widget.code
                                                          //todo:
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
                                              AppStrings.resetPasswordText,
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
                                const SizedBox(height: 30),
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppStrings.rememberPasswordText,
                                        style: fonts.poppinsRegular
                                            .copyWith(fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(width: 5),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const SignInDialog();
                                            },
                                          );
                                        },
                                        child: Text(
                                          AppStrings.logInText,
                                          style: fonts.poppinsSemiBold.copyWith(
                                            color: colors.black,
                                            fontSize: 13.sp,
                                            decoration: TextDecoration.underline,
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
                                    AppStrings.resetPasswordText,
                                    style: fonts.poppinsBold.copyWith(fontSize: 28),
                                  ),
                                  const SizedBox(height: 45),
                                  Text(
                                    AppStrings.newPasswordText,
                                    style: fonts.poppinsBold.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    togglePasswordVisibility: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    onChanged: (value) => onChangeNewPassword(value, context),
                                    errorText: newPassword.errorMassagePassword,
                                    controller: newPasswordController,
                                    isPasswordField: true,
                                    hidePassword: hidePassword,
                                    hint: AppStrings.mustbe8Text,
                                    showBorders: true,
                                    fillColor: colors.whiteColor,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    AppStrings.confirmNewPasswordText,
                                    style: fonts.poppinsBold.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    togglePasswordVisibility: () {
                                      setState(() {
                                        hideConfirmPassword = !hideConfirmPassword;
                                      });
                                    },
                                    showErrorIcon: true,
                                    onChanged: (value) =>
                                        onChangeConfirmNewPassword(value, context),
                                    errorText: confirmNewpassword.errorMassageConfirmPassword,
                                    controller: confirmnNewPasswordController,
                                    isPasswordField: true,
                                    hidePassword: hideConfirmPassword,
                                    hint: AppStrings.repeatPasswordText,
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
                                                  context.read<NewPasswordBloc>().add(
                                                        NewPasswordEvent.validateButton(
                                                          newPasswordController.text,
                                                          confirmnNewPasswordController.text,
                                                          //todo:
                                                          widget.code,
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
                                                AppStrings.resetPasswordText,
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
                                  const SizedBox(height: 30),
                                  Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppStrings.rememberPasswordText,
                                          style: fonts.poppinsRegular
                                              .copyWith(fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(width: 5),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            showDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const SignInDialog();
                                              },
                                            );
                                          },
                                          child: Text(
                                            AppStrings.logInText,
                                            style: fonts.poppinsSemiBold.copyWith(
                                              color: colors.black,
                                              fontSize: 13.sp,
                                              decoration: TextDecoration.underline,
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
            },
          ),
        ),
      ),
    );
  }

  void onChangeNewPassword(String value, BuildContext context) {
    if (debounce?.isActive == true) debounce!.cancel();
    debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<NewPasswordBloc>().add(
              NewPasswordEvent.validateNewPassword(value, confirmnNewPasswordController.text),
            );
      },
    );
  }

  void onChangeConfirmNewPassword(String value, BuildContext context) {
    if (debounce?.isActive == true) debounce!.cancel();
    debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<NewPasswordBloc>().add(
              NewPasswordEvent.validateConfirmNewPassword(value, newPasswordController.text),
            );
      },
    );
  }
}
