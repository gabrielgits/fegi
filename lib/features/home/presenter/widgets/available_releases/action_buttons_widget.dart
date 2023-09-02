import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/states/sdk_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controller_home.dart';

class ActionButtonsWidget extends StatelessWidget {
  final SdkRelease release;
  const ActionButtonsWidget({super.key, required this.release});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ControllerHome>();
    if (release.state == SdkState.available) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconSize: 18,
            tooltip: tr('btn.remove'),
            onPressed: () {
              controller.removeSdkRelease(release);
            },
            icon: const Icon(Icons.remove_circle_outline),
          ),
          IconButton(
            iconSize: 18,
            tooltip: tr('btn.download'),
            onPressed: () async {
              await controller.downloadSdkRelease(release);
              await controller.loadListReleases();
            },
            icon: const Icon(Icons.download),
          ),
        ],
      );
    } else if (release.state == SdkState.downloaded) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconSize: 18,
            tooltip: tr('btn.delete'),
            onPressed: () async {
             await  controller.deleteSdkRelease(release);
             await   controller.loadListReleases();
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            iconSize: 18,
            tooltip: tr('btn.install'),
            onPressed: () {
              controller.installSdkRelease(release);
            },
            icon: const Icon(Icons.desktop_windows_sharp),
          ),
        ],
      );
    } else if (release.state == SdkState.installed) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconSize: 18,
            tooltip: tr('btn.uninstall'),
            onPressed: () {
              controller.uninstallSdkRelease(release);
            },
            icon: const Icon(Icons.desktop_access_disabled),
          ),
          IconButton(
            iconSize: 18,
            tooltip: tr('btn.globalset'),
            onPressed: () {
              controller.globalSet(release);
            },
            icon: const Icon(Icons.public),
          ),
        ],
      );
    } else if (release.state == SdkState.global) {
      return IconButton(
        iconSize: 18,
        tooltip: tr('btn.globalremove'),
        onPressed: () {
          controller.globalRemove(release);
        },
        icon: const Icon(Icons.public_off),
      );
    }
    return Container();
  }
}
