import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/constants.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/core/states/sdk_state.dart';

import '../repositories/repository_local_release.dart';

class UsecaseUninstallRelease {
  final RepositoryLocalRelease repositoryLocal;
  final ServiceFile serviceFile;
  const UsecaseUninstallRelease({
    required this.repositoryLocal,
    required this.serviceFile,
  });

  Future<({ExptService exptService, ExptData exptData})> call(SdkRelease release) async {

    final deleted =
        serviceFile.deleteFolder('${App.pathSdk}${release.version}/');
    if (deleted != ExptServiceNoExpt()) {
      return (exptService: deleted, exptData: ExptDataNoExpt());
    }

    final localData = await repositoryLocal.updateReleaseState(
      id: release.id,
      state: SdkState.downloaded,
    );
    if (localData.exception != ExptDataNoExpt()) {
      return (exptService: ExptServiceNoExpt(), exptData: localData.exception);
    }

    return (exptService: ExptServiceNoExpt(), exptData: ExptDataNoExpt());
  }
}
