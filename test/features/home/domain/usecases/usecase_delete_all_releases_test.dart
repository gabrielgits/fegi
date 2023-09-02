import 'package:fegi/core/exceptions/expt_data.dart';
import 'package:fegi/core/exceptions/expt_service.dart';
import 'package:fegi/core/feature/domain/entities/sdk_release.dart';
import 'package:fegi/core/feature/infra/services/service_file.dart';
import 'package:fegi/features/home/domain/repositories/repository_local_release.dart';
import 'package:fegi/features/home/domain/usecases/usecase_delete_all_releases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/infra/models/mock_models_sdkrelease.dart';
@GenerateNiceMocks([
  MockSpec<ServiceFile>(),
  MockSpec<RepositoryLocalRelease>(),
])
import 'usecase_delete_all_releases_test.mocks.dart';

void main() {
  final serviceFile = MockServiceFile();
  final repositoryLocal = MockRepositoryLocalHome();
  late UseCaseDeleteAllReleases usecaseDeleteAllVersion;

  setUp(() {
    usecaseDeleteAllVersion = UseCaseDeleteAllReleases(
      repositoryLocal: repositoryLocal,
      serviceFile: serviceFile,
    );
  });

  group('UseCase Delete All Releases', () {
    test('Delete All SdkVersions from local data without no exception',
        () async {
      when(repositoryLocal.loadListRelease()).thenAnswer((_) async =>
          (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));

      when(serviceFile.deleteFile(any)).thenReturn(ExptServiceNoExpt());

      when(repositoryLocal.deleteAllRelease())
          .thenAnswer((_) async => (count: 1, exception: ExptDataNoExpt()));

      final result = await usecaseDeleteAllVersion.call();
      expect(result.exptData, ExptDataNoExpt());
      expect(result.exptService, ExptServiceNoExpt());
    });

    test('Delete All SdkVersions from local data if has exception to load list',
        () async {
      List<SdkRelease> emptyList = [];
      when(repositoryLocal.loadListRelease()).thenAnswer(
          (_) async => (releases: emptyList, exception: ExptDataLoad()));

      when(serviceFile.deleteFile(any)).thenReturn(ExptServiceNoExpt());

      when(repositoryLocal.deleteAllRelease())
          .thenAnswer((_) async => (count: 1, exception: ExptDataNoExpt()));

      final result = await usecaseDeleteAllVersion.call();
      expect(result.exptData, ExptDataLoad());
      expect(result.exptService, ExptServiceNoExpt());
    });

    test(
        'Delete All SdkVersions from local data if has exception to delete files',
        () async {
      when(repositoryLocal.loadListRelease()).thenAnswer((_) async =>
          (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));

      when(serviceFile.deleteFile(any)).thenReturn(ExptServiceExecute());

      when(repositoryLocal.deleteAllRelease())
          .thenAnswer((_) async => (count: 1, exception: ExptDataNoExpt()));

      final result = await usecaseDeleteAllVersion.call();
      expect(result.exptData, ExptDataNoExpt());
      expect(result.exptService, ExptServiceExecute());
    });

    test(
        'Delete All SdkVersions from local data if has exception to delete all data',
        () async {
      when(repositoryLocal.loadListRelease()).thenAnswer((_) async =>
          (releases: mockListModelSdkRelease, exception: ExptDataNoExpt()));

      when(serviceFile.deleteFile(any)).thenReturn(ExptServiceNoExpt());

      when(repositoryLocal.deleteAllRelease())
          .thenAnswer((_) async => (count: 0, exception: ExptDataDelete()));

      final result = await usecaseDeleteAllVersion.call();
      expect(result.exptData, ExptDataDelete());
      expect(result.exptService, ExptServiceNoExpt());
    });
  });
}
