import 'package:bform/bform.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/setting_form_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorButton = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: BformAppbar(
        title: tr('settings.title'),
        icon: Icons.settings,
      ),
      body: const Padding(
          padding: EdgeInsets.all(10.0), child: SettingsFormWidget()),
      bottomNavigationBar: BformFooter(
        middleChild: BformButton(
          colors: [colorButton],
          style: BformButtonStyle.outlined,
          onPressed: () => Navigator.of(context).pop(),
          label: tr('btn.default'),
        ),
      ),
    );
  }
}
