import 'package:bform/bform.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/feature/presenter/widgets/loading_view_widget.dart';
import 'package:fegi/core/states/controller_state.dart';
import 'package:fegi/features/home/presenter/controllers/controller_home.dart';
import 'package:flutter/material.dart';
import 'package:ftcontrol/ftcontrol.dart';
import 'package:provider/provider.dart';

import '../controllers/form_lists.dart';

class SettingsFormWidget extends StatefulWidget {
  const SettingsFormWidget({super.key});

  @override
  State<SettingsFormWidget> createState() => _SettingsFormWidgetState();
}

class _SettingsFormWidgetState extends State<SettingsFormWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final controller = context.read<ControllerHome>();
        await controller.loadSettings();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ControllerHome, ControllerState>(
      selector: (context, controller) => controller.globalState,
      builder: (context, globalState, _) {
        final controller = context.read<ControllerHome>();
        return switch (globalState) {
          ControllerStateLoading() => LoadingViewWidget(
              info: globalState.toString(),
            ),
          ControllerStateEmpty() => Column(children: [
              Text(
                tr('msn.noConfig'),
              ),
              const SizedBox(height: 10),
              BformButton(
                  label: tr('btn.back'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]),
          ControllerStateLoaded() => BformForm(
              width: 300,
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              child: Column(
                children: [
                  /*
              BformCheckbox(
                label: tr('settings.runStartup'),
                inicialState: controller.settings.windowsStart,
                onChange: (value) {
                  controller.settings = controller.settings.copyWith(
                    windowsStart: value,
                  );
                },
                
              ),
              const SizedBox(height: 10),
              */
                  BformCheckbox(
                    label: tr('settings.startupMinimized'),
                    onChange: (value) {
                      controller.settings = controller.settings.copyWith(
                        startMini: value,
                      );
                    },
                    inicialState: controller.settings.startMini,
                  ),
                  const SizedBox(height: 10),
                  BformGroupRadio(
                    label: tr('settings.languages'),
                    listItems: listLanguages,
                    item: listLanguages.firstWhere(
                      (element) =>
                          element.id == controller.settings.currentLang,
                      orElse: () => listLanguages.first,
                    ),
                    onChange: (item) {
                      controller.settings = controller.settings.copyWith(
                        currentLang: item.id,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  /*
                        BformSelect(
                            label: tr('settings.editors'),
                            listItems: listEditors,
                            item: listEditors[controller.settings.editor],
                            onChange: (item) {},
                            color: Colors.black12),
                        const SizedBox(height: 10),
                        
                  Row(
                    children: [
                      FormTextInput(
                        title: tr('settings.projectsFolder'),
                        defaultValue: controller.Settings.projectsFolder,
                        readOnly: true,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.update),
                      ),
                    ],
                  )
                  */
                ],
              ),
            ),
          _ => FtcontrolView(
              text: globalState.toString(),
              type: FtcontrolType.warning,
            ),
        };
      },
    );
  }
}
