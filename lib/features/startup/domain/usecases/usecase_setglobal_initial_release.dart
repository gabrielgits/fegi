import 'package:fegi/core/constants.dart';
import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/core/feature/infra/services/service_os.dart';

import '../repositories/repository_local_startup.dart';

class UsecaseSetglobalInitialRelease {
  final ServiceOs serviceOs;
  final ServiceFile serviceFile;
  final RepositoryLocalStartup repositoryLocal;
  const UsecaseSetglobalInitialRelease({
    required this.serviceOs,
    required this.serviceFile,
    required this.repositoryLocal,
  });

  Future<({ExptService exptService, ExptData exptData})> call(
      SdkRelease release) async {
    final keys = serviceOs.readEnvPath(
      path: App.keyWinPathEnv,
      key: App.keyPath,
    );
    if (keys.exptService != ExptServiceNoExpt()) {
      return (exptService: keys.exptService, exptData: ExptDataNoExpt());
    }

    if (keys.list.isEmpty) {
      return (exptService: ExptServiceUnknown(), exptData: ExptDataNoExpt());
    }

    final appPath = serviceFile.getAppPath();
    if (appPath.exptService != ExptServiceNoExpt()) {
      return (exptService: appPath.exptService, exptData: ExptDataNoExpt());
    }

    keys.list.removeWhere(
      (element) => element.contains(appPath.path) || element.isEmpty,
    );
    String path = '${appPath.path}/${App.pathSdk}${release.version}/flutter/bin;';
    keys.list.add(path.replaceAll('/', '\\'));
    String keysValue = keys.list.join(';');

    final updateEnv = serviceOs.updateEnvPath(
      path: App.keyWinPathEnv,
      key: App.keyPath,
      value: keysValue,
    );
    if (updateEnv != ExptServiceNoExpt()) {
      return (exptService: updateEnv, exptData: ExptDataNoExpt());
    }

    final localData = await repositoryLocal.createGlobalSdkRelease(release);
    if (localData.exception != ExptDataNoExpt() || localData.id < 1) {
      return (exptService: ExptServiceNoExpt(), exptData: localData.exception);
    }

    return (exptService: ExptServiceNoExpt(), exptData: ExptDataNoExpt());
  }
}
