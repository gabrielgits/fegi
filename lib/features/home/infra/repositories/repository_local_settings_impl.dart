import 'package:feds/feds.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:expt/expt.dart';
import 'package:fegi/core/feature/infra/models/sdk_release_model.dart';

import '../../domain/entities/settings.dart';
import '../../domain/repositories/repository_local_settings.dart';

import '../models/settings_model.dart';

class RepositoryLocalSettingsImpl implements RepositoryLocalSettings {
  final FedsLocal datasource;
  final tableName = 'settings';
  final tableNameList = 'releases';
  const RepositoryLocalSettingsImpl(this.datasource);

  @override
  Future<({Settings settings, ExptData exception})> loadSettings() async {
    try {
      final item = await datasource.getItem(table: tableName, id: 0);
      return (
        settings: SettingsModel.fromMap(item),
        exception: ExptDataNoExpt()
      );
    } catch (e) {
      return (
        settings: SettingsModel.newObject(),
        exception: ExptDataLoad(e.toString())
      );
    }
  }

  @override
  Future<({int id, ExptData exception})> updateSettings(Settings item) async {
    try {
      final record = (
        id: await datasource.update(
            item: SettingsModel.fromEntity(item).toMap(), table: tableName),
        exception: ExptDataNoExpt(),
      );
      return record;
    } catch (e) {
      return (id: 0, exception: ExptDataSave(e.toString()));
    }
  }
  
  @override
  Future<({ExptData exception, int id})> deleteSettings() async {
    try {
      final record = (
        id: await datasource.deleteAll(tableName),
        exception: ExptDataNoExpt(),
      );
      return record;
    } catch (e) {
      return (id: 0, exception: ExptDataDelete(e.toString()));
    }
  }

    @override
  Future<({int id, ExptData exception})> createSettings(
      Settings settings) async {
    try {
      final record = (
        id: await datasource.save(
            item: SettingsModel.fromEntity(settings).toMap(),
            table: tableName),
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
            table: tableNameList, items: list),
        exception: ExptDataNoExpt(),
      );
      return record;
    } catch (e) {
      return (count: 0, exception: ExptDataSave(e.toString()));
    }
  }


}
