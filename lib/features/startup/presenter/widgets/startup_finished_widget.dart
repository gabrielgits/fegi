import 'package:bform/bform.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/features/home/presenter/controllers/controller_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartupFinishedWidget extends StatelessWidget {
  const StartupFinishedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            tr('msn.finishConfig'),
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          Text(
            tr('msn.finishConfig2'),
            textAlign: TextAlign.center,
          ),
          BformButton(
            style: BformButtonStyle.outlined,
            fontSize: 18,
            colors: [Theme.of(context).colorScheme.primary],
            onPressed: () {
              context.read<ControllerHome>().loadSettings();
              Navigator.pop(context);
            },
            label: tr('startup.finish'),
          ),
        ],
      ),
    );
  }
}
