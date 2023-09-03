import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/core/feature/infra/services/service_os.dart';
import 'package:fegi/features/startup/domain/repositories/repository_local_startup.dart';
import 'package:fegi/features/startup/domain/usecases/usecase_setglobal_initial_release.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([
  MockSpec<ServiceOs>(),
  MockSpec<ServiceFile>(),
  MockSpec<RepositoryLocalStartup>(),
])
import 'usecase_setglobal_initial_release_test.mocks.dart';

void main() {
  final serviceOs = MockServiceOs();
  final serviceFile = MockServiceFile();
  final repositoryLocal = MockRepositoryLocalStartup();
  late UsecaseSetglobalInitialRelease usecaseInstallRelease;

  setUp(() {
    usecaseInstallRelease = UsecaseSetglobalInitialRelease(
      serviceOs: serviceOs,
      serviceFile: serviceFile,
      repositoryLocal: repositoryLocal,
    );
  });

  group('Usecase Set Global Release', () {
    test('Set global sdk releases should return no exception', () async {
      when(serviceOs.readEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
      )).thenReturn((
        list: [mockModelSdkRelease.version],
        exptService: ExptServiceNoExpt()
      ));

      when(serviceFile.getAppPath())
          .thenReturn((path: '/', exptService: ExptServiceNoExpt()));

      when(serviceOs.updateEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceNoExpt());

      when(repositoryLocal.createGlobalSdkRelease(any))
          .thenAnswer((_) async => (exception: ExptDataNoExpt(), id: 1));

      final result = await usecaseInstallRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Set global sdk releases if updateEnvPath fails', () async {
      when(serviceOs.readEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
      )).thenReturn((
        list: [mockModelSdkRelease.version],
        exptService: ExptServiceNoExpt()
      ));

      when(serviceFile.getAppPath())
          .thenReturn((path: '/', exptService: ExptServiceNoExpt()));

      when(serviceOs.updateEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceExecute());

      when(repositoryLocal.createGlobalSdkRelease(any))
          .thenAnswer((_) async => (exception: ExptDataNoExpt(), id: 1));

      final result = await usecaseInstallRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceExecute());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Set global sdk releases if createGlobalSdkRelease fails', () async {
            when(serviceOs.readEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
      )).thenReturn((
        list: [mockModelSdkRelease.version],
        exptService: ExptServiceNoExpt()
      ));

      when(serviceFile.getAppPath())
          .thenReturn((path: '/', exptService: ExptServiceNoExpt()));

      when(serviceOs.updateEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceNoExpt());


      when(repositoryLocal.createGlobalSdkRelease(any))
          .thenAnswer((_) async => (exception: ExptDataSave(), id: 1));

      final result = await usecaseInstallRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptData, ExptDataSave());
    });
  });
}
