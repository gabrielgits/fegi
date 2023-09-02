import 'package:bform/bform.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/presenter/widgets/loading_view_widget.dart';
import 'package:fegi/core/helpers/date_helper.dart';
import 'package:fegi/core/states/controller_state.dart';
import 'package:fegi/core/feature/presenter/widgets/error_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controller_home.dart';

class GetsdkTableWidget extends StatefulWidget {
  const GetsdkTableWidget({super.key});

  @override
  State<GetsdkTableWidget> createState() => _GetsdkTableWidgetState();
}

class _GetsdkTableWidgetState extends State<GetsdkTableWidget> {
  late ControllerHome controller;
  List<SdkRelease> listRemote = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        controller = context.read<ControllerHome>();
        listRemote = await controller.getRemoteListReleases();
        controller.listSelected.clear();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorHead = Theme.of(context).colorScheme.inversePrimary;
    final colorBody = Theme.of(context).colorScheme.primaryContainer;


    return SizedBox(
      width: 600,
      height: 400,
      child: SingleChildScrollView(
        child: Selector<ControllerHome, ControllerState>(
            selector: (context, controller) => controller.controllerState,
            builder: (context, controllerState, _) {
              return switch (controllerState) {
                ControllerStateLoaded() || ControllerStateEmpty() => BformTable(
                    headers: [
                      Text(tr('home.sdkVersion')),
                      Text(tr('home.sdkArchitecture')),
                      Text(tr('home.releaseDate')),
                      Text(tr('home.dartVersion')),
                    ],
                    colorHeader: colorHead,
                    rows: listRemote
                        .map((e) => [
                              BformCheckbox(
                                inicialState: false,
                                label: e.version,
                                onChange: (value) {
                                  if (value) {
                                    controller.listSelected.add(e);
                                  } else {
                                    controller.listSelected.remove(e);
                                  }
                                },
                              ),
                              //Text(e.version),
                              Text(e.architecture),
                              Text(dateHelper(date: e.date)),
                              Text(e.dartVersion),
                            ])
                        .toList(),
                    color: colorBody,
                  ),
                ControllerStateLoading() =>
                  LoadingViewWidget(info: controllerState.toString()),
                _ => ErrorViewWidget(error: controllerState.toString()),
              };
            }),
      ),
    );
  }
}
