import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';

import '../repositories/repository_local_release.dart';

class UsecaseRemoveRelease {
  final RepositoryLocalRelease repositoryLocal;
  const UsecaseRemoveRelease(this.repositoryLocal);

  Future<({ExptData exception, int id})> call(SdkRelease release) async {
    return await repositoryLocal.deleteRelease(release.id);
  }
}
