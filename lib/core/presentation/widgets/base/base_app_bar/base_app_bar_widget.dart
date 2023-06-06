import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:therapist_journey/core/data/utilities/app_constants.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/create_account/create_account_dialog.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_app_bar/bloc/base_app_bar_bloc.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_app_bar/bloc/base_app_bar_event.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_app_bar/bloc/base_app_bar_state.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_stateless_widget.dart';

class BaseAppBarWidget extends BaseStatelessWidget implements PreferredSizeWidget {
  final double appBarHeigth;
  BaseAppBarWidget({
    super.key,
    required this.appBarHeigth,
    this.isEditProfileScreen = false,
  });
  bool isEditProfileScreen;
  @override
  Widget baseBuild(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<BlocFactory>().create<BaseAppBarBloc>(),
      child: BlocConsumer<BaseAppBarBloc, BaseAppBarState>(
        buildWhen: (previous, current) => current.buildWhen(),
        listenWhen: (previous, current) => current.listenWhen(),
        listener: (context, state) => state.whenOrNull(
          logout: () {
            context.read<UserProvider>().clearUserData();
            Get.rootDelegate.offNamed(AppRoutes.mainRoute);
            return null;
          },
          loading: () => showLoading(context),
          error: (msg, code) => showErrorDialog(context, msg: msg),
        ),
        builder: (context, state) => state.maybeWhen(
          orElse: () => Container(),
          initial: () {
            hideLoading(context);
            return AppBar(
              leading: isMobile
                  ? InkWell(
                      onTap: () => AppConstants.scaffoldKey.currentState?.openDrawer(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SvgPicture.asset(
                          AppAssets.mobileMenuIcon,
                        ),
                      ),
                    )
                  : null,
              toolbarHeight: appBarHeigth,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              shape: Border(
                bottom: BorderSide(
                  color: colors.whisperColor,
                  width: 2,
                ),
              ),
              elevation: 0,
              backgroundColor: colors.whiteColor,
              actions: [
                isMobile
                    ? Padding(
                        padding: EdgeInsets.only(right: 20.sp),
                        child: Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                            return Center(
                              child: PreferencesManager.user != null
                                  ? PopupMenuButton(
                                      offset: const Offset(30, 60),
                                      shadowColor: colors.shadowColor,
                                      color: colors.whiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                        side: BorderSide(color: colors.popupbBorderColor),
                                      ),
                                      iconSize: 40,
                                      icon: userProvider.user?.image != null
                                          ? CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(userProvider.user?.image ?? ''),
                                              backgroundColor: Colors.transparent,
                                            )
                                          : Image.asset(
                                              AppAssets.appBarProfileIcon,
                                            ),
                                      onSelected: (item) {
                                        if (item == 1) {
                                          Get.rootDelegate.toNamed(AppRoutes.profileRoute);
                                        } else if (item == 2) {
                                          context.read<BaseAppBarBloc>().add(
                                                const BaseAppBarEvent.logoutUser(),
                                              );
                                        }
                                      },
                                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                                        PopupMenuItem(
                                          value: 1,
                                          child: Text(
                                            AppStrings.viewProfileText,
                                            style: fonts.poppinsRegular,
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text(
                                            AppStrings.logOutText,
                                            style: fonts.poppinsRegular,
                                          ),
                                        ),
                                      ],
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const CreateAccountDialog();
                                          },
                                        );
                                      },
                                      child: Text(
                                        isMobile
                                            ? AppStrings.joinText
                                            : AppStrings.joinAsATherapistText,
                                        style: fonts.poppinsBold.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
              ],
              title: SafeArea(
                child: Row(
                  mainAxisAlignment:
                      isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: isMobile ? null : sizes.width * .24,
                      child: InkWell(
                        onTap: () {
                          Get.rootDelegate.toNamed(AppRoutes.mainRoute);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.offloadText,
                              style: fonts.poppinsBold.copyWith(
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: colors.whisperColor,
                              ),
                              child: Text(
                                AppStrings.betaText,
                                style: fonts.poppinsBold.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isMobile
                        ? const SizedBox()
                        : SizedBox(
                            width: sizes.width * .37,
                            child: Consumer<UserProvider>(
                              builder: (context, userProvider, child) {
                                return Center(
                                  child: PreferencesManager.user != null
                                      ? PopupMenuButton(
                                          offset: const Offset(30, 60),
                                          shadowColor: colors.shadowColor,
                                          color: colors.whiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            side: BorderSide(color: colors.popupbBorderColor),
                                          ),
                                          iconSize: 40,
                                          icon: userProvider.user?.image != null
                                              ? CircleAvatar(
                                                  backgroundImage:
                                                      NetworkImage(userProvider.user?.image ?? ''),
                                                  backgroundColor: Colors.transparent,
                                                )
                                              : Image.asset(
                                                  AppAssets.appBarProfileIcon,
                                                ),
                                          onSelected: (item) {
                                            if (item == 1) {
                                              Get.rootDelegate.toNamed(AppRoutes.profileRoute);
                                            } else if (item == 2) {
                                              context.read<BaseAppBarBloc>().add(
                                                    const BaseAppBarEvent.logoutUser(),
                                                  );
                                            }
                                          },
                                          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                                            PopupMenuItem(
                                              value: 1,
                                              child: Text(
                                                AppStrings.viewProfileText,
                                                style: fonts.poppinsRegular,
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 2,
                                              child: Text(
                                                AppStrings.logOutText,
                                                style: fonts.poppinsRegular,
                                              ),
                                            ),
                                          ],
                                        )
                                      : TextButton(
                                          onPressed: () {
                                            showDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const CreateAccountDialog();
                                              },
                                            );
                                          },
                                          child: Text(
                                            isMobile
                                                ? AppStrings.joinText
                                                : AppStrings.joinAsATherapistText,
                                            style: fonts.poppinsBold.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeigth);
}
