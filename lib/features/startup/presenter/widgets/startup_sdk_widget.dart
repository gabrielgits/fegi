import 'package:easy_localization/easy_localization.dart';
import 'package:bform/bform.dart';
import 'package:fegi/core/helpers/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_startup.dart';
import '../controllers/suggestions_sdk.dart';

class StartupSdkWidget extends StatelessWidget {
  const StartupSdkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorHead = Theme.of(context).colorScheme.inversePrimary;
    final colorBody = Theme.of(context).colorScheme.primaryContainer;
    final controller = context.read<ControllerStartup>();
    return Column(
      children: [
        Text(
          tr('msn.suggestions'),
          //style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        BformTableText(
          titles: <String>[
            tr('home.sdkVersion'),
            tr('home.sdkArchitecture'),
            tr('home.releaseDate'),
            tr('home.dartVersion'),
          ],
          backgroundTitle: colorHead,
          listElements: suggestionsSdk
              .map((e) => [
                    e.version,
                    e.architecture,
                    dateHelper(date: e.date),
                    e.dartVersion,
                  ])
              .toList(),
          background: colorBody,
          actionTitle: tr('home.options'),
          actionButtons: suggestionsSdk
              .map((e) => IconButton(
                    iconSize: 18,
                    icon: const Icon(Icons.install_desktop),
                    tooltip: tr('btn.install'),
                    onPressed: () {
                      controller.installSdkRelease(e);
                    },
                  ))
              .toList(),
        ),
        const SizedBox(height: 20),
        BformButton(
          label: tr('btn.skip'),
          colors: [colorHead],
          style: BformButtonStyle.outlined,
          onPressed: () {
            controller.skip();
          }
        )
      ],
    );
  }
}
