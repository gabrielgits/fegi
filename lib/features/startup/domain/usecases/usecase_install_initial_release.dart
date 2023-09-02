import 'package:fegi/core/constants.dart';
import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/services/service_compress.dart';

import '../repositories/repository_local_startup.dart';

class UsecaseInstallInitialRelease {
  final RepositoryLocalStartup repositoryLocal;
  final ServiceCompress serviceCompress;
  const UsecaseInstallInitialRelease({
    required this.repositoryLocal,
    required this.serviceCompress,
  });

  Future<({ExptService exptService, ExptData exptData})> call(
      SdkRelease release) async {
    final unziped = await serviceCompress.unzip(
      sourcePath: App.pathSdkFiles + release.file,
      destinationPath: '${App.pathSdk}${release.version}/',
    );
    if (unziped != ExptServiceNoExpt()) {
      return (
        exptService: unziped,
        exptData: ExptDataNoExpt(),
      );
    }

    final localList = await repositoryLocal.createListSdkReleases([release]);
    if (localList.exception != ExptDataNoExpt() || localList.count < 1) {
      return (exptService: ExptServiceNoExpt(), exptData: localList.exception);
    }

    return (exptService: ExptServiceNoExpt(), exptData: ExptDataNoExpt());
  }
}
