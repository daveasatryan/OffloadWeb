import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/utilities/app_constants.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_bloc.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_event.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_state.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/edit_profile_screen_desktop.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/widgets/edit_profile_screen_mobile.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_app_bar/base_app_bar_widget.dart';
import 'package:therapist_journey/core/presentation/widgets/drawer_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends BaseState<EditProfileScreen> {
  final nameController = TextEditingController();

  final sessionPriceController = TextEditingController();

  final bioController = TextEditingController();

  final certificationController = TextEditingController();

  final locationController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    sessionPriceController.dispose();
    bioController.dispose();
    certificationController.dispose();
    locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<BlocFactory>().create<EditProfileBloc>()
        ..add(
          EditProfileEvent.getUserEditInitial(
            context.read<UserProvider>().user ?? const UserModel(),
          ),
        ),
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        buildWhen: (previous, current) => current.buildWhen(),
        listenWhen: (previous, current) => current.listenWhen(),
        listener: (context, state) => state.whenOrNull(
          success: (UserModel? user) {
            context.read<UserProvider>().user = user;
            Get.rootDelegate.toNamed(AppRoutes.profileRoute);
            return;
          },
          successUploadImage: (UserModel? user) {
            context.read<UserProvider>().user = user;
            return;
          },
          successCalendar: (UserModel? user) {
            context.read<UserProvider>().user = user;
            return;
          },
          loading: () => showLoading(context),
          error: (msg, code) => showErrorDialog(context, msg: msg),
        ),
        builder: (context, state) => state.maybeWhen(
          orElse: () => Container(),
          userData: (user, weekDayList) {
            hideLoading(context);
            return Scaffold(
              drawer: DrawerWidget(),
              key: AppConstants.scaffoldKey,
              backgroundColor: colors.whiteColor,
              appBar: BaseAppBarWidget(
                isEditProfileScreen: true,
                appBarHeigth: isMobile ? 55 : 65,
              ),
              body: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? double.infinity : sizes.width * .9,
                    minWidth: isMobile ? double.infinity : sizes.width * .9,
                    minHeight: isMobile ? double.infinity : 0.0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: isMobile
                        ? EditProfileScreenMobile(
                            user: user,
                            nameController: nameController,
                            sessionPriceController: sessionPriceController,
                            bioController: bioController,
                            certificationController: certificationController,
                            locationController: locationController,
                            weekDayList: weekDayList ?? [])
                        : EditProfileScreenDesktop(
                            user: user,
                            nameController: nameController,
                            sessionPriceController: sessionPriceController,
                            bioController: bioController,
                            certificationController: certificationController,
                            locationController: locationController,
                            weekDayList: weekDayList ?? []),
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
