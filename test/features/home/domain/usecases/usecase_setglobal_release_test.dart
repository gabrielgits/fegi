import 'package:fegi/core/constants.dart';
import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/core/feature/infra/services/service_os.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_global_set_release.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([
  MockSpec<ServiceOs>(),
  MockSpec<ServiceFile>(),
  MockSpec<RepositoryLocalRelease>(),
])
import 'usecase_setglobal_release_test.mocks.dart';

void main() {
  final serviceOs = MockServiceOs();
  final serviceFile = MockServiceFile();
  final repositoryLocal = MockRepositoryLocalHome();
  late UsecaseGlobalSetRelease usecaseGlobalSetRelease;

  setUp(() {
    usecaseGlobalSetRelease = UsecaseGlobalSetRelease(
      serviceOs: serviceOs,
      serviceFile: serviceFile,
      repositoryLocal: repositoryLocal,
    );
  });

  group('Usecase Set Global Release', () {
    test('Set global sdk releases should return no exception', () async {
      when(serviceOs.updateEnvPath(
        path: App.keyWinPathApp,
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceNoExpt());

      when(serviceOs.readEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
      )).thenReturn((
        list: [mockModelSdkRelease.version],
        exptService: ExptServiceNoExpt()
      ));

      when(serviceFile.getAppPath())
          .thenReturn((exptService: ExptServiceNoExpt(), path: '/'));

      when(serviceOs.updateEnvPath(
        path: App.keyWinPathEnv,
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceNoExpt());

      when(repositoryLocal.updateListReleaseState(
        fromState: anyNamed('fromState'),
        toState: anyNamed('toState'),
      )).thenAnswer((_) async => (exception: ExptDataNoExpt(), releases: mockListModelSdkRelease));

      when(repositoryLocal.updateListReleaseState(
        fromState: anyNamed('fromState'),
        toState: anyNamed('toState'),
      )).thenAnswer((_) async => (exception: ExptDataNoExpt(), releases: mockListModelSdkRelease));

      final result = await usecaseGlobalSetRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Set global sdk releases if updateEnvPath fails', () async {
      when(serviceOs.updateEnvPath(
        path: App.keyWinPathApp,
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceExecute());

      when(serviceOs.readEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
      )).thenReturn((
        list: [mockModelSdkRelease.version],
        exptService: ExptServiceNoExpt()
      ));

      when(serviceFile.getAppPath()).thenReturn((exptService: ExptServiceNoExpt(), path: '/'));

      when(serviceOs.updateEnvPath(
        path: App.keyWinPathEnv,
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceNoExpt());

      when(repositoryLocal.updateListReleaseState(
        fromState: anyNamed('fromState'),
        toState: anyNamed('toState'),
      )).thenAnswer((_) async => (exception: ExptDataNoExpt(), releases: mockListModelSdkRelease));

      final result = await usecaseGlobalSetRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceExecute());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Set global sdk releases if updateEnvPath return empty', () async {
      when(serviceOs.updateEnvPath(
        path: App.keyWinPathApp,
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceNoExpt());

      List<String> emptyList = [];
      when(serviceOs.readEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
      )).thenReturn((
        list: emptyList,
        exptService: ExptServiceNoExpt(),
      ));

      when(serviceFile.getAppPath()).thenReturn((exptService: ExptServiceNoExpt(), path: '/'));

      when(serviceOs.updateEnvPath(
        path: App.keyWinPathEnv,
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceNoExpt());

      when(repositoryLocal.updateListReleaseState(
        fromState: anyNamed('fromState'),
        toState: anyNamed('toState'),
      )).thenAnswer((_) async => (exception: ExptDataNoExpt(), releases: mockListModelSdkRelease));

      final result = await usecaseGlobalSetRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceExecute());
      expect(result.exptData, ExptDataNoExpt());
    });
  });
}
