import 'package:bform/bform.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/presenter/widgets/loading_view_widget.dart';
import 'package:fegi/core/helpers/date_helper.dart';
import 'package:fegi/core/states/controller_state.dart';
import 'package:fegi/core/feature/presenter/widgets/error_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controller_home.dart';
import '../../controllers/system_tray.dart';
import 'action_buttons_widget.dart';

class AvailableReleasesWidget extends StatefulWidget {
  const AvailableReleasesWidget({super.key});

  @override
  State<AvailableReleasesWidget> createState() =>
      _AvailableReleasesWidgetState();
}

class _AvailableReleasesWidgetState extends State<AvailableReleasesWidget> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final controller = context.read<ControllerHome>();
        await controller.loadListReleases();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorHead = Theme.of(context).colorScheme.inversePrimary;
    final colorBody = Theme.of(context).colorScheme.primaryContainer;
    return SizedBox(
      width: 700,
      height: 500,
      child: SingleChildScrollView(
        child: Selector<ControllerHome,
                ({ControllerState state, List<SdkRelease> list})>(
            selector: (context, controller) => (
                  state: controller.controllerState,
                  list: controller.listSdkReleases
                ),
            builder: (context, selectors, _) {
              initSystemTray(context.read<ControllerHome>());
              return switch (selectors.state) {
                ControllerStateLoaded() => BformTableText(
                    titles: [
                      tr('home.sdkVersion'),
                      tr('home.sdkArchitecture'),
                      tr('home.releaseDate'),
                      tr('home.dartVersion'),
                    ],
                    backgroundTitle: colorHead,
                    listElements: selectors.list
                        .map((e) => [
                              e.version,
                              e.architecture,
                              dateHelper(date: e.date),
                              e.dartVersion,
                            ])
                        .toList(),
                    background: colorBody,
                    actionTitle: tr('home.options'),
                    actionButtons: selectors.list
                        .map((e) => ActionButtonsWidget(release: e))
                        .toList(),
                  ),
                ControllerStateLoading() =>
                  LoadingViewWidget(info: selectors.state.toString()),
                ControllerStateEmpty() => Text(
                    tr('msn.noSdk'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                _ => ErrorViewWidget(error: selectors.state.toString()),
              };
            }),
      ),
    );
  }
}
