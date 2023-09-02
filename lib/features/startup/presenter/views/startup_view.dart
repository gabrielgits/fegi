import 'package:bform/bform.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/states/controller_state.dart';
import 'package:fegi/core/feature/presenter/widgets/error_view_widget.dart';
import 'package:fegi/core/feature/presenter/widgets/loading_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_startup.dart';
import '../widgets/startup_finished_widget.dart';
import '../widgets/startup_sdk_widget.dart';
import '../widgets/startup_settings_widget.dart';

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    //final controllerStartup = context.read<ControllerStartup>();
    return Scaffold(
      appBar: BformAppbar(
        title: tr('startup.title'),
        icon: Icons.settings_display,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<ControllerStartup>(
              builder: (context, controller, child) {
            switch (controller.state) {
              case ControllerStateLoading():
                return LoadingViewWidget(info: controller.state.toString());
              case ControllerStateLoaded():
                switch (controller.step) {
                  case 1:
                    return StartupSettingWidget(controller: controller);
                  case 2:
                    return const StartupSdkWidget();
                  case 3:
                    return const StartupFinishedWidget();
                }
              default:
                return ErrorViewWidget(error: controller.state.toString());
            }
            return ErrorViewWidget(error: controller.state.toString());
          })),
    );
  }
}
