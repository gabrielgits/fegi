import 'package:expt/expt.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';

import '../repositories/repository_local_release.dart';

class UsecaseLoadReleases {
  final RepositoryLocalRelease repositoryLocal;
  const UsecaseLoadReleases(this.repositoryLocal);
  Future<({List<SdkRelease> releases, ExptData exception})> call() async {
    return await repositoryLocal.loadListRelease();
  }
}