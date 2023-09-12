import 'package:expt/expt.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';

import '../repositories/repository_local_release.dart';

class UsecaseImportReleases {
  final RepositoryLocalRelease repositoryLocal;
  const UsecaseImportReleases(this.repositoryLocal);

  Future<({int count, ExptData exception})> call(List<SdkRelease> releases) async {
    return await repositoryLocal.addListReleases(releases);
  }
}
