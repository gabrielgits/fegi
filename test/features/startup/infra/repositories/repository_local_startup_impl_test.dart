import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/feature/infra/datasources/data_local.dart';
import 'package:fegi/features/startup/domain/repositories/repository_local_startup.dart';
import 'package:fegi/features/startup/infra/repositories/repository_local_startup_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
import '../models/mock_settings_model.dart';

@GenerateNiceMocks([MockSpec<DataLocal>()])
import 'repository_local_startup_impl_test.mocks.dart';

void main() {
  final mockDataLocal = MockDataLocal();
  late RepositoryLocalStartup repositoryLocal;

  setUp(() {
    repositoryLocal = RepositoryLocalStartupImpl(mockDataLocal);
  });

  group('Create Settings table', () {
    test('Create Settings table should return id and no exception', () async {
      when(
        mockDataLocal.save(item: anyNamed('item'), table: anyNamed('table')),
      ).thenAnswer((_) async => mockSettingsModel.id);

      final result = await repositoryLocal.createSettings(mockSettingsModel);
      expect(result.exception, ExptDataNoExpt());
      expect(result.id, mockSettingsModel.id);
    });

    test('Create Settings table should return exception if save fails',
        () async {
      when(
        mockDataLocal.save(item: anyNamed('item'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);

      final result = await repositoryLocal.createSettings(mockSettingsModel);
      expect(result.exception, isA<ExptDataSave>());
      expect(result.id, 0);
    });
  });

  group('Create SDKRelease table', () {
    test('Create Global SdkRelease table should return id and no exception',
        () async {
      when(
        mockDataLocal.save(
            item: anyNamed('item'), table: anyNamed('table')),
      ).thenAnswer((_) async => mockModelSdkRelease.id);
      final result =
          await repositoryLocal.createGlobalSdkRelease(mockModelSdkRelease);
      expect(result.exception, ExptDataNoExpt());
      expect(result.id, mockModelSdkRelease.id);
    });
    
    test('Create Global SdkRelease table should return exception if save fails',
        () async {
      when(
        mockDataLocal.save(
            item: anyNamed('item'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);
      final result =
          await repositoryLocal.createGlobalSdkRelease(mockModelSdkRelease);
      expect(result.exception, isA<ExptDataSave>());
      expect(result.id,0);
    });
  });

  group('Create List SdkReleases', () {
    test('Create List SdkReleases table should return 1 and no exception',
        () async {
      // final list = mockListModelSdkRelease.map((e) => e.toMap()).toList();
      when(
        mockDataLocal.saveAll(items: anyNamed('items'), table: anyNamed('table')),
      ).thenAnswer((_) async => Future.value(1));

      final result =
          await repositoryLocal.createListSdkReleases(mockListModelSdkRelease);
      expect(result.exception, ExptDataNoExpt());
      expect(result.count, greaterThan(0));
    });

    test('Create List SdkReleases table should return exception if save fails',
        () async {
      when(
        mockDataLocal.saveAll(items: anyNamed('items'), table: anyNamed('table')),
      ).thenThrow((_) async => throwsException);

      final result =
          await repositoryLocal.createListSdkReleases(mockListModelSdkRelease);
      expect(result.exception, isA<ExptDataSave>());
      expect(result.count, 0);
    });
  });
}
