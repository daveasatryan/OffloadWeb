import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/verifie_screen.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/check_your_email/check_your_email_dialog.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/create_account/bloc/create_user_bloc.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/create_account/bloc/create_user_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/create_account/bloc/create_user_state.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/create_account/create_account_services_widget.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/sign_in/sign_in_dialog.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_svg_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_text_filed.dart';

class CreateAccountDialog extends StatefulWidget {
  const CreateAccountDialog({
    super.key,
  });

  @override
  State<CreateAccountDialog> createState() => _CreateAccountDialogState();
}

class _CreateAccountDialogState extends BaseState<CreateAccountDialog> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  Timer? _debounce;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.barrierColor,
      child: BlocProvider(
        create: (context) => context.read<BlocFactory>().create<CreateUserBloc>(),
        child: BlocConsumer<CreateUserBloc, CreateUserState>(
          buildWhen: (previous, current) => current.buildWhen(),
          listenWhen: (previous, current) => current.listenWhen(),
          listener: (context, state) => state.whenOrNull(
            success: () {
              Navigator.pop(context);
              return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return CheckYourEmailDialog(
                    verifieEnum: VerifieEnum.createAccount,
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
            validation: (email, password, checkbox, signUp) {
              hideLoading(context);
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: isMobile ? double.infinity : sizes.width * .53,
                    maxWidth: isMobile ? double.infinity : sizes.width * .73,
                    minHeight: isMobile ? double.infinity : 0.0,
                  ),
                  child: isMobile
                      ? Container(
                          decoration: BoxDecoration(
                            color: colors.whiteColor,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 40,
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Expanded(
                                        child: Text(
                                          AppStrings.createAnAccountText,
                                          style: fonts.poppinsBold.copyWith(fontSize: 28),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: CustomSvgWidget(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: sizes.width * .92,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CreateAccountServicesWidget(
                                        text: AppStrings.findTheRightText,
                                        icon: AppAssets.raisingHandsIcon,
                                      ),
                                      const SizedBox(height: 15),
                                      CreateAccountServicesWidget(
                                        text: AppStrings.allTherapistsOfferText,
                                        icon: AppAssets.rocketIcon,
                                      ),
                                      const SizedBox(height: 15),
                                      CreateAccountServicesWidget(
                                        text: AppStrings.youChooseTheTherapistText,
                                        icon: AppAssets.handsIcon,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
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
                                        borderColor: colors.whisperColor,
                                        onChanged: (value) => onChangeEmail(value, context),
                                        controller: emailController,
                                        hint: AppStrings.yourEmailText,
                                        showBorders: true,
                                        fillColor: colors.whiteColor,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        AppStrings.createAPasswordText,
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
                                        borderColor: colors.whisperColor,
                                        onChanged: (value) => onChangePassword(value, context),
                                        controller: passwordController,
                                        isPasswordField: true,
                                        hidePassword: hidePassword,
                                        hint: AppStrings.mustbe8Text,
                                        showBorders: true,
                                        fillColor: colors.whiteColor,
                                      ),
                                      const SizedBox(height: 20),
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
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Text(
                                              AppStrings.iConfirmText,
                                              style: fonts.poppinsRegular.copyWith(
                                                color: colors.black,
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
                                              color: signUp == ButtonValidation.valid
                                                  ? colors.yellowColor
                                                  : colors.inputTextfieldColor,
                                              isColorFilled: true,
                                              onTap: signUp == ButtonValidation.valid
                                                  ? () {
                                                      context.read<CreateUserBloc>().add(
                                                            CreateUserEvent.validate(
                                                              emailController.text,
                                                              passwordController.text,
                                                              confirmPasswordController.text,
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
                                                    AppStrings.joinText,
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
                                      const SizedBox(height: 30),
                                      Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppStrings.alreadyHaveText,
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 40,
                                      horizontal: 30,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppStrings.createAnAccountText,
                                          style: fonts.poppinsBold.copyWith(fontSize: 28),
                                        ),
                                        const SizedBox(height: 40),
                                        CreateAccountServicesWidget(
                                          text: AppStrings.takeControllText,
                                          icon: AppAssets.raisingHandsIcon,
                                        ),
                                        const SizedBox(height: 15),
                                        CreateAccountServicesWidget(
                                          text: AppStrings.superChargeText,
                                          icon: AppAssets.rocketIcon,
                                        ),
                                        const SizedBox(height: 15),
                                        CreateAccountServicesWidget(
                                          text: AppStrings.bePartOfText,
                                          icon: AppAssets.handsIcon,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 25,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(color: colors.borderColor),
                                      ),
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
                                        const SizedBox(height: 10),
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
                                          borderColor: colors.whisperColor,
                                          onChanged: (value) => onChangeEmail(value, context),
                                          controller: emailController,
                                          hint: AppStrings.yourEmailText,
                                          showBorders: true,
                                          fillColor: colors.whiteColor,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          AppStrings.createAPasswordText,
                                          style: fonts.poppinsBold.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextField(
                                          errorText: password.errorMassagePassword,
                                          showErrorIcon: true,
                                          togglePasswordVisibility: () {
                                            setState(() {
                                              hidePassword = !hidePassword;
                                            });
                                          },
                                          borderColor: colors.whisperColor,
                                          onChanged: (value) => onChangePassword(value, context),
                                          controller: passwordController,
                                          isPasswordField: true,
                                          hidePassword: hidePassword,
                                          hint: AppStrings.mustbe8Text,
                                          showBorders: true,
                                          fillColor: colors.whiteColor,
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              checkColor: Colors.white,
                                              shape: const CircleBorder(),
                                              fillColor: MaterialStateProperty.resolveWith(
                                                  colors.getColor),
                                              value: isChecked,
                                              onChanged: (value) =>
                                                  onchangeCheckBox(value, context),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Text(
                                                AppStrings.iConfirmText,
                                                style: fonts.poppinsRegular.copyWith(
                                                  color: colors.black,
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
                                                color: signUp == ButtonValidation.valid
                                                    ? colors.yellowColor
                                                    : colors.inputTextfieldColor,
                                                isColorFilled: true,
                                                onTap: signUp == ButtonValidation.valid
                                                    ? () {
                                                        context.read<CreateUserBloc>().add(
                                                              CreateUserEvent.validate(
                                                                emailController.text,
                                                                passwordController.text,
                                                                confirmPasswordController.text,
                                                              ),
                                                            );
                                                      }
                                                    : () {},
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 13, horizontal: 20),
                                                    child: Text(
                                                      AppStrings.joinText,
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
                                                AppStrings.alreadyHaveText,
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
        context.read<CreateUserBloc>().add(
              CreateUserEvent.validateEmail(value),
            );
      },
    );
  }

  void onChangePassword(String value, BuildContext context) {
    if (_debounce?.isActive == true) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<CreateUserBloc>().add(
              CreateUserEvent.validatePassword(passwordController.text),
            );
      },
    );
  }

  void onchangeCheckBox(bool? value, BuildContext context) {
    context.read<CreateUserBloc>().add(
          CreateUserEvent.validateCheckBox(value!),
        );
    setState(() {
      isChecked = value;
    });
  }
}
