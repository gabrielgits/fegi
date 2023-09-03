import 'package:flutter/widgets.dart';

import '../features/home/presenter/views/home_view.dart';
import '../features/startup/presenter/views/startup_view.dart';

class Routes {
  static String initialRoute = '/';

  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomeView(),

    //Home feature
    '/home': (context) => const HomeView(),

    //Startup feature
    '/startup': (context) => const StartupView(),
  };
}
