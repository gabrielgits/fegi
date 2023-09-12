
import 'package:expt/expt.dart';
import 'package:fegi/core/feature/infra/models/sdk_release_model.dart';
import 'package:fegi/core/feature/infra/services/service_compress.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_install_release.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([
  MockSpec<RepositoryLocalRelease>(),
  MockSpec<ServiceCompress>(),
])
import 'usecase_install_release_test.mocks.dart';

void main() {
  final serviceCompress = MockServiceCompress();
  final repositoryLocal = MockRepositoryLocalRelease();
  late UsecaseInstallRelease usecaseInstallRelease;

  setUp(() {
    usecaseInstallRelease = UsecaseInstallRelease(
      serviceCompress: serviceCompress,
      repositoryLocal: repositoryLocal,
    );
  });

  group('Usecase Install Release', () {
    test('Install sdk releases should return no exception', () async {
      when(serviceCompress.unzip(
        sourcePath: anyNamed('sourcePath'),
        destinationPath: anyNamed('destinationPath'),
      )).thenAnswer((_) async => ExptServiceNoExpt());

      when(repositoryLocal.updateReleaseState(id: anyNamed('id'), state: anyNamed('state')))
          .thenAnswer((_) async => (release: mockModelSdkRelease, exception: ExptDataNoExpt()));

      final result = await usecaseInstallRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Install sdk releases if has exception to unzip', () async {
      when(serviceCompress.unzip(
        sourcePath: anyNamed('sourcePath'),
        destinationPath: anyNamed('destinationPath'),
      )).thenAnswer((_) async => ExptServiceExecute());

      when(repositoryLocal.updateReleaseState(id: anyNamed('id'), state: anyNamed('state')))
          .thenAnswer((_) async => (release: mockModelSdkRelease, exception: ExptDataNoExpt()));

      final result = await usecaseInstallRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceExecute());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Install sdk releases if has exception to update release state', () async {
      when(serviceCompress.unzip(
        sourcePath: anyNamed('sourcePath'),
        destinationPath: anyNamed('destinationPath'),
      )).thenAnswer((_) async => ExptServiceNoExpt());

      when(repositoryLocal.updateReleaseState(id: anyNamed('id'), state: anyNamed('state')))
          .thenAnswer((_) async => (release: SdkReleaseModel.newObject(), exception: ExptDataSave()));

      final result = await usecaseInstallRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptData, ExptDataSave());
    });
    test('Install sdk releases if has exception to update release state', () async {
      when(serviceCompress.unzip(
        sourcePath: anyNamed('sourcePath'),
        destinationPath: anyNamed('destinationPath'),
      )).thenAnswer((_) async => ExptServiceNoExpt());

      when(repositoryLocal.updateReleaseState(id: anyNamed('id'), state: anyNamed('state')))
          .thenAnswer((_) async => (release: SdkReleaseModel.newObject(), exception: ExptDataSave()));

      final result = await usecaseInstallRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptData, ExptDataSave());
    });

  });
}