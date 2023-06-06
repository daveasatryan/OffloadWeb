import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/assets/app_assets.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/bloc/waitlist_.state.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/bloc/waitlist_bloc.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/widgets/waitlist_desktop_screen.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/widgets/waitlist_mobile_screen.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';

class WaitListScreen extends StatefulWidget {
  const WaitListScreen({super.key});

  @override
  State<WaitListScreen> createState() => _WaitListScreenState();
}

class _WaitListScreenState extends BaseState<WaitListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.waitListScaffoldColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              matchTextDirection: true,
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
              image: AssetImage(
                AppAssets.waitListBackgroundIcon,
              ),
            ),
          ),
          child: BlocProvider(
            create: (context) => context.read<BlocFactory>().create<WaitlistBloc>(),
            child: BlocConsumer<WaitlistBloc, WaitlistState>(
              buildWhen: (previous, current) => current.buildWhen(),
              listenWhen: (previous, current) => current.listenWhen(),
              listener: (context, state) {
                state.whenOrNull(
                  success: () {},
                  loading: () => showLoading(context),
                  error: (msg, code) => showErrorDialog(context, msg: msg),
                );
              },
              builder: (context, state) => state.maybeWhen(
                orElse: () => Container(),
                validation: (email, button, changeWidget) {
                  hideLoading(context);
                  return Center(
                    child: isMobile
                        ? WaitListMobileScreen(
                            email: email,
                            button: button,
                            changewidget: changeWidget,
                          )
                        : WaitListDesktopScreen(
                            email: email,
                            button: button,
                            changewidget: changeWidget,
                          ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
