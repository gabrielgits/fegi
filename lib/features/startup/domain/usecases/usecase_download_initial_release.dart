import 'package:fegi/core/constants.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/exceptions/expt_web.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';

import '../repositories/repository_remote_startup.dart';

class UsecaseDownloadInitialReleases {
  final RepositoryRemoteStartup repositoryRemote;
  final ServiceFile serviceFile;
  const UsecaseDownloadInitialReleases({
    required this.repositoryRemote,
    required this.serviceFile,
  });

  Future<({ExptWeb exptWeb, ExptService exptService})> call(
      SdkRelease release) async {
    final remoteData = await repositoryRemote.downloadFile(App.urlGoogle+release.link);
    if (remoteData.exception != ExptWebNoExpt() || remoteData.data.isEmpty) {
      return (exptWeb: remoteData.exception, exptService: ExptServiceNoExpt());
    }

    final savePath = App.pathSdkFiles + release.file;
    final saved = serviceFile.saveFile(
      savePath: savePath,
      fileData: remoteData.data,
    );
    if (saved != ExptServiceNoExpt()) {
      return (exptWeb: ExptWebNoExpt(), exptService: saved);
    }
    remoteData.data.clear();

    return (exptWeb: ExptWebNoExpt(), exptService: ExptServiceNoExpt());
  }
}
