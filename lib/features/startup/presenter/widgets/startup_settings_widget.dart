import 'package:bform/bform.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../controllers/controller_startup.dart';

class StartupSettingWidget extends StatelessWidget {
  final ControllerStartup controller;
  const StartupSettingWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            tr('msn.welcome'),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          BformButton(
            style: BformButtonStyle.highlighted,
            fontSize: 18,
            textColor: Theme.of(context).colorScheme.background,
            colors: [
              Theme.of(context).colorScheme.tertiary,
              //Theme.of(context).colorScheme.error,
              Theme.of(context).colorScheme.primary,
            ],
            onPressed: () {
              controller.createSettings();
            },
            label: tr('startup.begin'),
          ),
        ],
      ),
    );
  }
}
