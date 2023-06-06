import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:therapist_journey/core/data/utilities/app_constants.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/profile_screen_bloc.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/profile_screen_event.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/bloc/profile_screen_state.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/profile_screen_desktop.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/widgets/profile_screen_mobile.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_app_bar/base_app_bar_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/drawer_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseState<ProfileScreen> {
  String? userUuid;

  @override
  void initState() {
    userUuid = Get.parameters['uuid'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<BlocFactory>().create<ProfileScreenBloc>()
        ..add(
          ProfileScreenEvent.getUserInitial(userUuid),
        ),
      child: Scaffold(
        drawer: DrawerWidget(),
        key: AppConstants.scaffoldKey,
        backgroundColor: colors.whiteColor,
        appBar: BaseAppBarWidget(
          appBarHeigth: isMobile ? 55 : 65,
        ),
        body: BlocConsumer<ProfileScreenBloc, ProfileScreenState>(
          buildWhen: (previous, current) => current.buildWhen(),
          listenWhen: (previous, current) => current.listenWhen(),
          listener: (context, state) => state.whenOrNull(
            success: () {
              return;
            },
            logout: () {
              PreferencesManager.clearUserData();
              Get.rootDelegate.toNamed(AppRoutes.mainRoute);
              return null;
            },
            loading: () => showLoading(context),
            error: (msg, code) => showErrorDialog(context, msg: msg),
          ),
          builder: (context, state) => state.maybeWhen(
            orElse: () => Container(),
            getUser: (user) {
              hideLoading(context);
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? double.infinity : sizes.width * .6,
                    minWidth: isMobile ? double.infinity : sizes.width * .6,
                    minHeight: isMobile ? double.infinity : 0.0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: isMobile
                        ? ProfileScreenMobile(user: user)
                        : ProfileScreenDesktop(user: user),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
