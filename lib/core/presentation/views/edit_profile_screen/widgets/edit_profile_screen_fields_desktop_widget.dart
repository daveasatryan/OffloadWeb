import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:therapist_journey/core/data/utilities/validation_utils.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_bloc.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_event.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/custom_widgets/custom_text_filed.dart';

class EditProfileScreenFieldsDesktopWidget extends BaseStatelessWidget {
  EditProfileScreenFieldsDesktopWidget({
    super.key,
     this.controller,
     this.initialValue,
     this.lableText,
     this.hint,
    this.isBioField = false,
    this.showUnderBorder = false,
    this.isSessionPriceField = false,
    this.isPhotoFiled = false,
  });

  final TextEditingController? controller;
  final String? lableText;
  final String? hint;
  final String? initialValue;
  final bool? isBioField;
  final bool? showUnderBorder;
  final bool? isSessionPriceField;
  final bool? isPhotoFiled;

  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 25,
      ),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
              color: colors.whisperColor,
              width: 1,
            ),
            bottom: showUnderBorder == true
                ? BorderSide(
                    color: colors.whisperColor,
                    width: 1,
                  )
                : BorderSide.none),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: sizes.width * .20,
            child: Text(
              lableText ?? '',
              style: fonts.poppinsBold.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: sizes.width * .45,
            child: isBioField == true
                ? CustomTextField(
                    contentPaddingVertical: 18,
                    initialValue: initialValue,
                    controller: controller,
                    hint: hint ?? '',
                    showBorders: false,
                    borderColor: colors.inputTextfieldColor,
                    maxLength: 300,
                    showContent: true,
                    maxLines: null,
                    minLines: 9,
                    fillColor: colors.inputTextfieldColor,
                  )
                : isPhotoFiled == true
                    ? Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Consumer<UserProvider>(
                              builder: (context, value, child) => value.user?.image != null
                                  ? SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(value.user?.image ?? ''),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    )
                                  : SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: SvgPicture.asset(
                                        AppAssets.profileEmptyIcon,
                                      ),
                                    ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () => context.read<EditProfileBloc>().add(
                                        const EditProfileEvent.uploadImage(),
                                      ),
                                  child: SvgPicture.asset(AppAssets.profileEmptyAddIcon),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : CustomTextField(
                        controller: controller,
                        initialValue: initialValue,
                        hint: hint ?? '',
                        inputFormatters:
                            isSessionPriceField == true ? [ValidationUtils.maskPhoneNumber] : null,
                        showBorders: false,
                        fillColor: colors.inputTextfieldColor,
                      ),
          )
        ],
      ),
    );
  }
}
