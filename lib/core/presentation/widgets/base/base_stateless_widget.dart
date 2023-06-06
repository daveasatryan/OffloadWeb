import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/utilities/color/app_colors.dart';
import 'package:therapist_journey/core/presentation/utilities/color/color_scheme.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/widgets/app_error_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/app_loading.dart';
import 'package:therapist_journey/core/presentation/widgets/two_option_dialog.dart';
import 'package:provider/provider.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  bool _isLoaderShown = false;

  BaseStatelessWidget({super.key});

  AppColors get colors => Theme.of(context).colorScheme.appColors;

  TextTheme get fonts => Theme.of(context).textTheme;

  Size get sizes => MediaQuery.of(context).size;

  AppStrings get appStrings => AppStrings();

  AppAssets get appAssets => AppAssets();

  bool get isMobile => ResponsiveWrapper.of(context).isSmallerThan(DESKTOP);

  late BuildContext context;

  void showErrorDialog(
    BuildContext context, {
    required String msg,
    String? title,
    String? buttonText,
    Function? onPressed,
    bool isBarrierDismissible = false,
  }) {
    hideLoading(context);
    showDialog(
      context: context,
      barrierColor: colors.barrierColor,
      barrierDismissible: isBarrierDismissible,
      builder: (context) {
        return AppErrorWidget(
          title: title,
          buttonText: buttonText,
          message: msg,
          onPressed: () {
            onPressed?.call();
          },
        );
      },
    );
  }

  void showLogoutDialog(
    BuildContext context, {
    required String msg,
    String? title,
    Function? onPressed,
  }) {
    hideLoading(context);
    showDialog(
      context: context,
      barrierColor: colors.barrierColor,
      barrierDismissible: false,
      builder: (context) {
        return AppErrorWidget(
          message: msg,
          onPressed: () {
            onPressed?.call();
            Get.rootDelegate.toNamed(AppRoutes.mainRoute);
          },
        );
      },
    );
    PreferencesManager.clearUserData();
    context.read<UserProvider>().user = null;
  }

  void showLoading(BuildContext context) {
    hideLoading(context);
    _isLoaderShown = true;
    showDialog(
      barrierDismissible: false,
      barrierColor: colors.barrierColor,
      context: context,
      builder: (context) {
        return const AppLoadingWidget();
      },
    );
  }

  void showTwoOptionDialog(
    BuildContext context, {
    required String msg,
    String? title,
    String? positiveButtonText,
    VoidCallback? positiveButtonClick,
    String? negativeButtonText,
    VoidCallback? negativeButtonClick,
    bool isBarrierDismissible = false,
  }) {
    hideLoading(context);
    showDialog(
      context: context,
      barrierColor: colors.barrierColor,
      barrierDismissible: false,
      builder: (context) {
        return TwoOptionDialog(
          msg: msg,
          title: title,
          positiveButtonText: positiveButtonText,
          negativeButtonText: negativeButtonText,
          positiveButtonClick: positiveButtonClick,
          negativeButtonClick: negativeButtonClick,
        );
      },
    );
  }

  void hideLoading(BuildContext context) {
    if (_isLoaderShown) {
      Navigator.pop(context);
      _isLoaderShown = false;
    }
  }

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  Widget baseBuild(BuildContext context);

  @nonVirtual
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return baseBuild(context);
  }
}
