import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:upgrader/upgrader.dart';

import 'app_widget.dart';
import 'core/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // Add this line to override the default close handler
  await windowManager.ensureInitialized();

  if (!App.debug) {
    EasyLocalization.logger.enableBuildModes = [];
  }
  else {
    await Upgrader.clearSavedSettings();
  }

  WindowOptions windowOptions = const WindowOptions(
    size: Size(700, 500),
    center: true,
    skipTaskbar: false,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setResizable(false);
    await windowManager.setMaximizable(false);
    //await windowManager.hide();
    //await windowManager.focus();
  });

  return runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('pt', 'PT')],
      path: 'assets/languages',
      fallbackLocale: const Locale('en', 'US'),
      child: const AppWidget(),
    ),
  );
}
