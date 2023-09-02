import 'package:fegi/core/feature/infra/datasources/data_local.dart';
import 'package:fegi/core/exceptions/expt_data.dart';

import '../../domain/entities/settings.dart';
import '../../domain/repositories/repository_local_settings.dart';

import '../models/settings_model.dart';

class RepositoryLocalSettingsImpl implements RepositoryLocalSettings {
  final DataLocal datasource;
  final tableName = 'settings';
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

}
