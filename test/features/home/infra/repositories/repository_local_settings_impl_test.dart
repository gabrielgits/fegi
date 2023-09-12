import 'package:expt/expt.dart';
import 'package:fegi/core/feature/infra/datasources/data_local.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_settings.dart';
import 'package:fegi/features/home/infra/repositories/repository_local_settings_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../home/infra/models/mock_settings_model.dart';

@GenerateNiceMocks([MockSpec<DataLocal>()])
import 'repository_local_settings_impl_test.mocks.dart';

void main() {
  final mockDataLocal = MockDataLocal();
  late RepositoryLocalSettings repositoryLocal;

  setUp(() {
    repositoryLocal = RepositoryLocalSettingsImpl(mockDataLocal);
  });

  group('Get Settings from repository', () {
    test('getItem should return Model', () async {

      when(
        mockDataLocal.getItem(id: anyNamed('id'), table: anyNamed('table')),
      ).thenAnswer((_) async => mockSettingsModel.toMap());

      final result = await repositoryLocal.loadSettings();
      expect(result.exception, ExptDataNoExpt());
      expect(result.settings, mockSettingsModel);
    });

    test('getItem should return exception if getItem fails', () async {

      when(
        mockDataLocal.getItem(id: anyNamed('id'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);

      final result = await repositoryLocal.loadSettings();
      expect(result.exception, isA<ExptDataLoad>());
      expect(result.settings.id, 0);
    });
  });

  group('Update Settings in repository', () {
    test('updateItem should return Settings id', () async {

      when(
        mockDataLocal.update(item: anyNamed('item'), table: anyNamed('table')),
      ).thenAnswer((_) async => mockSettingsModel.id);

      final result = await repositoryLocal.updateSettings(mockSettingsModel);
      expect(result.id, mockSettingsModel.id);
      expect(result.exception, ExptDataNoExpt());
    });
    test('updateItem should return exception if update fails', () async {

      when(
        mockDataLocal.update(item: anyNamed('item'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);

      final result = await repositoryLocal.updateSettings(mockSettingsModel);
      expect(result.id, 0);
      expect(result.exception, isA<ExptDataSave>());
    });
  });
}
