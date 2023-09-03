import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/helpers/dialog_helper.dart';
import 'package:fegi/features/home/presenter/controllers/controller_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'setting_form_widget.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppbarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ControllerHome>();
    return AppBar(
      backgroundColor: Colors.grey,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(
          image: AssetImage('assets/images/icons/app_icon.png'),
        ),
      ),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: tr('home.settings'),
          onPressed: () async {
            bool dialog = await dialogHelper(
              title: tr('settings.title'),
              context: context,
              content: const SettingsFormWidget(),
              yesButton: tr('btn.save'),
              noButton: tr('btn.cancel'),
            );
            if (dialog) {
              await controller.changeSettings();
              if (controller.settings.currentLang == 1) {
                context.setLocale(const Locale('en', 'US'));
              } else {
                context.setLocale(const Locale('pt', 'PT'));
              }
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
