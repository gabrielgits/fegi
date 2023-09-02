import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/constants.dart';
import 'package:fegi/core/states/controller_state.dart';
import 'package:fegi/core/states/sdk_state.dart';
import 'package:system_tray/system_tray.dart';

import 'controller_home.dart';

final SystemTray _systemTray = SystemTray();
Timer? _timer;
bool _toogleTrayIcon = true;

String _getTrayImagePath() {
  const icon = 'assets/images/icons/app_icon';
  return Platform.isWindows ? '$icon.ico' : '$icon.png';
}

String _getImagePath(String imageName) {
  const path = 'assets/images/icons/tray';
  return Platform.isWindows ? '$path/$imageName.bmp' : '$path/$imageName.png';
}

void _trayIconFlashStart() {
  _timer ??= Timer.periodic(
    const Duration(milliseconds: 250),
    (timer) {
      _toogleTrayIcon = !_toogleTrayIcon;
      _systemTray.setImage(_toogleTrayIcon ? "" : _getTrayImagePath());
    },
  );
}

void _trayIconFlashStop() {
  _timer?.cancel();
  _timer = null;
  _systemTray.setImage(_getTrayImagePath());
}

Future<void> initSystemTray(ControllerHome controller) async {
  final AppWindow appWindow = AppWindow();
  final Menu menuMain = Menu();

  await _systemTray.initSystemTray(iconPath: _getTrayImagePath());
  _systemTray.setTitle(App.name);

  _systemTray.registerSystemTrayEventHandler((eventName) {

    if (eventName == kSystemTrayEventClick) {
      Platform.isWindows ? appWindow.show() : _systemTray.popUpContextMenu();
    } else if (eventName == kSystemTrayEventRightClick) {
      Platform.isWindows ? _systemTray.popUpContextMenu() : appWindow.show();
    }
  });

  final loaded = ControllerStateLoaded();

  if (controller.controllerState != loaded) {
    _systemTray.setToolTip(controller.controllerState.toString());
    menuMain.buildFrom([
      MenuItemLabel(
        label: tr('tray.restoure'),
        image: _getImagePath('darts_icon'),
        onClicked: (menuItem) {
          appWindow.show();
        },
      ),
      MenuItemLabel(label: 'Exit', onClicked: (menuItem) => exit(0)),
    ]);
    _systemTray.setContextMenu(menuMain);
    _trayIconFlashStart();
    return;
  }
  _trayIconFlashStop();

  _systemTray.setToolTip(
    'Flutter: ${controller.globalRelease.version} - '
    'Dart: ${controller.globalRelease.dartVersion} - '
    '${controller.globalRelease.architecture} / ${controller.globalRelease.channel}',
  );

  await menuMain.buildFrom(
    [
      MenuItemLabel(
        label: '${App.name} ver. ${App.version}',
        image: _getTrayImagePath(),
        onClicked: (menuItem) {
          appWindow.show();
        },
      ),
      MenuSeparator(),
      SubMenu(
        label: tr("tray.global"),
        image: _getImagePath('gift_icon'),
        children: controller.listSdkReleases
            .where((e) =>
                e.state == SdkState.installed || e.state == SdkState.global)
            .map((e) => MenuItemCheckbox(
                label: '${tr("tray.version")}: ${e.version}',
                checked: e.state == SdkState.global,
                onClicked: (_) {
                  if (e.state == SdkState.global) {
                    return;
                  }
                  controller.globalSet(e);
                }))
            .toList(),
      ),
      SubMenu(
        label: tr("tray.releases"),
        image: _getImagePath('gift_icon'),
        children: controller.listSdkReleases
            .map((e) => SubMenu(
                label: '${tr("tray.version")}: ${e.version}',
                children: switch (e.state) {
                  SdkState.available => [
                      MenuItemLabel(
                          label: tr('btn.remove'),
                          onClicked: (_) {
                            controller.removeSdkRelease(e);
                          }),
                      MenuItemLabel(
                          label: tr('btn.download'),
                          onClicked: (_) async {
                            await controller.downloadSdkRelease(e);
                            await controller.loadGlobalRelease();
                          }),
                    ],
                  SdkState.downloaded => [
                      MenuItemLabel(
                          label: tr('btn.delete'),
                          onClicked: (_) async {
                            await controller.deleteSdkRelease(e);
                            await controller.loadListReleases();
                          }),
                      MenuItemLabel(
                          label: tr('btn.install'),
                          onClicked: (_) {
                            controller.installSdkRelease(e);
                          }),
                    ],
                  SdkState.installed => [
                      MenuItemLabel(
                          label: tr('btn.uninstall'),
                          onClicked: (_) {
                            controller.uninstallSdkRelease(e);
                          }),
                      MenuItemLabel(
                          label: tr('btn.globalset'),
                          onClicked: (_) {
                            controller.globalSet(e);
                          }),
                    ],
                  SdkState.global => [
                      MenuItemLabel(
                          label: tr('btn.globalremove'),
                          onClicked: (_) {
                            controller.globalRemove(e);
                          }),
                    ],
                  _ => [MenuSeparator()],
                }))
            .toList(),
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: tr('tray.restoure'),
        image: _getImagePath('darts_icon'),
        onClicked: (menuItem) {
          appWindow.show();
        },
      ),
      MenuItemLabel(label: tr('tray.exit'), onClicked: (menuItem) => exit(0)),
    ],
  );

  _systemTray.setContextMenu(menuMain);
}
