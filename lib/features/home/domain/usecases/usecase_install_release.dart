
import 'package:fegi/core/constants.dart';
import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/services/service_compress.dart';
import 'package:fegi/core/states/sdk_state.dart';

import '../repositories/repository_local_release.dart';

class UsecaseInstallRelease {
  final RepositoryLocalRelease repositoryLocal;
  final ServiceCompress serviceCompress;
  const UsecaseInstallRelease({
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

    final localList = await repositoryLocal.updateReleaseState(id: release.id, state: SdkState.installed);
    if (localList.exception != ExptDataNoExpt()) {
      return (exptService: ExptServiceNoExpt(), exptData: localList.exception);
    }

    return (exptService: ExptServiceNoExpt(), exptData: ExptDataNoExpt());
  }
}
