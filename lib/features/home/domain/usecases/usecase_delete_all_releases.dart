import 'package:fegi/core/constants.dart';
import 'package:expt/expt.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import '../repositories/repository_local_release.dart';

class UseCaseDeleteAllReleases {
  final RepositoryLocalRelease repositoryLocal;
  final ServiceFile serviceFile;
  const UseCaseDeleteAllReleases({
    required this.repositoryLocal,
    required this.serviceFile,
  });

  Future<({ExptService exptService, ExptData exptData})> call() async {
    final record = await repositoryLocal.loadListRelease();
    if (record.exception != ExptDataNoExpt()) {
      return (exptService: ExptServiceNoExpt(), exptData: record.exception);
    }


    for (final release in record.releases) {
      final deleted = serviceFile.deleteFile(App.pathSdkFiles + release.file);
      if (deleted != ExptServiceNoExpt()) {
        return (
          exptService: deleted,
          exptData: ExptDataNoExpt(),
        );
      }
    }

    final localData = await repositoryLocal.deleteAllRelease();
    if (localData.exception != ExptDataNoExpt()) {
      return (exptService: ExptServiceNoExpt(), exptData: localData.exception);
    }
    return (exptService: ExptServiceNoExpt(), exptData: ExptDataNoExpt());
  }
}
