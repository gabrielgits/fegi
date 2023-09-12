import 'package:expt/expt.dart';
import 'package:fegi/core/constants.dart';

import '../../../../core/feature/domain/entities/sdk_release.dart';
import '../repositories/repository_remote_release.dart';

class UsecaseGetListReleases {
  final RepositoryRemoteRelease repositoryRemote;
  const UsecaseGetListReleases(this.repositoryRemote);

  Future<({List<SdkRelease> releases, ExptWeb exception})> call() async {
    return await repositoryRemote.getListReleases(App.urlGoogleWinApi);
  }
}
