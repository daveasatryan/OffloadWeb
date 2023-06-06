import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/to_do_const.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/call_confirm/bloc/call_confirm_bloc.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/call_confirm/bloc/call_confirm_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/call_confirm/bloc/call_confirm_state.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_text_filed.dart';

class ConfirmCallDialog extends StatefulWidget {
  const ConfirmCallDialog({
    super.key,
  });

  @override
  State<ConfirmCallDialog> createState() => _ConfirmCallDialogState();
}

class _ConfirmCallDialogState extends BaseState<ConfirmCallDialog> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final noteController = TextEditingController();
  bool isChecked = false;
  Timer? debounce;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.barrierColor,
      child: BlocProvider(
        create: (context) => context.read<BlocFactory>().create<CallConfirmBloc>(),
        child: BlocConsumer<CallConfirmBloc, CallConfirmBlocState>(
          buildWhen: (previous, current) => current.buildWhen(),
          listenWhen: (previous, current) => current.listenWhen(),
          listener: (context, state) => state.whenOrNull(
            success: () {
              return null;
            },
            loading: () => showLoading(context),
            error: (msg, code) => showErrorDialog(context, msg: msg),
          ),
          builder: (context, state) => state.maybeWhen(
            orElse: () => Container(),
            validation: (
              email,
              name,
              checkbox,
              button,
            ) {
              hideLoading(context);
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: sizes.width * .53,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 40,
                                    horizontal: 30,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 90,
                                        height: 90,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            TodoConsts.profileImageUrl,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        //todo
                                        'name',
                                        style: fonts.poppinsMedium.copyWith(fontSize: 15),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        AppStrings.freeConsultationText,
                                        style: fonts.poppinsBold.copyWith(fontSize: 21),
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        children: [
                                          SvgPicture.asset(AppAssets.videoCallIcon),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Text(
                                              AppStrings.videoCallText,
                                              style: fonts.poppinsRegular.copyWith(
                                                fontSize: 15,
                                                color: colors.lableOpacityColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          SvgPicture.asset(AppAssets.timeIcon),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Text(
                                              AppStrings.minutesText,
                                              style: fonts.poppinsRegular.copyWith(
                                                fontSize: 15,
                                                color: colors.lableOpacityColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          SvgPicture.asset(AppAssets.calenderIcon),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Text(
                                              AppStrings.mounthDaysText,
                                              style: fonts.poppinsRegular.copyWith(
                                                fontSize: 15,
                                                color: colors.lableOpacityColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
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
                                        AppStrings.nameLableText,
                                        style: fonts.poppinsBold.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: AppStrings.addNameLableText,
                                              style: fonts.poppinsRegular
                                                  .copyWith(fontWeight: FontWeight.w300),
                                            ),
                                            WidgetSpan(
                                              alignment: PlaceholderAlignment.middle,
                                              child: Image.asset(
                                                AppAssets.lockIcon,
                                                width: 10,
                                                height: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      CustomTextField(
                                        errorText: name.errorMessage,
                                        controller: nameController,
                                        onChanged: (value) => onChangeName(value, context),
                                        borderColor: colors.whisperColor,
                                        hint: AppStrings.nameHintText,
                                        showBorders: true,
                                        fillColor: colors.whiteColor,
                                      ),
                                      const SizedBox(height: 20),
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
                                        hint: AppStrings.emailHintText,
                                        showBorders: true,
                                        fillColor: colors.whiteColor,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        AppStrings.additionalNotesText,
                                        style: fonts.poppinsBold.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      CustomTextField(
                                        borderColor: colors.whisperColor,
                                        hint: AppStrings.pleaseShareHintText,
                                        showBorders: true,
                                        fillColor: colors.whiteColor,
                                        minLines: 3,
                                        maxLines: 10,
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
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              AppStrings.pleaseConfirmText,
                                              style: fonts.poppinsRegular.copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                AppStrings.cancelText,
                                                style: fonts.poppinsBold.copyWith(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 22),
                                            CustomButton(
                                              removeBorderColor: true,
                                              color: button == ButtonValidation.valid
                                                  ? colors.yellowColor
                                                  : colors.inputTextfieldColor,
                                              isColorFilled: true,
                                              onTap: button == ButtonValidation.valid
                                                  ? () {
                                                      context.read<CallConfirmBloc>().add(
                                                            CallConfirmBlocEvent.validateButton(
                                                                nameController.text,
                                                                emailController.text,
                                                                noteController.text),
                                                          );
                                                    }
                                                  : () {},
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 13,
                                                  horizontal: 50,
                                                ),
                                                child: Text(
                                                  AppStrings.confirmText,
                                                  style: fonts.poppinsBold.copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            )
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
                                        SizedBox(
                                          width: 90,
                                          height: 90,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              TodoConsts.profileImageUrl,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          //todo
                                          'name',
                                          style: fonts.poppinsMedium.copyWith(fontSize: 15),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          AppStrings.freeConsultationText,
                                          style: fonts.poppinsBold.copyWith(fontSize: 21),
                                        ),
                                        const SizedBox(height: 35),
                                        Row(
                                          children: [
                                            SvgPicture.asset(AppAssets.videoCallIcon),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Text(
                                                AppStrings.videoCallText,
                                                style: fonts.poppinsRegular.copyWith(
                                                  fontSize: 15,
                                                  color: colors.lableOpacityColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            SvgPicture.asset(AppAssets.timeIcon),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Text(
                                                AppStrings.minutesText,
                                                style: fonts.poppinsRegular.copyWith(
                                                  fontSize: 15,
                                                  color: colors.lableOpacityColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            SvgPicture.asset(AppAssets.calenderIcon),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Text(
                                                AppStrings.mounthDaysText,
                                                style: fonts.poppinsRegular.copyWith(
                                                  fontSize: 15,
                                                  color: colors.lableOpacityColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(color: colors.borderColor),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 30,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          AppStrings.nameLableText,
                                          style: fonts.poppinsBold.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: AppStrings.addNameLableText,
                                                style: fonts.poppinsRegular
                                                    .copyWith(fontWeight: FontWeight.w300),
                                              ),
                                              WidgetSpan(
                                                alignment: PlaceholderAlignment.middle,
                                                child: Image.asset(
                                                  AppAssets.lockIcon,
                                                  width: 10,
                                                  height: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextField(
                                          errorText: name.errorMessage,
                                          controller: nameController,
                                          onChanged: (value) => onChangeName(value, context),
                                          borderColor: colors.whisperColor,
                                          hint: AppStrings.nameHintText,
                                          showBorders: true,
                                          fillColor: colors.whiteColor,
                                        ),
                                        const SizedBox(height: 20),
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
                                          hint: AppStrings.emailHintText,
                                          showBorders: true,
                                          fillColor: colors.whiteColor,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          AppStrings.additionalNotesText,
                                          style: fonts.poppinsBold.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextField(
                                          borderColor: colors.whisperColor,
                                          hint: AppStrings.pleaseShareHintText,
                                          showBorders: true,
                                          fillColor: colors.whiteColor,
                                          minLines: 3,
                                          maxLines: 10,
                                        ),
                                        const SizedBox(height: 25),
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
                                                AppStrings.pleaseConfirmText,
                                                style: fonts.poppinsRegular.copyWith(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 40),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  AppStrings.cancelText,
                                                  style: fonts.poppinsBold.copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 22),
                                              CustomButton(
                                                removeBorderColor: true,
                                                color: button == ButtonValidation.valid
                                                    ? colors.yellowColor
                                                    : colors.inputTextfieldColor,
                                                isColorFilled: true,
                                                enabled: true,
                                                onTap: button == ButtonValidation.valid
                                                    ? () {
                                                        context.read<CallConfirmBloc>().add(
                                                              CallConfirmBlocEvent.validateButton(
                                                                  nameController.text,
                                                                  emailController.text,
                                                                  noteController.text),
                                                            );
                                                      }
                                                    : () {},
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 13, horizontal: 40),
                                                    child: Text(
                                                      AppStrings.confirmText,
                                                      style: fonts.poppinsBold.copyWith(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w600,
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
    if (debounce?.isActive == true) debounce?.cancel();
    debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<CallConfirmBloc>().add(
              CallConfirmBlocEvent.validateCallConfirmEmail(value),
            );
      },
    );
  }

  void onChangeName(String value, BuildContext context) {
    if (debounce?.isActive == true) debounce!.cancel();
    debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<CallConfirmBloc>().add(
              CallConfirmBlocEvent.validateCallConfirName(value),
            );
      },
    );
  }

  void onchangeCheckBox(bool? value, BuildContext context) {
    context.read<CallConfirmBloc>().add(
          CallConfirmBlocEvent.validateCheckBox(value!),
        );
    setState(() {
      isChecked = value;
    });
  }
}
