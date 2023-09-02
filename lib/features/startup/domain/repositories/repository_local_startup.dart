

import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';

import '../entities/settings.dart';

abstract class RepositoryLocalStartup {
  Future<({int id, ExptData exception})> createSettings(Settings settings);
  Future<({int count, ExptData exception})> createListSdkReleases(List<SdkRelease> releases);
  Future<({int id, ExptData exception})> createGlobalSdkRelease(SdkRelease release);
}