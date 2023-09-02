import 'package:bform/bform.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ConfigNowWidget extends StatelessWidget {
  const ConfigNowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            tr('msn.noConfig'),
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          BformButton(
            style: BformButtonStyle.outlined,
            colors: [Theme.of(context).colorScheme.primary],
            onPressed: () {
              Navigator.pushNamed(context, '/startup');
            },
            label: tr('home.configNow'),
          ),
        ],
      ),
    );
  }
}
