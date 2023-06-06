import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_bloc.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_event.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class EditProfilePhotoDesktopWidget extends BaseStatelessWidget {
  EditProfilePhotoDesktopWidget({
    super.key,
  });

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
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              AppStrings.profilePhotoText,
              style: fonts.poppinsBold.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Align(
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
          ),
        ],
      ),
    );
  }
}
