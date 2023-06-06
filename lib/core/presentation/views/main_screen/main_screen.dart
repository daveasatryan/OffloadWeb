import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist_journey/core/data/utilities/app_constants.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/strings/app_strings.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/bloc/main_screen_bloc.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/bloc/main_screen_event.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/bloc/main_screen_state.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/main_desktop_widget.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/widgets/main_mobile_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_app_bar/base_app_bar_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/drawer_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends BaseState<MainScreen> {
  AppStrings get appStrings => AppStrings();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<BlocFactory>().create<MainScreenBloc>()
        ..add(
          const MainScreenEvent.getTherapist(),
        ),
      child: BlocConsumer<MainScreenBloc, MainScreenState>(
        buildWhen: (previous, current) => current.buildWhen(),
        listenWhen: (previous, current) => current.listenWhen(),
        listener: (context, state) => state.whenOrNull(
          success: () {
            return;
          },
          loading: () => showLoading(context),
          error: (msg, code) => showErrorDialog(context, msg: msg),
        ),
        builder: (context, state) => state.maybeWhen(
          orElse: () => Container(),
          getTherapist: (user) {
            hideLoading(context);
            return Scaffold(
              drawer: DrawerWidget(),
              key: AppConstants.scaffoldKey,
              backgroundColor: colors.whiteColor,
              appBar: BaseAppBarWidget(
                appBarHeigth: isMobile ? 55 : 65,
              ),
              body: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? double.infinity : sizes.width * .9,
                    minWidth: isMobile ? double.infinity : sizes.width * .6,
                    minHeight: isMobile ? double.infinity : 0.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.whiteColor,
                    ),
                    child: isMobile
                        ? MainMobileWidget(userList: user?.data)
                        : MainDesktopWidget(userList: user?.data),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
