import 'package:fegi/core/constants.dart';
import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/exceptions/expt_web.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/core/states/sdk_state.dart';

import '../../../../core/feature/domain/entities/sdk_release.dart';
import '../repositories/repository_local_release.dart';
import '../repositories/repository_remote_release.dart';

class UseCaseDownloadAllReleases {
  final RepositoryLocalRelease repositoryLocal;
  final ServiceFile serviceFile;
  final RepositoryRemoteRelease repositoryRemote;
  const UseCaseDownloadAllReleases({
    required this.repositoryLocal,
    required this.serviceFile,
    required this.repositoryRemote,
  });
  Future<({ExptWeb exptWeb, ExptData exptData})> call() async {
    final record = await repositoryLocal.loadListRelease();
    if (record.releases.isEmpty) {
      return (exptWeb: ExptWebNoExpt(), exptData: ExptDataLoad());
    }

    for (SdkRelease release in record.releases) {
      if (release.state != SdkState.available) continue;

      final remoteData = await repositoryRemote.downloadFile(release.link);
      if (remoteData.exception != ExptWebNoExpt() || remoteData.data.isEmpty) {
        return (exptWeb: remoteData.exception, exptData: ExptDataNoExpt());
      }

      final savePath = App.pathSdkFiles + release.file;
      final saved =
          serviceFile.saveFile(savePath: savePath, fileData: remoteData.data);
      if (saved != ExptServiceNoExpt()) {
        return (
          exptWeb: ExptWebUnknown(saved.toString()),
          exptData: ExptDataUnknown(saved.toString()),
        );
      }
      //remoteData.data.clear();
    }

    final localData = await repositoryLocal.updateListReleaseState(
      fromState: SdkState.available,
      toState: SdkState.downloaded,
    );
    if (localData.exception != ExptDataNoExpt()) {
      return (exptWeb: ExptWebNoExpt(), exptData: localData.exception);
    }

    return (
      exptWeb: ExptWebNoExpt(),
      exptData: ExptDataNoExpt(),
    );
  }
}
