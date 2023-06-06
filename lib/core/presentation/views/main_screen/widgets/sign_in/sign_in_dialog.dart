import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/create_account/create_account_dialog.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/forget_password/forget_password_dialog.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/sign_in/bloc/sign_in_bloc.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/sign_in/bloc/sign_in_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/sign_in/bloc/sign_in_state.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_svg_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_text_filed.dart';

class SignInDialog extends StatefulWidget {
  const SignInDialog({
    super.key,
  });

  @override
  State<SignInDialog> createState() => _SignInDialogState();
}

class _SignInDialogState extends BaseState<SignInDialog> {
  Timer? debounce;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.barrierColor,
      child: BlocProvider(
        create: (context) => context.read<BlocFactory>().create<SignInBloc>(),
        child: BlocConsumer<SignInBloc, SignInState>(
          buildWhen: (previous, current) => current.buildWhen(),
          listenWhen: (previous, current) => current.listenWhen(),
          listener: (context, state) {
            state.whenOrNull(
              success: (user) {
                context.read<UserProvider>().user = user;
                Navigator.pop(context);
                Get.rootDelegate.toNamed(AppRoutes.profileRoute);
              },
              loading: () => showLoading(context),
              error: (msg, code) => showErrorDialog(context, msg: msg),
            );
          },
          builder: (context, state) => state.maybeWhen(
            orElse: () => Container(),
            validation: (email, password, signin, errorText) {
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
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: AppStrings.logInText,
                                            style: fonts.poppinsBold.copyWith(fontSize: 28),
                                          ),
                                          WidgetSpan(
                                            alignment: PlaceholderAlignment.middle,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Image.asset(
                                                AppAssets.handLoginIcon,
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: CustomSvgWidget(),
                                    ),
                                  ],
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
                                  onChanged: (value) => onChangeEmail(value, context),
                                  errorText: email.errorMessageEmail,
                                  controller: emailController,
                                  hint: AppStrings.yourEmailText,
                                  textColor: colors.blackOpacityColor,
                                  fillColor: colors.whiteColor,
                                ),
                                SizedBox(height: 20.sp),
                                Text(
                                  AppStrings.passwordLableText,
                                  style: fonts.poppinsBold.copyWith(
                                    fontSize: 13.sp,
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
                                  onChanged: (value) => onChangePassword(value, context),
                                  errorText: password.errorMassagePassword,
                                  controller: passwordController,
                                  isPasswordField: true,
                                  hidePassword: hidePassword,
                                  hint: AppStrings.passwordHintText,
                                  fillColor: colors.whiteColor,
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      shape: const CircleBorder(),
                                      fillColor: MaterialStateProperty.resolveWith(colors.getColor),
                                      value: isChecked,
                                      onChanged: (value) => onchangeCheckBox(value, context),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        AppStrings.rememberMeText,
                                        style: fonts.poppinsLight.copyWith(
                                          color: colors.blackOpacityColor,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const ForgetPasswordDialog();
                                          },
                                        );
                                      },
                                      child: Text(
                                        AppStrings.forgotPasswordText,
                                        style: fonts.poppinsLight.copyWith(
                                          color: colors.blackOpacityColor,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        removeBorderColor: true,
                                        color: signin == ButtonValidation.valid
                                            ? colors.yellowColor
                                            : colors.inputTextfieldColor,
                                        isColorFilled: true,
                                        enabled: true,
                                        onTap: signin == ButtonValidation.valid
                                            ? () {
                                                context.read<SignInBloc>().add(
                                                      SignInEvent.validate(
                                                        emailController.text,
                                                        passwordController.text,
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
                                              AppStrings.continueText,
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
                                        AppStrings.dontHaveAccountText,
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
                                              return const CreateAccountDialog();
                                            },
                                          );
                                        },
                                        child: Text(
                                          AppStrings.signUpText,
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
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: AppStrings.logInText,
                                          style: fonts.poppinsBold.copyWith(fontSize: 28),
                                        ),
                                        WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Image.asset(
                                              AppAssets.handLoginIcon,
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                      ],
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
                                    onChanged: (value) => onChangeEmail(value, context),
                                    showErrorIcon: true,
                                    errorText: email.errorMessageEmail,
                                    controller: emailController,
                                    hint: AppStrings.yourEmailText,
                                    showBorders: true,
                                    fillColor: colors.whiteColor,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    AppStrings.passwordLableText,
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
                                    errorText: password.errorMassagePassword,
                                    onChanged: (value) => onChangePassword(value, context),
                                    showErrorIcon: true,
                                    controller: passwordController,
                                    isPasswordField: true,
                                    hidePassword: hidePassword,
                                    hint: AppStrings.passwordHintText,
                                    showBorders: true,
                                    fillColor: colors.whiteColor,
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        shape: const CircleBorder(),
                                        fillColor:
                                            MaterialStateProperty.resolveWith(colors.getColor),
                                        value: isChecked,
                                        onChanged: (value) => onchangeCheckBox(value, context),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          AppStrings.rememberMeText,
                                          style: fonts.poppinsLight.copyWith(
                                            color: colors.blackOpacityColor,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const ForgetPasswordDialog();
                                            },
                                          );
                                        },
                                        child: Text(
                                          AppStrings.forgotPasswordText,
                                          style: fonts.poppinsLight.copyWith(
                                            color: colors.blackOpacityColor,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          removeBorderColor: true,
                                          color: signin == ButtonValidation.valid
                                              ? colors.yellowColor
                                              : colors.inputTextfieldColor,
                                          isColorFilled: true,
                                          onTap: signin == ButtonValidation.valid
                                              ? () {
                                                  context.read<SignInBloc>().add(
                                                        SignInEvent.validate(
                                                          emailController.text,
                                                          passwordController.text,
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
                                                AppStrings.continueText,
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
                                          AppStrings.dontHaveAccountText,
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
                                                return const CreateAccountDialog();
                                              },
                                            );
                                          },
                                          child: Text(
                                            AppStrings.signUpText,
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
    if (debounce?.isActive == true) debounce?.cancel();
    debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<SignInBloc>().add(
              SignInEvent.validateEmail(value, passwordController.text),
            );
      },
    );
  }

  void onChangePassword(String value, BuildContext context) {
    if (debounce?.isActive == true) debounce!.cancel();
    debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<SignInBloc>().add(
              SignInEvent.validatePassword(emailController.text, value),
            );
      },
    );
  }

  void onchangeCheckBox(bool? value, BuildContext context) {
    setState(() {
      isChecked = value ?? true;
      PreferencesManager.rememberMe = isChecked;
    });
  }
}
