import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:therapist_journey/core/data/utilities/bloc/bloc_factory.dart';
import 'package:therapist_journey/core/data/utilities/delegates/router_delegate.dart';
import 'package:therapist_journey/core/data/utilities/sl/service_locator_factory.dart';
import 'package:therapist_journey/core/presentation/utilities/provider/user_provider.dart';
import 'package:therapist_journey/core/presentation/utilities/routes/app_routes.dart';
import 'package:therapist_journey/core/presentation/utilities/styles/app_styles.dart';
import 'package:therapist_journey/core/presentation/utilities/typography/text_theme.dart';
import 'package:provider/provider.dart';
import 'package:therapist_journey/core/presentation/widgets/base/base_state.dart';

class Application extends StatefulWidget {
  const Application({
    Key? key,
  }) : super(key: key);

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends BaseState<Application> {
  AppRouterDelegate? appRouterDelegate;
  GetObserver? getObserver;

  @override
  void initState() {
    appRouterDelegate = AppRouterDelegate();
    getObserver = GetObserver();
    super.initState();
  }

  @override
  void dispose() {
    appRouterDelegate?.dispose();
    getObserver = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => BlocFactory(getIt: GetIt.instance),
        ),
        Provider(
          create: (context) => SlFactory(getIt: GetIt.instance),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: Builder(builder: (context) {
        return LayoutBuilder(builder: (context, constraints) {
          return ScreenUtilInit(
              designSize: Size(constraints.maxWidth, constraints.maxHeight),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, _) {
                return ResponsiveWrapper.builder(
                  GetMaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    defaultTransition: Transition.noTransition,
                    transitionDuration: const Duration(seconds: 0),
                    navigatorObservers: [getObserver ?? GetObserver()],
                    routerDelegate: appRouterDelegate,
                    getPages: AppRoutes.getRoutes,
                    theme: ThemeData(
                      fontFamily: 'Poppins',
                      primaryColor: colors.mainAppColor,
                      primarySwatch: const MaterialColor(
                        0xddd9d9d9,
                        <int, Color>{
                          50: Color(0xddd9d9d9),
                          100: Color(0xddd9d9d9),
                          200: Color(0xddd9d9d9),
                          300: Color(0xddd9d9d9),
                          400: Color(0xddd9d9d9),
                          500: Color(0xddd9d9d9),
                          600: Color(0xddd9d9d9),
                          700: Color(0xddd9d9d9),
                          800: Color(0xddd9d9d9),
                          900: Color(0xddd9d9d9),
                        },
                      ),
                      highlightColor: colors.transparent,
                      splashColor: colors.transparent,
                      hoverColor: colors.transparent,
                      navigationRailTheme: NavigationRailThemeData(
                        unselectedLabelTextStyle:
                            fonts.poppinsBold.copyWith(color: colors.black, fontSize: 16),
                        selectedLabelTextStyle:
                            fonts.poppinsBold.copyWith(color: colors.black, fontSize: 16),
                      ),
                      checkboxTheme: CheckboxThemeData(
                        checkColor: MaterialStateProperty.all(
                          colors.mainAppColor,
                        ),
                        fillColor: MaterialStateProperty.all(
                          colors.whiteColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppStyles.cornerRadius5,
                          ),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(
                            width: 2,
                            color: colors.mainAppColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  breakpoints: [
                    const ResponsiveBreakpoint.resize(
                      450,
                      name: MOBILE,
                    ),
                    const ResponsiveBreakpoint.resize(
                      600,
                      name: TABLET,
                    ),
                    const ResponsiveBreakpoint.resize(
                      800,
                      name: DESKTOP,
                    ),
                  ],
                  minWidth: 450,
                  defaultScale: true,
                );
              });
        });
      }),
    );
  }
}
