import 'package:easy_localization/easy_localization.dart';
import 'package:fegi/core/feature/infra/models/sdk_release_model.dart';
import 'package:fegi/core/states/controller_state.dart';
import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/exceptions/expt_web.dart';
import 'package:fegi/core/states/sdk_state.dart';
import 'package:fegi/features/home/domain/usecases/usecase_delete_all_releases.dart';
import 'package:fegi/features/home/domain/usecases/usecase_delete_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_download_all_releases.dart';
import 'package:fegi/features/home/domain/usecases/usecase_download_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_get_list_releases.dart';
import 'package:fegi/features/home/domain/usecases/usecase_global_remove_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_import_releases.dart';
import 'package:fegi/features/home/domain/usecases/usecase_install_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_load_global_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_load_releases.dart';
import 'package:fegi/features/home/domain/usecases/usecase_global_set_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_remove_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_uninstall_release.dart';
import 'package:flutter/material.dart';

import '../../../../core/feature/domain/entities/sdk_release.dart';
import '../../domain/entities/settings.dart';
import '../../domain/usecases/usecase_change_settings.dart';
import '../../domain/usecases/usecase_load_settings.dart';
import '../../domain/usecases/usecase_setdefault_settings.dart';
import '../../infra/models/settings_model.dart';

class ControllerHome extends ChangeNotifier {
  List<SdkRelease> listSdkReleases = [];
  List<SdkRelease> listSelected = [];
  SdkRelease globalRelease = SdkReleaseModel.newObject();
  ControllerState globalState = ControllerStateEmpty();
  ControllerState controllerState = ControllerStateEmpty();
  Settings settings = SettingsModel.newObject();
  //Settings usecase
  final UsecaseChangeSettings usecaseChangeSettings;
  final UsecaseSetdefaultSettings usecaseDefaultSettings;
  final UsecaseLoadSettings usecaseLoadSettings;
  //Release usecases
  final UsecaseDeleteRelease usecaseDeleteRelease;
  final UseCaseDeleteAllReleases usecaseDeleteAllRelease;
  final UsecaseDownloadReleases usecaseDownloadRelease;
  final UseCaseDownloadAllReleases usecaseDownloadAllRelease;
  final UsecaseGetListReleases usecaseGetListReleases;
  final UsecaseImportReleases usecaseImportReleases;
  final UsecaseInstallRelease usecaseInstallRelease;
  final UsecaseUninstallRelease usecaseUninstallRelease;
  final UsecaseLoadReleases usecaseLoadReleases;
  final UsecaseLoadGlobalRelease usecaseLoadGlobalRelease;
  final UsecaseGlobalSetRelease usecaseSetglobalRelease;
  final UsecaseGlobalRemoveRelease usecaseGlobalRemoveRelease;
  final UsecaseRemoveRelease usecaseRemoveRelease;

  ControllerHome({
    //Settings usecases
    required this.usecaseChangeSettings,
    required this.usecaseDefaultSettings,
    required this.usecaseLoadSettings,
    //Release usecases
    required this.usecaseDeleteRelease,
    required this.usecaseDeleteAllRelease,
    required this.usecaseDownloadRelease,
    required this.usecaseDownloadAllRelease,
    required this.usecaseGetListReleases,
    required this.usecaseImportReleases,
    required this.usecaseInstallRelease,
    required this.usecaseUninstallRelease,
    required this.usecaseLoadReleases,
    required this.usecaseLoadGlobalRelease,
    required this.usecaseSetglobalRelease,
    required this.usecaseGlobalRemoveRelease,
    required this.usecaseRemoveRelease,
  });

  //-------------Setting-----------------

  Future<Settings> loadSettings() async {
    globalState = ControllerStateLoading(tr('settings.loading'));
    //notifyListeners();
    final result = await usecaseLoadSettings.call();
    if (result.exception != ExptDataNoExpt()) {
      globalState = ControllerStateError(result.exception.toString());
      notifyListeners();
     // throw result.exception;
     return SettingsModel.newObject();
    }
    globalState = ControllerStateLoaded();
    settings = result.settings;
    notifyListeners();
    return settings;
  }

  Future<void> changeSettings() async {
    controllerState = ControllerStateLoading(tr('settings.updating'));
    notifyListeners();
    final result = await usecaseChangeSettings.call(settings);
    if (result.exception != ExptDataNoExpt()) {
      controllerState = ControllerStateError(result.exception.toString());
      notifyListeners();
      throw result.exception;
    }
    loadSettings();
  }

  Future<void> defaultSettings() async {
    controllerState = ControllerStateLoading(tr('settings.setdefault'));
    notifyListeners();
    final result = await usecaseDefaultSettings.call();
    if (result.exception != ExptDataNoExpt()) {
      controllerState = ControllerStateError(result.exception.toString());
      notifyListeners();
      throw result.exception;
    }
    loadSettings();
  }

  //-----------Global Release-----------------

  Future<void> loadGlobalRelease() async {
    final result = await usecaseLoadGlobalRelease.call();
    if (result.exception != ExptDataNoExpt()) {
      globalState = ControllerStateError(result.exception.toString());
      notifyListeners();
      return;
    }
    globalState = ControllerStateLoaded();
    globalRelease = result.release;
    notifyListeners();
  }

  Future<void> globalSet(SdkRelease release) async {
    final result = await usecaseSetglobalRelease.call(release);
    if (result.exptData != ExptDataNoExpt()) {
      controllerState = ControllerStateError(result.exptData.toString());
      notifyListeners();
      throw result.exptData;
    }
    if (result.exptService != ExptServiceNoExpt()) {
      controllerState = ControllerStateError(result.exptService.toString());
      notifyListeners();
      throw result.exptService;
    }
    globalRelease = release;
    loadListReleases();
  }

  Future<void> globalRemove(SdkRelease release) async {
    final result = await usecaseGlobalRemoveRelease.call(release);
    if (result.exptData != ExptDataNoExpt()) {
      controllerState = ControllerStateError(result.exptData.toString());
      notifyListeners();
      throw result.exptData;
    }
    if (result.exptService != ExptServiceNoExpt()) {
      controllerState = ControllerStateError(result.exptService.toString());
      notifyListeners();
      throw result.exptService;
    }
    globalRelease = SdkReleaseModel.newObject();
    loadListReleases();
  }

  //-----------Available Releases-----------------

  Future<void> loadListReleases() async {
    controllerState = ControllerStateLoading(tr('msn.loadingList'));
    notifyListeners();
    final result = await usecaseLoadReleases.call();
    if (result.exception != ExptDataNoExpt()) {
      controllerState = ControllerStateError(result.exception.toString());
      notifyListeners();
      throw result.exception;
    }
    if (result.releases.isEmpty) {
      controllerState = ControllerStateEmpty();
      notifyListeners();
      return;
    }
    listSdkReleases = result.releases;
    controllerState = ControllerStateLoaded();
    notifyListeners();
    //return 1;
  }

  Future<void> removeSdkRelease(SdkRelease release) async {
    controllerState = ControllerStateLoading(
      tr('msn.removing', namedArgs: {'version': release.version}),
    );
    notifyListeners();
    final result = await usecaseRemoveRelease.call(release);
    if (result.exception != ExptDataNoExpt()) {
      controllerState = ControllerStateError(result.exception.toString());
      notifyListeners();
      throw result.exception;
    }
    loadListReleases();
  }

  Future<void> downloadSdkRelease(SdkRelease release) async {
    controllerState = ControllerStateLoading(
      tr('msn.downloading', namedArgs: {'version': release.version}),
    );
    notifyListeners();
    final result = await usecaseDownloadRelease.call(release);
    if (result.exptData != ExptDataNoExpt()) {
      controllerState = ControllerStateError(result.exptData.toString());
      notifyListeners();
      throw result.exptData;
    }
    if (result.exptWeb != ExptWebNoExpt()) {
      controllerState = ControllerStateError(result.exptWeb.toString());
      notifyListeners();
      throw result.exptWeb;
    }
  }

  Future<void> deleteSdkRelease(SdkRelease release) async {
    controllerState = ControllerStateLoading(
      tr('msn.deleting', namedArgs: {'version': release.version}),
    );
    notifyListeners();
    final result = await usecaseDeleteRelease.call(release);
    if (result.exptData != ExptDataNoExpt()) {
      controllerState = ControllerStateError(result.exptData.toString());
      notifyListeners();
      throw result.exptData;
    }
    if (result.exptService != ExptServiceNoExpt()) {
      controllerState = ControllerStateError(result.exptService.toString());
      notifyListeners();
      throw result.exptService;
    }
    //loadListReleases();
  }

  Future<void> installSdkRelease(SdkRelease release) async {
    controllerState = ControllerStateLoading(
      tr('msn.installing', namedArgs: {'version': release.version}),
    );
    notifyListeners();
    final result = await usecaseInstallRelease.call(release);
    if (result.exptData != ExptDataNoExpt()) {
      controllerState = ControllerStateError(result.exptData.toString());
      notifyListeners();
      throw result.exptData;
    }
    if (result.exptService != ExptServiceNoExpt()) {
      controllerState = ControllerStateError(result.exptService.toString());
      notifyListeners();
      throw result.exptService;
    }
    loadListReleases();
  }

  Future<void> uninstallSdkRelease(SdkRelease release) async {
    controllerState = ControllerStateLoading(
      tr('msn.uninstalling', namedArgs: {'version': release.version}),
    );
    notifyListeners();
    final result = await usecaseUninstallRelease.call(release);
    if (result.exptData != ExptDataNoExpt()) {
      controllerState = ControllerStateError(result.exptData.toString());
      notifyListeners();
      throw result.exptData;
    }
    if (result.exptService != ExptServiceNoExpt()) {
      controllerState = ControllerStateError(result.exptService.toString());
      notifyListeners();
      throw result.exptService;
    }
    loadListReleases();
  }

  Future<List<SdkRelease>> getRemoteListReleases() async {
    controllerState = ControllerStateLoading();
    notifyListeners();
    final result = await usecaseGetListReleases.call();
    if (result.exception != ExptWebNoExpt()) {
      controllerState = ControllerStateError(result.exception.toString());
      notifyListeners();
      throw result.exception;
    }
    controllerState = ControllerStateLoaded();
    notifyListeners();
    return result.releases.where((element) {
      DateTime dt1 = DateTime.parse(element.date);
      DateTime dt2 = DateTime.parse("2021-03-02T17:51:02.649408Z");
      return element.channel == 'stable' && dt1.compareTo(dt2) > 0;
    }).toList();
  }

  Future<void> importReleases() async {
    controllerState = ControllerStateLoading(tr('msn.importing'));
    notifyListeners();
    final result = await usecaseImportReleases.call(listSelected);
    if (result.exception != ExptDataNoExpt()) {
      controllerState = ControllerStateError(result.exception.toString());
      notifyListeners();
      throw result.exception;
    }
    loadListReleases();
  }

  Future<void> downloadAllReleases() async {
    for (SdkRelease release in listSdkReleases) {
      if (release.state == SdkState.available) {
        await downloadSdkRelease(release);
        //controllerState = ControllerStateLoaded();
        //notifyListeners();
      }
    }
    loadListReleases();
  }

  Future<void> deleteAllReleases() async {
    for (SdkRelease release in listSdkReleases) {
      if (release.state == SdkState.downloaded) {
        await deleteSdkRelease(release);
      }
    }
    loadListReleases();
  }
}
