import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/states/controller_state.dart';
import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/exceptions/expt_web.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/features/startup/domain/usecases/usecase_download_initial_release.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/settings.dart';
import '../../domain/usecases/usecase_create_initial_settings.dart';
import '../../domain/usecases/usecase_install_initial_release.dart';
import '../../domain/usecases/usecase_setglobal_initial_release.dart';
import '../../infra/models/settings_model.dart';

class ControllerStartup extends ChangeNotifier {
  Settings settings = SettingsModel.newObject();
  ControllerState state = ControllerStateLoaded();
  int step = 1;

  final UsecaseCreateInitialSettings usecaseCreateInitialSettings;
  final UsecaseDownloadInitialReleases usecaseDownloadInitialReleases;
  final UsecaseInstallInitialRelease usecaseInstallInitialRelease;
  final UsecaseSetglobalInitialRelease usecaseSetglobalInitialRelease;

  ControllerStartup({
    required this.usecaseCreateInitialSettings,
    required this.usecaseDownloadInitialReleases,
    required this.usecaseInstallInitialRelease,
    required this.usecaseSetglobalInitialRelease,
  });

  Future<void> createSettings() async {
    final result = await usecaseCreateInitialSettings.call();
    if (result.exptData != ExptDataNoExpt()) {
      state = ControllerStateError();
      notifyListeners();
      throw result.exptData;
    }
    if (result.exptService != ExptServiceNoExpt()) {
      state = ControllerStateError();
      notifyListeners();
      throw result.exptService;
    }
    state = ControllerStateLoaded();
    step = 2;
    notifyListeners();
  }

  Future<void> installSdkRelease(SdkRelease release) async {
  
    state = ControllerStateLoading(
      tr('msn.downloading', namedArgs: {'version': release.version}),
    );
    notifyListeners();
    final resultDownload = await usecaseDownloadInitialReleases.call(release);
    if (resultDownload.exptService != ExptServiceNoExpt()) {
      state = ControllerStateError();
      notifyListeners();
      throw resultDownload.exptService;
    }
    if (resultDownload.exptWeb != ExptWebNoExpt()) {
      state = ControllerStateError();
      notifyListeners();
      throw resultDownload.exptWeb;
    }


    state = ControllerStateLoading(
      tr('msn.installing', namedArgs: {'version': release.version}),
    );
    notifyListeners();
    final resultInstall = await usecaseInstallInitialRelease.call(release);
    if (resultInstall.exptData != ExptDataNoExpt()) {
      state = ControllerStateError(resultInstall.exptData.toString());
      notifyListeners();
      throw resultInstall.exptData;
    }
    if (resultInstall.exptService != ExptServiceNoExpt()) {
      state = ControllerStateError(resultInstall.exptService.toString());
      notifyListeners();
      throw resultInstall.exptService;
    }
    

    state = ControllerStateLoading(
      tr('msn.settingGlobal', namedArgs: {'version': release.version}),
    );
    notifyListeners();
    final resultGlobal = await usecaseSetglobalInitialRelease.call(release);
    if (resultGlobal.exptData != ExptDataNoExpt()) {
      state = ControllerStateError();
      notifyListeners();
      throw resultGlobal.exptData;
    }
    if (resultGlobal.exptService != ExptServiceNoExpt()) {
      state = ControllerStateError();
      notifyListeners();
      throw resultGlobal.exptService;
    }

    state = ControllerStateLoaded();
    step = 3;
    notifyListeners();
  }

  void skip() {
    step = 3;
    notifyListeners();
  }

}
