import 'package:fegi/core/constants.dart';
import 'package:expt/expt.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/core/states/sdk_state.dart';


import '../repositories/repository_local_release.dart';

class UsecaseDeleteRelease {
  final RepositoryLocalRelease repositoryLocal;
  final ServiceFile serviceFile;
  const UsecaseDeleteRelease({
    required this.repositoryLocal,
    required this.serviceFile,
  });

  Future<({ExptData exptData, ExptService exptService})> call(SdkRelease release) async {
    final deleted = serviceFile.deleteFile(App.pathSdkFiles + release.file);
    if (deleted != ExptServiceNoExpt()) {
      return (exptData: ExptDataNoExpt(), exptService: deleted);
    }
    final localData = await repositoryLocal.updateReleaseState(id: release.id, state: SdkState.available);
    if (localData.exception != ExptDataNoExpt()) {
      return (exptData: localData.exception, exptService: ExptServiceNoExpt());
    }
    return (exptData: ExptDataNoExpt(), exptService: ExptServiceNoExpt());
  }
}
