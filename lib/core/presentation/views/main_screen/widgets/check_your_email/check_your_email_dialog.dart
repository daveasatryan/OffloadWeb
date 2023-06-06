import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/verifie_screen.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/check_your_email/bloc/check_your_email_bloc.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/check_your_email/bloc/check_your_email_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/check_your_email/bloc/check_your_email_state.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/new_password/new_password_dialog.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_svg_widget.dart';

class CheckYourEmailDialog extends StatefulWidget {
  CheckYourEmailDialog({
    super.key,
    required this.verifieEnum,
    required this.email,
  });
  VerifieEnum verifieEnum;
  String email;
  @override
  State<CheckYourEmailDialog> createState() => _CheckYourEmailDialogState();
}

class _CheckYourEmailDialogState extends BaseState<CheckYourEmailDialog> {
  String code = '';
  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.barrierColor,
      child: BlocProvider(
        create: (context) => context.read<BlocFactory>().create<CheckYourEmailBloc>(),
        child: BlocConsumer<CheckYourEmailBloc, CheckYourEmailState>(
          buildWhen: (previous, current) => current.buildWhen(),
          listenWhen: (previous, current) => current.listenWhen(),
          listener: (context, state) => state.whenOrNull(
            success: (UserModel? user) {
              if (widget.verifieEnum == VerifieEnum.forgetPassword) {
                Navigator.pop(context);
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return NewPasswordDialog(
                      code: code,
                    );
                  },
                );
                return;
              }
              context.read<UserProvider>().user = user;
              Get.rootDelegate.toNamed(AppRoutes.editProfileRoute);
              return null;
            },
            loading: () => showLoading(context),
            error: (msg, code) => showErrorDialog(context, msg: msg),
          ),
          builder: (context, state) => state.maybeWhen(
            orElse: () => Container(),
            validation: (codeValidation, buttonValidation, errorText) {
              hideLoading(context);
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: sizes.width * .34,
                    maxWidth: isMobile ? double.infinity : sizes.width * .49,
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
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppStrings.pleaseCheckYourEmailText,
                                        style: fonts.poppinsBold.copyWith(fontSize: 28),
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
                                const SizedBox(height: 13),
                                Text(
                                  '${AppStrings.weSentText} ${widget.email}',
                                  style: fonts.poppinsRegular.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    PinCodeTextField(
                                      length: 5,
                                      obscureText: false,
                                      scrollPadding: const EdgeInsets.all(0),
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderWidth: 1,
                                        borderRadius: BorderRadius.circular(15),
                                        fieldHeight: 70,
                                        fieldWidth: 63,
                                        activeFillColor: colors.whisperBorderColor,
                                        inactiveColor: errorText != null
                                            ? colors.errorColor
                                            : colors.whisperColor,
                                        inactiveFillColor: colors.whiteColor,
                                        selectedFillColor: colors.whiteColor,
                                        selectedColor: colors.whisperColor,
                                        activeColor: colors.whisperColor,
                                      ),
                                      animationDuration: const Duration(milliseconds: 300),
                                      backgroundColor: colors.whiteColor,
                                      enableActiveFill: true,
                                      onChanged: (value) => onchangeCode(value, context),
                                      appContext: context,
                                    ),
                                    errorText != null
                                        ? Container(
                                            padding: EdgeInsets.symmetric(vertical: 15.sp),
                                            child: Text(
                                              AppStrings.wrongCodePleaseTryAgainText,
                                              style: fonts.poppinsRegular.copyWith(
                                                color: colors.errorTextColor,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(height: 35),
                                  ],
                                ),
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppStrings.iDidntReceiveCodeText,
                                        style: fonts.poppinsRegular.copyWith(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      InkWell(
                                        onTap: () {},
                                        child: Text(
                                          AppStrings.resendText,
                                          style: fonts.poppinsSemiBold.copyWith(
                                            color: colors.black,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        color: buttonValidation == ButtonValidation.valid
                                            ? colors.yellowColor
                                            : colors.inputTextfieldColor,
                                        removeBorderColor: true,
                                        isColorFilled: true,
                                        onTap: buttonValidation == ButtonValidation.valid
                                            ? () {
                                                widget.verifieEnum == VerifieEnum.forgetPassword
                                                    ? context.read<CheckYourEmailBloc>().add(
                                                          CheckYourEmailEvent
                                                              .checkYourCodeForgetPasswordButton(
                                                                  code),
                                                        )
                                                    : context.read<CheckYourEmailBloc>().add(
                                                          CheckYourEmailEvent
                                                              .checkYourVerifyCodeButton(code),
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: isMobile
                                  ? BorderRadius.zero
                                  : const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                              color: colors.whiteColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  AppStrings.pleaseCheckYourEmailText,
                                  style: fonts.poppinsBold.copyWith(fontSize: 28),
                                ),
                                const SizedBox(height: 13),
                                Text(
                                  '${AppStrings.weSentText} ${widget.email}',
                                  style: fonts.poppinsRegular.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    PinCodeTextField(
                                      length: 5,
                                      obscureText: false,
                                      scrollPadding: const EdgeInsets.all(0),
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderWidth: 1,
                                        borderRadius: BorderRadius.circular(15),
                                        fieldHeight: 70,
                                        fieldWidth: 63,
                                        activeFillColor: colors.whisperBorderColor,
                                        inactiveColor: errorText != null
                                            ? colors.errorColor
                                            : colors.whisperColor,
                                        inactiveFillColor: colors.whiteColor,
                                        selectedFillColor: colors.whiteColor,
                                        selectedColor: colors.whisperColor,
                                        activeColor: colors.whisperColor,
                                      ),
                                      animationDuration: const Duration(milliseconds: 300),
                                      backgroundColor: colors.whiteColor,
                                      enableActiveFill: true,
                                      onChanged: (value) => onchangeCode(value, context),
                                      appContext: context,
                                    ),
                                    errorText != null
                                        ? Container(
                                            padding: EdgeInsets.symmetric(vertical: 15.sp),
                                            child: Text(
                                              AppStrings.wrongCodePleaseTryAgainText,
                                              style: fonts.poppinsRegular.copyWith(
                                                color: colors.errorTextColor,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(height: 35),
                                  ],
                                ),
                                const SizedBox(height: 35),
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppStrings.iDidntReceiveCodeText,
                                        style: fonts.poppinsRegular.copyWith(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      InkWell(
                                        onTap: () {},
                                        child: Text(
                                          AppStrings.resendText,
                                          style: fonts.poppinsSemiBold.copyWith(
                                            color: colors.black,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        color: buttonValidation == ButtonValidation.valid
                                            ? colors.yellowColor
                                            : colors.inputTextfieldColor,
                                        removeBorderColor: true,
                                        isColorFilled: true,
                                        onTap: buttonValidation == ButtonValidation.valid
                                            ? () {
                                                widget.verifieEnum == VerifieEnum.forgetPassword
                                                    ? context.read<CheckYourEmailBloc>().add(
                                                          CheckYourEmailEvent
                                                              .checkYourCodeForgetPasswordButton(
                                                                  code),
                                                        )
                                                    : context.read<CheckYourEmailBloc>().add(
                                                          CheckYourEmailEvent
                                                              .checkYourVerifyCodeButton(code),
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

  void onchangeCode(String value, BuildContext context) {
    code = value;

    context.read<CheckYourEmailBloc>().add(
          CheckYourEmailEvent.checkYourCode(value),
        );
  }
}
