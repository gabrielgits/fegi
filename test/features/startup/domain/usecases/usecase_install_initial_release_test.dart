import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/infra/services/service_compress.dart';
import 'package:fegi/features/startup/domain/repositories/repository_local_startup.dart';
import 'package:fegi/features/startup/domain/usecases/usecase_install_initial_release.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([
  MockSpec<RepositoryLocalStartup>(),
  MockSpec<ServiceCompress>(),
])
import 'usecase_install_initial_release_test.mocks.dart';

void main() {
  final serviceCompress = MockServiceCompress();
  final repositoryLocal = MockRepositoryLocalStartup();
  late UsecaseInstallInitialRelease usecaseInstallRelease;

  setUp(() {
    usecaseInstallRelease = UsecaseInstallInitialRelease(
      serviceCompress: serviceCompress,
      repositoryLocal: repositoryLocal,
    );
  });

  group('Usecase Install Release', () {
    test('Install initial sdk releases should return no exception', () async {
      when(serviceCompress.unzip(
        sourcePath: anyNamed('sourcePath'),
        destinationPath: anyNamed('destinationPath'),
      )).thenAnswer((_) async => (ExptServiceNoExpt()));

      when(repositoryLocal.createListSdkReleases(any))
          .thenAnswer((_) async => (count: 1, exception: ExptDataNoExpt()));

      when(repositoryLocal.createGlobalSdkRelease(any)).thenAnswer((_) async =>
          (id: mockModelSdkRelease.id, exception: ExptDataNoExpt()));

      final result = await usecaseInstallRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Install initial sdk releases if unzip fails', () async {
      when(serviceCompress.unzip(
        sourcePath: anyNamed('sourcePath'),
        destinationPath: anyNamed('destinationPath'),
      )).thenAnswer((_) async => ExptServiceExecute());

      when(repositoryLocal.createListSdkReleases(any))
          .thenAnswer((_) async => (count: 1, exception: ExptDataNoExpt()));

      when(repositoryLocal.createGlobalSdkRelease(any)).thenAnswer((_) async =>
          (id: mockModelSdkRelease.id, exception: ExptDataNoExpt()));

      final result = await usecaseInstallRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceExecute());
      expect(result.exptData, ExptDataNoExpt());
    });

    test('Install initial sdk releases if createListSdkReleases fails',
        () async {
      when(serviceCompress.unzip(
        sourcePath: anyNamed('sourcePath'),
        destinationPath: anyNamed('destinationPath'),
      )).thenAnswer((_) async => (ExptServiceNoExpt()));

      when(repositoryLocal.createListSdkReleases(any))
          .thenAnswer((_) async => (count: 0, exception: ExptDataLoad()));

      when(repositoryLocal.createGlobalSdkRelease(any)).thenAnswer((_) async =>
          (id: mockModelSdkRelease.id, exception: ExptDataNoExpt()));

      final result = await usecaseInstallRelease.call(mockModelSdkRelease);

      expect(result.exptService, ExptServiceNoExpt());
      expect(result.exptData, ExptDataLoad());
    });

  });
}
