import 'package:expt/expt.dart';
import 'package:fegi/core/constants.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/core/states/sdk_state.dart';
import 'package:fegi/features/home/domain/repositories/repository_remote_release.dart';

import '../repositories/repository_local_release.dart';

class UsecaseDownloadReleases {
  final RepositoryLocalRelease repositoryLocal;
  final RepositoryRemoteRelease repositoryRemote;
final ServiceFile serviceFile;
  const UsecaseDownloadReleases({
    required this.repositoryLocal,
    required this.repositoryRemote,
    required this.serviceFile,
  });

  Future<({ExptWeb exptWeb, ExptData exptData})> call(
      SdkRelease release) async {
      final remoteData = await repositoryRemote.downloadFile(App.urlGoogle+release.link);
      if (remoteData.exception != ExptWebNoExpt() || remoteData.data.isEmpty) {
        return (exptWeb: remoteData.exception, exptData: ExptDataNoExpt());
      }

      final savePath = App.pathSdkFiles + release.file;
      final saved = serviceFile.saveFile(savePath: savePath, fileData: remoteData.data);
      if (saved != ExptServiceNoExpt()) {
        return (exptWeb: ExptWebUnknown(saved.toString()), exptData: ExptDataUnknown(saved.toString()));
      } 
      //remoteData.data.clear();

      final localData = await repositoryLocal.updateReleaseState(
          id: release.id, state: SdkState.downloaded);
      if (localData.exception != ExptDataNoExpt()) {
        return (exptWeb: ExptWebNoExpt(), exptData: localData.exception);
      }
      return (exptWeb: ExptWebNoExpt(), exptData: ExptDataNoExpt());
  }
}
