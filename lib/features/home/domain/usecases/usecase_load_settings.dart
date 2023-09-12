import 'package:expt/expt.dart';

import '../../../home/domain/entities/settings.dart';
import '../../../home/domain/repositories/repository_local_settings.dart';

class UsecaseLoadSettings {
  final RepositoryLocalSettings repositoryLocal;

  UsecaseLoadSettings(this.repositoryLocal);

  Future<({Settings settings, ExptData exception})> call() async {
    return await repositoryLocal.loadSettings();
  }
}
