

import 'package:fegi/core/exceptions/expt_data.dart';

import '../entities/settings.dart';

abstract class RepositoryLocalSettings {
  Future<({Settings settings, ExptData exception})> loadSettings();
  Future<({int id, ExptData exception})> updateSettings(Settings settings);
  Future<({int id, ExptData exception})> deleteSettings();
}