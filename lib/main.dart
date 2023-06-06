import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:therapist_journey/core/data/utilities/injection/injection.dart';
import 'package:therapist_journey/core/data/utilities/log/logger_service.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';
import 'package:therapist_journey/core/presentation/application.dart';
import 'package:therapist_journey/core/presentation/utilities/color/app_colors.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  window.onBeforeUnload.listen((event) {
    PreferencesManager.closeApp();
  });
  setPathUrlStrategy();
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await configureDependencies();
      await PreferencesManager.initPreferences();
      await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [
          SystemUiOverlay.bottom,
          SystemUiOverlay.top,
        ],
      );
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: AppColors().mainAppColor,
          statusBarBrightness: Brightness.dark,
        ),
      );
      runApp(
        const Application(),
      );
    },
    (error, stackTrace) {
      LoggerService().e(
        'Error is $error, stack $stackTrace',
      );
    },
  );
}