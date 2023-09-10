import 'package:fegi/core/constants.dart';
import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/infra/services/service_os.dart';

import '../entities/settings.dart';
import '../repositories/repository_local_settings.dart';

class UsecaseCreateInitialSettings {
  final RepositoryLocalSettings repositoryLocal;
  final ServiceOs serviceOs;

  UsecaseCreateInitialSettings(
      {required this.repositoryLocal, required this.serviceOs});

  Future<({ExptService exptService, ExptData exptData})> call() async {
    final exptService = serviceOs.createEnvPath(
        path: App.keyWinPathApp, key: App.keyPath, value: '');
    if (exptService != ExptServiceNoExpt()) {
      return (exptService: exptService, exptData: ExptDataNoExpt());
    }

    const settings = Settings(
      id: 1,
      globalSdkId: 0,
      editor: 1,
      projectsFolder: App.pathProjects,
      windowsStart: true,
      startMini: false,
      currentLang: 1,
    );
    final localData = await repositoryLocal.createSettings(settings);
    if (localData.exception != ExptDataNoExpt() || localData.id < 1) {
      return (exptService: ExptServiceNoExpt(), exptData: localData.exception);
    }

    final localList = await repositoryLocal.createListSdkReleases([]);
    if (localList.exception != ExptDataNoExpt() || localList.count < 1) {
      return (exptService: ExptServiceNoExpt(), exptData: localList.exception);
    }

    return (exptService: ExptServiceNoExpt(), exptData: ExptDataNoExpt());
  }
}
