

import 'package:expt/expt.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';

import '../entities/settings.dart';

abstract class RepositoryLocalSettings {
  Future<({Settings settings, ExptData exception})> loadSettings();
  Future<({int id, ExptData exception})> updateSettings(Settings settings);
  Future<({int id, ExptData exception})> deleteSettings();

    Future<({int id, ExptData exception})> createSettings(Settings settings);
  Future<({int count, ExptData exception})> createListSdkReleases(List<SdkRelease> releases);
}