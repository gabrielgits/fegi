import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/infra/services/service_os.dart';
import 'package:fegi/features/startup/domain/repositories/repository_local_startup.dart';
import 'package:fegi/features/startup/domain/usecases/usecase_create_initial_settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../infra/models/mock_settings_model.dart';

@GenerateNiceMocks([
  MockSpec<RepositoryLocalStartup>(),
  MockSpec<ServiceOs>(),
])
import 'usecase_create_initial_settings_test.mocks.dart';

void main() {
  final serviceOs = MockServiceOs();
  final repositoryLocal = MockRepositoryLocalStartup();
  late UsecaseCreateInitialSettings usecaseCreateInitialSettings;

  setUp(() {
    usecaseCreateInitialSettings = UsecaseCreateInitialSettings(
        repositoryLocal: repositoryLocal, serviceOs: serviceOs);
  });

  group(' Usecase Create Initial Settings', () {

    test('Create initial settings should return id and no exception', () async {

          when(serviceOs.createEnvPath(
      path: anyNamed('path'),
      key: anyNamed('key'),
      value: anyNamed('value'),
    )).thenReturn(ExptServiceNoExpt());

      when(repositoryLocal.createSettings(any))
          .thenAnswer((_) async => (id: mockSettingsModel.id, exception: ExptDataNoExpt()));
      
      when(repositoryLocal.createListSdkReleases(any))
          .thenAnswer((_) async => (count: 1, exception: ExptDataNoExpt()));

      final result = await usecaseCreateInitialSettings.call();

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Create initial settings should return exception if createEnvPath fails',
        () async {
          when(serviceOs.createEnvPath(
      path: anyNamed('path'),
      key: anyNamed('key'),
      value: anyNamed('value'),
    )).thenReturn(ExptServiceExecute());

      when(repositoryLocal.createSettings(any))
          .thenAnswer((_) async => (id: mockSettingsModel.id, exception: ExptDataNoExpt()));

      final result = await usecaseCreateInitialSettings.call();

      expect(result.exptService, ExptServiceExecute());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Create initial settings should return exception if createSettings fails',
        () async {
          when(serviceOs.createEnvPath(
      path: anyNamed('path'),
      key: anyNamed('key'),
      value: anyNamed('value'),
    )).thenReturn(ExptServiceNoExpt());

      when(repositoryLocal.createSettings(any))
          .thenAnswer((_) async => (id: 0, exception: ExptDataSave()));

      final result = await usecaseCreateInitialSettings.call();

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptData, ExptDataSave());
    });
  });
}
