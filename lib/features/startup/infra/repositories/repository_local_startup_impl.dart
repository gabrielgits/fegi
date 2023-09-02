import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/datasources/data_local.dart';
import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/feature/infra/models/sdk_release_model.dart';

import '../../domain/entities/settings.dart';

import '../../domain/repositories/repository_local_startup.dart';
import '../models/settings_model.dart';

class RepositoryLocalStartupImpl implements RepositoryLocalStartup {
  final DataLocal datasource;
  final tableSettingsName = 'settings';
  final tableListSdkReleasesName = 'releases';
  final tableGlobalSdkReleaseName = 'global_release';
  const RepositoryLocalStartupImpl(this.datasource);

  @override
  Future<({int id, ExptData exception})> createSettings(
      Settings settings) async {
    try {
      final record = (
        id: await datasource.save(
            item: SettingsModel.fromEntity(settings).toMap(),
            table: tableSettingsName),
        exception: ExptDataNoExpt(),
      );
      return record;
    } catch (e) {
      return (id: 0, exception: ExptDataSave(e.toString()));
    }
  }

  @override
  Future<({int count, ExptData exception})> createListSdkReleases(
      List<SdkRelease> releases) async {
    try {
      final list =
          releases.map((e) => SdkReleaseModel.fromEntity(e).toMap()).toList();
      final record = (
        count: await datasource.saveAll(
            table: tableListSdkReleasesName, items: list),
        exception: ExptDataNoExpt(),
      );
      return record;
    } catch (e) {
      return (count: 0, exception: ExptDataSave(e.toString()));
    }
  }

  @override
  Future<({ExptData exception, int id})> createGlobalSdkRelease(
      SdkRelease sdkVersion) async {
    try {
      final record = (
        id: await datasource.save(
            item: SdkReleaseModel.fromEntity(sdkVersion).toMap(),
            table: tableGlobalSdkReleaseName),
        exception: ExptDataNoExpt(),
      );
      return record;
    } catch (e) {
      return (id: 0, exception: ExptDataSave(e.toString()));
    }
  }
}
