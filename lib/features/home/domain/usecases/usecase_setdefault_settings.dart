import 'package:fegi/core/exceptions/expt_data.dart';

import '../../../home/domain/repositories/repository_local_settings.dart';

class UsecaseSetdefaultSettings {
  final RepositoryLocalSettings repositoryLocal;

  UsecaseSetdefaultSettings(this.repositoryLocal);

  Future<({int id, ExptData exception})> call() async {
    return await repositoryLocal.deleteSettings();
  }
}
