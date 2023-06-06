import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/verifie_screen.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/check_your_email/check_your_email_dialog.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/forget_password/bloc/forget_password_bloc.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/forget_password/bloc/forget_password_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/forget_password/bloc/forget_password_state.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/sign_in/sign_in_dialog.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_svg_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_text_filed.dart';

class ForgetPasswordDialog extends StatefulWidget {
  const ForgetPasswordDialog({
    super.key,
  });

  @override
  State<ForgetPasswordDialog> createState() => _ForgetPasswordDialogState();
}

class _ForgetPasswordDialogState extends BaseState<ForgetPasswordDialog> {
  Timer? _debounce;
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.barrierColor,
      child: BlocProvider(
        create: (context) => context.read<BlocFactory>().create<ForgetPasswordBloc>(),
        child: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
          buildWhen: (previous, current) => current.buildWhen(),
          listenWhen: (previous, current) => current.listenWhen(),
          listener: (context, state) => state.whenOrNull(
            success: () {
              Navigator.pop(context);
              return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return CheckYourEmailDialog(
                    verifieEnum: VerifieEnum.forgetPassword,
                    email: emailController.text,
                  );
                },
              );
            },
            loading: () => showLoading(context),
            error: (msg, code) => showErrorDialog(context, msg: msg),
          ),
          builder: (context, state) => state.maybeWhen(
            orElse: () => Container(),
            validation: (email, button, errorText) {
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
                            borderRadius: isMobile
                                ? BorderRadius.zero
                                : const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
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
                                    Text(
                                      AppStrings.forgotPasswordText,
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
                                const SizedBox(height: 13),
                                Text(
                                  AppStrings.itHappensText,
                                  style: fonts.poppinsRegular.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                errorText != null
                                    ? Container(
                                        padding: EdgeInsets.symmetric(vertical: 15.sp),
                                        child: Row(
                                          children: <Widget>[
                                            SvgPicture.asset(AppAssets.errorStateIcon),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                errorText,
                                                style: fonts.poppinsRegular.copyWith(
                                                  color: colors.errorTextColor,
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(height: 45),
                                Text(
                                  AppStrings.emailText,
                                  style: fonts.poppinsBold.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  errorText: email.errorMessageEmail,
                                  onChanged: (value) => onChangeEmail(value, context),
                                  controller: emailController,
                                  hint: AppStrings.yourEmailText,
                                  showBorders: true,
                                  fillColor: colors.whiteColor,
                                ),
                                const SizedBox(height: 80),
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
                                                context.read<ForgetPasswordBloc>().add(
                                                      ForgetPasswordEvent.validateButton(
                                                        emailController.text,
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
                                              AppStrings.sendCodeText,
                                              style: fonts.poppinsRegular.copyWith(
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
                                const SizedBox(height: 25),
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppStrings.rememberPasswordText,
                                        style: fonts.poppinsRegular.copyWith(
                                          fontWeight: FontWeight.w300,
                                        ),
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
                              borderRadius: isMobile
                                  ? BorderRadius.zero
                                  : const BorderRadius.all(
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
                                    AppStrings.forgotPasswordText,
                                    style: fonts.poppinsBold.copyWith(fontSize: 28),
                                  ),
                                  const SizedBox(height: 13),
                                  Text(
                                    AppStrings.itHappensText,
                                    style: fonts.poppinsRegular.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  errorText != null
                                      ? Container(
                                          padding: EdgeInsets.symmetric(vertical: 15.sp),
                                          child: Row(
                                            children: <Widget>[
                                              SvgPicture.asset(AppAssets.errorStateIcon),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: Text(
                                                  errorText,
                                                  style: fonts.poppinsRegular.copyWith(
                                                    color: colors.errorTextColor,
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox(height: 45),
                                  Text(
                                    AppStrings.emailText,
                                    style: fonts.poppinsBold.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    errorText: email.errorMessageEmail,
                                    onChanged: (value) => onChangeEmail(value, context),
                                    controller: emailController,
                                    hint: AppStrings.yourEmailText,
                                    showBorders: true,
                                    fillColor: colors.whiteColor,
                                  ),
                                  const SizedBox(height: 80),
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
                                                  context.read<ForgetPasswordBloc>().add(
                                                        ForgetPasswordEvent.validateButton(
                                                          emailController.text,
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
                                                AppStrings.sendCodeText,
                                                style: fonts.poppinsRegular.copyWith(
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
                                  const SizedBox(height: 25),
                                  Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppStrings.rememberPasswordText,
                                          style: fonts.poppinsRegular.copyWith(
                                            fontWeight: FontWeight.w300,
                                          ),
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

  void onChangeEmail(String value, BuildContext context) {
    if (_debounce?.isActive == true) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<ForgetPasswordBloc>().add(
              ForgetPasswordEvent.validateEmail(value),
            );
      },
    );
  }
}
