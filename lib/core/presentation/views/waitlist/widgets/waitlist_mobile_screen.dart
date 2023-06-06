import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:therapist_journey/core/data/enums/button_validation.dart';
import 'package:therapist_journey/core/data/enums/validation_enum.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/bloc/waitlist_.event.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/bloc/waitlist_bloc.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/widgets/join_therapist_dialog/widgets/join_therapist_bottom_sheet.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_button.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_text_filed.dart';

class WaitListMobileScreen extends StatefulWidget {
  const WaitListMobileScreen({
    super.key,
    required this.email,
    required this.button,
    this.changewidget,
  });
  final ValidationEnum email;
  final ButtonValidation button;
  final bool? changewidget;

  @override
  State<WaitListMobileScreen> createState() => _WaitListMobileScreenState();
}

class _WaitListMobileScreenState extends BaseState<WaitListMobileScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  Timer? _debounce;
  final emailController = TextEditingController();
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  _callingAllTherapistsWidget(),
                  const SizedBox(height: 60),
                  _offloadTextWidget(),
                  const SizedBox(height: 85),
                  widget.changewidget == true
                      ? _emailReceived()
                      : widget.changewidget == false
                          ? _getEarlyAccess()
                          : const SizedBox(),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _lookingForATherapist(context),
                  const SizedBox(height: 20),
                  _passtWidget(context),
                  const SizedBox(height: 15),
                  InkWell(
                      onTap: () => Get.rootDelegate.toNamed(AppRoutes.privacyPolicyRoute),
                      child: _privacyPolicy(context)),
                ],
              )
            ],
          ),
        ),
      )
    ]);
  }

  Widget _privacyPolicy(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          AppStrings.privacyPolicyText,
          style: fonts.poppinsMedium.copyWith(
            fontSize: 13,
            color: colors.privacyColor,
          ),
        ),
      ),
    );
  }

  Text _offloadTextWidget() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: AppStrings.offloadText,
            style: fonts.poppinsSemiBold.copyWith(
              fontSize: 28,
              color: colors.yellowColor,
            ),
          ),
          TextSpan(
            text: AppStrings.helpsYouFindText,
            style: fonts.poppinsBold.copyWith(
              fontSize: 28,
              color: colors.whiteColor,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _callingAllTherapistsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppAssets.calligAllIcon,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 7),
        Text(
          AppStrings.callingAllTherapistsText,
          style: fonts.poppinsSemiBold.copyWith(
            fontSize: 18,
            color: colors.whiteColor,
          ),
        ),
      ],
    );
  }

  Widget _lookingForATherapist(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          constraints: BoxConstraints(maxHeight: sizes.height * .74),
          useRootNavigator: true,
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return const JoinTherapistBottomSheet();
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 13,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors.whiteColor.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppAssets.eyesIcon,
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 7),
            Text(
              AppStrings.lookingForATherapistText,
              style: fonts.poppinsMedium.copyWith(
                fontSize: 13,
                color: colors.whiteColor,
              ),
            ),
            const SizedBox(width: 7),
            SvgPicture.asset(AppAssets.rigthVectorIcon),
          ],
        ),
      ),
    );
  }

  Widget _passtWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 13,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colors.whiteColor.withOpacity(0.2),
      ),
      child: Text(
        AppStrings.passtPreviously,
        style: fonts.poppinsMedium.copyWith(
          fontSize: 13,
          color: colors.whiteColor,
        ),
      ),
    );
  }

  Widget _getEarlyAccess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          onChanged: (value) => onChangeEmail(value, context),
          errorText: widget.email.errorMessageEmail,
          controller: emailController,
          hint: AppStrings.enterEmailAddressText,
          hintStyle: fonts.poppinsSemiBold,
          showBorders: false,
          fillColor: colors.whiteColor,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                removeBorderColor: true,
                isColorFilled: false,
                onTap: () {
                  context.read<WaitlistBloc>().add(
                        WaitlistEvent.validateButton(
                          emailController.text,
                        ),
                      );
                },
                color: colors.yellowColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 35,
                  ),
                  child: Text(
                    AppStrings.getEarlyAccessText,
                    style: fonts.poppinsSemiBold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _emailReceived() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 13,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors.whiteColor.withOpacity(0.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: colors.yellowColor,
                maxRadius: 10,
                child: Image.asset(
                  AppAssets.doneIcon,
                  width: 10,
                  height: 10,
                ),
              ),
              const SizedBox(width: 7),
              Text(
                AppStrings.emailReceivedText,
                style: fonts.poppinsMedium.copyWith(
                  fontSize: 13,
                  color: colors.whiteColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 3),
        Text(
          AppStrings.pleaseShareThisLinkText,
          style: fonts.poppinsSemiBold.copyWith(
            fontSize: 14,
            color: colors.whiteColor,
          ),
        ),
        const SizedBox(height: 3),
        InkWell(
          onTap: () {
            Clipboard.setData(const ClipboardData(text: 'http://offloadweb.com/waitlist'))
                .then((value) {
              Fluttertoast.showToast(
                msg: AppStrings.copied,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: colors.blackOpacityColor,
                textColor: colors.whiteColor,
                fontSize: 16.0,
              );
            });
          },
          child: Text(
            'http://offloadweb.com/waitlist',
            style: fonts.poppinsRegular.copyWith(
              color: colors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }

  void onChangeEmail(String value, BuildContext context) {
    if (_debounce?.isActive == true) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        context.read<WaitlistBloc>().add(
              WaitlistEvent.validateEmail(value),
            );
      },
    );
  }
}
