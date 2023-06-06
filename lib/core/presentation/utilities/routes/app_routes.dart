import 'package:get/get.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/edit_profile_screen.dart';
import 'package:therapist_journey/core/presentation/views/main_screen/main_screen.dart';
import 'package:therapist_journey/core/presentation/views/privacy_policy/privacy_policy_screen.dart';
import 'package:therapist_journey/core/presentation/views/profile_screen/profile_screen.dart';
import 'package:therapist_journey/core/presentation/views/splash/splash_screen.dart';
import 'package:therapist_journey/core/presentation/views/waitlist/waitlist_screen.dart';
import 'package:universal_html/html.dart' as html;

class AppRoutes {
  static const splashRoute = '/';
  static const waitlistRoute = '/waitlist';
  static const privacyPolicyRoute = '/privacy-policy';
  static const mainRoute = '/therapists';
  static const profileRoute = '/profile';
  static const therapistRoute = '/therapist/:uuid';
  static const editProfileRoute = '/edit-profile';

  static String toTerapist(String? uuid) => '/therapist/$uuid';

  static final List<GetPage> _appRoutes = [
    GetPage(
      name: splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: waitlistRoute,
      page: () => const WaitListScreen(),
    ),
    GetPage(
      name: privacyPolicyRoute,
      page: () => const PrivacyPolicyScreen(),
    ),
    GetPage(
      name: mainRoute,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: profileRoute,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: therapistRoute,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: editProfileRoute,
      page: () => const EditProfileScreen(),
    ),
  ];

  static List<GetPage> get getRoutes => _appRoutes;
  static void back() => html.window.history.back();
}
