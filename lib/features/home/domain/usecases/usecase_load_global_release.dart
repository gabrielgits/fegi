import 'package:expt/expt.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';

import '../repositories/repository_local_release.dart';

class UsecaseLoadGlobalRelease {
  final RepositoryLocalRelease repositoryLocal;
  const UsecaseLoadGlobalRelease(this.repositoryLocal);
  Future<({SdkRelease release, ExptData exception})> call() async {
    return await repositoryLocal.loadGlobalRelease();
  }
}