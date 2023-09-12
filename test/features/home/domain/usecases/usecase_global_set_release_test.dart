import 'package:expt/expt.dart';
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
import 'usecase_global_set_release_test.mocks.dart';

void main() {
  final serviceOs = MockServiceOs();
  final serviceFile = MockServiceFile();
  final repositoryLocal = MockRepositoryLocalRelease();
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
        path: anyNamed('path'),
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceNoExpt());


      when(repositoryLocal.updateListReleaseState(
        fromState: anyNamed('fromState'),
        toState: anyNamed('toState'),
      )).thenAnswer((_) async =>
          (exception: ExptDataNoExpt(), releases: mockListModelSdkRelease));

      when(repositoryLocal.updateReleaseState(
        id: anyNamed('id'),
        state: anyNamed('state'),
      )).thenAnswer((_) async =>
          (exception: ExptDataNoExpt(), release: mockModelSdkRelease));

      when(repositoryLocal.updateGlobalRelease(any)).thenAnswer((_) async =>
          (exception: ExptDataNoExpt(), release: mockModelSdkRelease));

      final result = await usecaseGlobalSetRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Set global sdk releases if read EnvPath return fail', () async {

      when(serviceOs.readEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
      )).thenReturn((
        list: [mockModelSdkRelease.version],
        exptService: ExptServiceExecute(),
      ));

      when(serviceFile.getAppPath())
          .thenReturn((exptService: ExptServiceNoExpt(), path: '/'));

      when(serviceOs.updateEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceNoExpt());


      when(repositoryLocal.updateListReleaseState(
        fromState: anyNamed('fromState'),
        toState: anyNamed('toState'),
      )).thenAnswer((_) async =>
          (exception: ExptDataNoExpt(), releases: mockListModelSdkRelease));

      when(repositoryLocal.updateReleaseState(
        id: anyNamed('id'),
        state: anyNamed('state'),
      )).thenAnswer((_) async =>
          (exception: ExptDataNoExpt(), release: mockModelSdkRelease));

      when(repositoryLocal.updateGlobalRelease(any)).thenAnswer((_) async =>
          (exception: ExptDataNoExpt(), release: mockModelSdkRelease));

      final result = await usecaseGlobalSetRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceExecute());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Set global sdk releases if get AppPath return fail', () async {

      when(serviceOs.readEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
      )).thenReturn((
        list: [mockModelSdkRelease.version],
        exptService: ExptServiceNoExpt()
      ));

      when(serviceFile.getAppPath())
          .thenReturn((exptService: ExptServiceExecute(), path: '/'));

      when(serviceOs.updateEnvPath(
        path: anyNamed('path'),
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenReturn(ExptServiceNoExpt());


      when(repositoryLocal.updateListReleaseState(
        fromState: anyNamed('fromState'),
        toState: anyNamed('toState'),
      )).thenAnswer((_) async =>
          (exception: ExptDataNoExpt(), releases: mockListModelSdkRelease));

      when(repositoryLocal.updateReleaseState(
        id: anyNamed('id'),
        state: anyNamed('state'),
      )).thenAnswer((_) async =>
          (exception: ExptDataNoExpt(), release: mockModelSdkRelease));

      when(repositoryLocal.updateGlobalRelease(any)).thenAnswer((_) async =>
          (exception: ExptDataNoExpt(), release: mockModelSdkRelease));

      final result = await usecaseGlobalSetRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceExecute());
      expect(result.exptData, ExptDataNoExpt());
    });
  });
}
