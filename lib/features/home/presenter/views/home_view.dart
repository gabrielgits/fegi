import 'dart:async';

import 'package:alertshow/alertshow.dart';
import 'package:bform/bform.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/constants.dart';
import 'package:fegi/core/feature/presenter/widgets/error_view_widget.dart';
import 'package:fegi/core/states/controller_state.dart';
import 'package:fegi/features/home/presenter/controllers/controller_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import 'package:window_manager/window_manager.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/getsdk_table_widget.dart';
import '../widgets/available_releases/available_releases_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final controller = context.read<ControllerHome>();
        //await controller.loadGlobalRelease();
        final settings = await controller.loadSettings();
        if (settings.id == 0) {
          controller.createSettings();
        }
        await windowManager.setPreventClose(true);
        if (settings.startMini) {
          await windowManager.waitUntilReadyToShow(null, () async {
            await _hideWindow();
          });
          // await AppWindow().hide();
        }
      },
    );
  }

  _hideWindow() async {
    await windowManager.hide();
  }

  @override
  Widget build(BuildContext context) {
    const appcastURL =
        'https://raw.githubusercontent.com/gabrielgits/fegi/main/setup/upgrader.xml';
    final appcastConfig = AppcastConfiguration(
      url: appcastURL,
      supportedOS: [
        'windows',
        'macos',
        'linux',
      ],
    );

    return Selector<ControllerHome, ControllerState>(
        selector: (context, controller) => controller.globalState,
        builder: (context, globalReleaseState, _) {
          final color = globalReleaseState == ControllerStateLoaded()
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.error;

          final controller = context.read<ControllerHome>();
          if (controller.settings.currentLang == 2) {
            context.setLocale(const Locale('pt', 'PT'));
          }

          if (controller.globalState != ControllerStateLoaded()) {
            return const Scaffold(
              body: ErrorViewWidget(
                error: 'Cannot create settings config',
              ),
            );
          }

          return UpgradeAlert(
            upgrader: Upgrader(
              appcastConfig: appcastConfig,
              showLater: false,
            ),
            child: Scaffold(
              appBar: const AppbarWidget(title: App.describe),
              body: const Padding(
                padding: EdgeInsets.all(8.0),
                child: AvailableReleasesWidget(),
              ),
              bottomNavigationBar: BformFooter(
                leftChild: BformButton(
                  label: tr('home.getSdk'),
                  style: BformButtonStyle.outlined,
                  colors: [color],
                  onPressed: () async {
                    bool dialog = await alertshowDialog(
                      title: tr('home.getSdk'),
                      context: context,
                      content: const GetsdkTableWidget(),
                      yesButton: tr('btn.get'),
                      noButton: tr('btn.cancel'),
                    );
                    if (dialog) {
                      controller.importReleases();
                    }
                  },
                ),
                middleChild: BformButton(
                    label: tr('home.downloadAll'),
                    style: BformButtonStyle.outlined,
                    colors: [color],
                    onPressed: () async {
                      bool dialog = await alertshowDialog(
                        context: context,
                        title: tr('home.donwloadAllTitle'),
                        content: Text(tr('home.downloadAllAsk')),
                        yesButton: tr('btn.yes'),
                        noButton: tr('btn.no'),
                      );
                      if (dialog) {
                        controller.downloadAllReleases();
                      }
                    }),
                rightChild: BformButton(
                    label: tr('home.deleteAll'),
                    style: BformButtonStyle.outlined,
                    colors: [color],
                    onPressed: () async {
                      bool dialog = await alertshowDialog(
                        context: context,
                        title: tr('home.deleteAllTitle'),
                        content: Text(tr('home.deleteAllAsk')),
                        yesButton: tr('btn.yes'),
                        noButton: tr('btn.no'),
                      );
                      if (dialog) {
                        controller.deleteAllReleases();
                      }
                    }),
              ),
            ),
          );
        });
  }

  @override
  Future<void> onWindowMinimize() async {
    _hideWindow();
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      bool dialog = await alertshowDialog(
        context: context,
        title: tr('home.closeWindow'),
        content: Text(tr('msn.closeWindow')),
        yesButton: tr('btn.close'),
        noButton: tr('btn.cancel'),
      );
      if (dialog) {
        await windowManager.destroy();
      }
    }
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }
}
