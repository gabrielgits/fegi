import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/providers_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/helpers/color_schemes.g.dart';
import 'core/constants.dart';
import 'core/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String initialRoute = Routes.initialRoute;

    return MultiProvider(
      providers: providersApp,
      child: MaterialApp(
        debugShowCheckedModeBanner: App.debug,
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: App.name,
        initialRoute: initialRoute,
        routes: Routes.routes,
      ),
    );
  }
}
