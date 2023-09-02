import 'package:fegi/core/constants.dart';
import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/core/feature/infra/services/service_os.dart';
import 'package:fegi/core/states/sdk_state.dart';

import '../repositories/repository_local_release.dart';

class UsecaseGlobalSetRelease {
  final ServiceOs serviceOs;
  final ServiceFile serviceFile;
  final RepositoryLocalRelease repositoryLocal;
  const UsecaseGlobalSetRelease({
    required this.repositoryLocal,
    required this.serviceOs,
    required this.serviceFile,
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
    String path = '${appPath.path}/${App.pathSdk}${release.version};';
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

    final exptData = await repositoryLocal.updateListReleaseState(
      fromState: SdkState.global,
      toState: SdkState.installed,
    );
    if (exptData.exception != ExptDataNoExpt()) {
      return (exptService: ExptServiceNoExpt(), exptData: exptData.exception);
    }

    final newRelease = await repositoryLocal.updateReleaseState(
        id: release.id, state: SdkState.global);
    if (newRelease.exception != ExptDataNoExpt()) {
      return (exptService: ExptServiceNoExpt(), exptData: newRelease.exception);
    }

    final localData = await repositoryLocal.updateGlobalRelease(release);
    if (localData.exception != ExptDataNoExpt() || localData.release.id < 1) {
      return (exptService: ExptServiceNoExpt(), exptData: localData.exception);
    }

    return (exptService: ExptServiceNoExpt(), exptData: ExptDataNoExpt());
  }
}
