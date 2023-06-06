import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/views/splash/bloc/splash_bloc.dart';
import 'package:therapist_journey/core/presentation/views/splash/bloc/splash_event.dart';
import 'package:therapist_journey/core/presentation/views/splash/bloc/splash_state.dart';
import 'package:therapist_journey/core/presentation/widgets/app_loading.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<BlocFactory>().create<SplashBloc>()
        ..add(
          const SplashEvent.getUserData(),
        ),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) => state.whenOrNull(
          isLogin: (UserModel? user) {
            context.read<UserProvider>().user = user;
            Get.rootDelegate.toNamed(AppRoutes.mainRoute);
            return;
          },
          loading: () => showLoading(context),
        ),
        child: const AppLoadingWidget(),
      ),
    );
  }
}
