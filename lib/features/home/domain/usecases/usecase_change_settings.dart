import 'package:expt/expt.dart';

import '../../../home/domain/entities/settings.dart';
import '../../../home/domain/repositories/repository_local_settings.dart';

class UsecaseChangeSettings {
  final RepositoryLocalSettings repositoryLocal;

  UsecaseChangeSettings(this.repositoryLocal);

  Future<({int id, ExptData exception})> call(Settings item) async {
    return await repositoryLocal.updateSettings(item);
  }
}
