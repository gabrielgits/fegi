import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/feature/infra/datasources/data_local.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_settings.dart';
import 'package:fegi/features/home/domain/usecases/usecase_setdefault_settings.dart';
import 'package:fegi/features/home/infra/repositories/repository_local_settings_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../home/infra/models/mock_settings_model.dart';

@GenerateNiceMocks([MockSpec<DataLocal>()])
import 'usecase_setdefault_settings_test.mocks.dart';

void main() {
  final mockDataLocal = MockDataLocal();
  late RepositoryLocalSettings repositoryLocal;
  late UsecaseSetdefaultSettings usecaseDefaultSettings;

  setUp(() {
    repositoryLocal = RepositoryLocalSettingsImpl(mockDataLocal);
    usecaseDefaultSettings = UsecaseSetdefaultSettings(repositoryLocal);
  });

  group('Default Settings Usecase', () {
    test('Delete all Settings without no exception DB', () async {
      when(
        mockDataLocal.deleteAll(any),
      ).thenAnswer((_) async => mockSettingsModel.id);

      final result = await usecaseDefaultSettings.call();

      expect(result.id, mockSettingsModel.id);
      expect(result.exception, ExptDataNoExpt());
    });

    test('Delete all Settings with exception', () async {
      when(
        mockDataLocal.deleteAll(any),
      ).thenThrow((_) async => throwsException);

      final result = await usecaseDefaultSettings.call();

      expect(result.id, 0);
      expect(result.exception, isA<ExptDataDelete>());
    });
  });
}
