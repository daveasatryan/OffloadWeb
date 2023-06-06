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

class EditProfileScreenFieldsMobileWidget extends BaseStatelessWidget {
  EditProfileScreenFieldsMobileWidget({
    super.key,
     this.controller,
     this.initialValue,
     this.lableText,
     this.hint,
    this.isBioField = false,
    this.showUnderBorder = false,
    this.isSessionPriceField = false,
    this.isPhotoField = false,
  });

  final TextEditingController? controller;
  final String? lableText;
  final String? hint;
  final String? initialValue;
  final bool? isBioField;
  final bool? showUnderBorder;
  final bool? isSessionPriceField;
  final bool? isPhotoField;

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
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lableText??'',
            style: fonts.poppinsBold.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 10),
          isBioField == true
              ? CustomTextField(
                  contentPaddingVertical: 18,
                  initialValue: initialValue,
                  controller: controller,
                  hint: hint??'',
                  showBorders: false,
                  borderColor: colors.inputTextfieldColor,
                  maxLength: 300,
                  minLines: 9,
                  showContent: true,
                  maxLines: null,
                  fillColor: colors.inputTextfieldColor,
                )
              : isPhotoField == true
                  ? Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Consumer<UserProvider>(
                            builder: (context, value, child) => value.user?.image != null
                                ? CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: NetworkImage(value.user?.image ?? ''),
                                    backgroundColor: Colors.transparent,
                                  )
                                : SvgPicture.asset(AppAssets.profileEmptyIcon),
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
                      initialValue: initialValue,
                      controller: controller,
                      inputFormatters:
                          isSessionPriceField == true ? [ValidationUtils.maskPhoneNumber] : null,
                      hint: hint??'',
                      showBorders: false,
                      fillColor: colors.inputTextfieldColor,
                    ),
        ],
      ),
    );
  }
}
